import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_drive/models/add_trip.dart';
import 'package:taxi_drive/models/add_user_location.dart';
import 'package:taxi_drive/models/send_driver_state.dart';
import 'package:taxi_drive/models/show_trip.dart';
import 'package:taxi_drive/models/trip_model_for_socket.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/hostting.dart';
import 'package:taxi_drive/screen/auth/auth_controller.dart';
import 'package:taxi_drive/screen/trip/widget/buttom_sheet.dart';
import 'package:taxi_drive/screen/trip/widget/map.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_drive/widget/button_primary.dart';
import 'package:taxi_drive/widget/progress_def.dart';
import 'package:taxi_drive/widget/route_sheet.dart';
import 'package:taxi_drive/widget/snackbar_def.dart';
import 'package:url_launcher/url_launcher.dart';

class TripController extends GetxController {
  //for map
  CameraPosition? cam;
  Set<Marker> mark = {};
  Set<Polyline> polyline = {};
  List<LatLng> listPostionForPolyline = [];
  List<DropdownMenuItem<int?>> listLoction = [];
  //for start and end trip
  LatLng? startPostion;
  LatLng? endPostion;
  int? textStartPostion;
  int? textEndPostion;
  RxBool? isStart;
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  // for trip
  String? masafa;
  String? time;
  String? price;
  String? carStat;
  BuildContext? context;
  TripModelForSocket? tripUserAdd;
  String? driverBalance;

  @override
  void onInit() async {
    var storg = GetStorage();
    var role = storg.read('role');
    await getFavoritLocation();
    await getUserTrips();
    if (startPostion == null) {
      await checkPermission();
      var loc = await Geolocator.getCurrentPosition();
      startPostion = LatLng(loc.latitude, loc.longitude);
    }
    if (role == 'user') {
      await routeTrip();
    } else {
      await getDriverBalance();
    }
    super.onInit();
  }

  Future<void> getDriverBalance() async {
    var storeg = GetStorage();
    var id = storeg.read('id');
    http.Response response = await http.get(HosttingTaxi.getDriver(id),
        headers: HosttingTaxi().getHeader());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      driverBalance =
          double.parse(body['balance'].toString()).toStringAsFixed(2);
      update();
    }
  }

  Future<void> addTripMarker(LatLng pos) async {
    var icG = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'lib/asset/images/from_pin.png',
    );
    var icY = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'lib/asset/images/to_pin.png',
    );
    if (isStart != null) {
      mark.add(
        Marker(
          markerId:
              isStart!.value ? const MarkerId("satrt") : const MarkerId("end"),
          position: pos,
          icon: isStart!.value ? icG : icY,
        ),
      );
      var info = "lat:${pos.latitude} log:${pos.longitude}";
      if (isStart!.value) {
        startPostion = pos;
        start.text = info;
      } else {
        endPostion = pos;
        end.text = info;
      }
      if (startPostion != null && endPostion != null) {
        addPolyLine("test");
      }
      update();
    }
  }

  Future<List<ShowTrip>> getUserTrips() async {
    http.Response response = await http.get(HosttingTaxi.getUserTrip,
        headers: HosttingTaxi().getHeader());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<ShowTrip> list = [];
      for (var element in body) {
        var trip = ShowTrip.fromJson(element);
        if (trip.ended == null) {
          var tr = trip;
          var icon = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(),
            'lib/asset/images/trip2.png',
          );
          startPostion = LatLng(tr.fromLate, tr.fromLong);
          endPostion = LatLng(tr.toLate, tr.toLong);
          addPolyLine(tr.id.toString());
          mark.add(
            Marker(
              markerId: MarkerId(tr.id.toString()),
              position: LatLng(tr.fromLate, tr.fromLong),
              icon: icon,
            ),
          );
          update();
        }
        list.add(trip);
      }
      return list;
    }
    return List.empty();
  }

  Future<bool> addUserLocation(UserLocation location) async {
    http.Response response = await http.post(HosttingTaxi.addUserLocation,
        headers: HosttingTaxi().getHeader(),
        body: jsonEncode(location.toJson()));
    if (response.statusCode == 200 && jsonDecode(response.body)["message"]) {
      return true;
    }
    return false;
  }

  Future<bool?> acceptedTrip(int tripId) async {
    var storge = GetStorage();
    http.Response response = await http.post(
        HosttingTaxi.acceptedTrip(tripId, storge.read('id')),
        headers: HosttingTaxi().getHeader());
    if (response.statusCode == 200) {
      var b = jsonDecode(response.body)['message'];
      if (b.toString() == 'true') {
        await getDriverBalance();
        return true;
      } else {
        if (b.toString().contains('The Balance not Enough')) {
          return null;
        }
      }
    }
    return false;
  }

  Future<bool> endTrip(int id) async {
    http.Response response = await http.put(HosttingTaxi.endedTrip(id),
        headers: HosttingTaxi().getHeader());
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return false;
  }

  Future<void> getTripForDriver() async {
    var g = await Geolocator.getCurrentPosition();
    http.Response response = await http.get(
        HosttingTaxi.getAllTripForDriver(g.latitude, g.longitude),
        headers: HosttingTaxi().getHeader());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var element in body) {
        var trip = TripModelForSocket.fromJson(element);
        await addTripInMap(trip);
      }
      update();
    }
  }

  Future<void> getFavoritLocation() async {
    http.Response response = await http.get(HosttingTaxi.getUserLocation,
        headers: HosttingTaxi().getHeader());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        'lib/asset/images/location-pin.gif',
      );
      for (var element in body) {
        UserLocation loc = UserLocation.frommJson(element);
        var mar = Marker(
            markerId: MarkerId(loc.id!.toString()),
            position: LatLng(loc.lat, loc.long),
            infoWindow: InfoWindow(title: loc.name),
            icon: icon,
            onTap: () {
              if (isStart != null) {
                addTripMarker(LatLng(loc.lat, loc.long));
              }
            });

        mark.add(mar);
      }
      update();
    }
  }

  Future<bool?> addTripToDB() async {
    if (startPostion == null || endPostion == null || price == null) {
      return false;
    }
    var trip = AddTrip(
        fromLate: startPostion!.latitude.toString(),
        fromLong: startPostion!.longitude.toString(),
        toLate: endPostion!.latitude.toString(),
        toLong: endPostion!.longitude.toString(),
        price: double.parse(price!).toString());
    http.Response response = await http.post(HosttingTaxi.addTrip,
        headers: HosttingTaxi().getHeader(), body: jsonEncode(trip.toJson()));
    if (response.statusCode == 200 && jsonDecode(response.body)["message"]) {
      return true;
    }
    var b =
        (jsonDecode(response.body)["message"]).toString().contains('forbidden');
    if (b) {
      Get.back();
      Get.back();
      return null;
    }
    return false;
  }

  Future<void> addPolyLine(String name) async {
    if (startPostion != null && endPostion != null) {
      Get.dialog(const ProgressDef());
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          HosttingTaxi.mapKey,
          PointLatLng(startPostion!.latitude, startPostion!.longitude),
          PointLatLng(endPostion!.latitude, endPostion!.longitude));
      listPostionForPolyline.clear();
      for (var element in result.points) {
        listPostionForPolyline
            .addNonNull(LatLng(element.latitude, element.longitude));
      }
      start.text = result.startAddress!;
      end.text = result.endAddress!;
      masafa = result.distance;
      time = result.duration;
      price = await priceCalculation(result);
      polyline.add(
        Polyline(
          polylineId: PolylineId(name),
          points: listPostionForPolyline,
          width: 6,
          color: Colors.blueAccent,
        ),
      );
      Get.back();
      update();
    }
  }

  Future<String?> priceCalculation(PolylineResult result) async {
    AuthController authController = Get.find();
    if (authController.cityInfo == null) {
      await authController.checkToken();
    }
    double s = Geolocator.distanceBetween(
        startPostion!.latitude,
        startPostion!.longitude,
        authController.cityInfo!.cityCenterLate,
        authController.cityInfo!.cityCenterLong);
    double e = Geolocator.distanceBetween(
        endPostion!.latitude,
        endPostion!.longitude,
        authController.cityInfo!.cityCenterLate,
        authController.cityInfo!.cityCenterLong);
    if (s <= authController.cityInfo!.farFromCity &&
        e <= authController.cityInfo!.farFromCity) {
      return ((result.distanceValue! /
                  1000 *
                  authController.cityInfo!.innerPrice) +
              authController.cityInfo!.plusPrice)
          .toInt()
          .toString();
    } else {
      return ((result.distanceValue! /
                  1000 *
                  authController.cityInfo!.outerPrice) +
              authController.cityInfo!.plusPrice)
          .toInt()
          .toString();
    }
  }

  Future<void> getPosition() async {
    await checkPermission();
    var loc = await Geolocator.getCurrentPosition();
    cam = CameraPosition(
      target: LatLng(loc.latitude, loc.longitude),
      zoom: 15,
    );
    update();
  }

  Future<void> checkPermission() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
  }

  Future<void> getListLocation() async {
    listLoction = [
      const DropdownMenuItem<int?>(
        value: null,
        child: Text("موقعي الحالي"),
      ),
      DropdownMenuItem(
        value: -1,
        onTap: () {
          Get.off(const MapScreen(title: "title"));
        },
        child: const Text("إختيار موقع من الخريطة"),
      )
    ];
  }

  Future<void> addMyloction(double lat, double long) async {
    var icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'lib/asset/images/myLocation.png');
    mark.add(
      Marker(
        markerId: const MarkerId("my"),
        position: LatLng(lat, long),
        icon: icon,
      ),
    );
    update();
  }

  Future<void> onTapTrip(TripModelForSocket trip) async {
    startPostion = LatLng(trip.fromLate, trip.fromLong);
    endPostion = LatLng(trip.toLate, trip.toLong);
    addPolyLine(trip.id.toString());
  }

  Future<void> addTripInMap(TripModelForSocket trip) async {
    var icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'lib/asset/images/red-flag.gif',
    );
    mark.add(
      Marker(
        markerId: MarkerId(trip.id.toString()),
        position: LatLng(trip.fromLate, trip.fromLong),
        icon: icon,
        onTap: () async => await clickInTrip(trip),
      ),
    );
  }

  Future<void> clickInTrip(TripModelForSocket trip) async {
    await onTapTrip(trip);
    startPostion = LatLng(trip.fromLate, trip.fromLong);
    endPostion = LatLng(trip.toLate, trip.toLong);
    await addPolyLine(trip.id.toString());
    await buttomSheet(
      heig: 300,
      context: context!,
      headerText: "معلومات الرحلة",
      contener: Column(
        children: [
          Text(
              "نقطة البداية: ${start.text} \n نقطة النهاية: ${end.text} \n اجور التوصيل: ${trip.price}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(ColorManager.primary)),
                  onPressed: () async {
                    var b = await acceptedTrip(trip.id);
                    if (b != null) {
                      if (b) {
                        Get.back();
                        snackbarDef("ملاحظة", "تم قبول الطلب بنجاح");
                        var iconFrom = await BitmapDescriptor.fromAssetImage(
                          const ImageConfiguration(),
                          'lib/asset/images/from_pin.png',
                        );
                        var iconTo = await BitmapDescriptor.fromAssetImage(
                          const ImageConfiguration(),
                          'lib/asset/images/to_pin.png',
                        );
                        mark.removeWhere((element) => true);
                        mark.add(Marker(
                            markerId: const MarkerId("from"),
                            position: LatLng(trip.fromLate, trip.fromLong),
                            icon: iconFrom,
                            onTap: () async => clickMarketTrip(trip)));
                        mark.add(Marker(
                            markerId: const MarkerId("to"),
                            position: LatLng(trip.toLate, trip.toLong),
                            icon: iconTo,
                            onTap: () async => clickMarketTrip(trip)));
                        update();
                      }
                    } else {
                      Get.dialog(AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () => Get.back(),
                              child: const Text(
                                'موافق',
                                style: TextStyle(color: ColorManager.red),
                              ))
                        ],
                        title: const Text('تحذير'),
                        content: const Text(
                            'عذراً لا تملك رصيد كافي لقبول هذه الرحلة الرجاء شحن رصيد'),
                      ));
                    }
                  },
                  child: const Text("قبول")),
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("إلغاء"))
            ],
          ),
        ],
      ),
    );
  }

  Future<void> clickMarketTrip(TripModelForSocket trip) async {
    Get.dialog(
      AlertDialog(
        actions: [
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(ColorManager.red)),
              onPressed: () async {
                await endTrip(trip.id);
                Get.back();
              },
              child: const Text("انهاء")),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(ColorManager.primary)),
              onPressed: () async {
                if (await canLaunchUrl(Uri.parse('tel:+${trip.phone}'))) {
                  launchUrl(Uri.parse('tel:+${trip.phone}'));
                }
              },
              child: const Text("اتصال")),
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("إلغاء"))
        ],
        title: const Text("معلومات المستخدم"),
        content: Text(
            "الاسم: ${trip.username} \n رقم المبايل: ${trip.phone} \n نقطة البداية: ${start.text} \n نقطة النهاية: ${end.text} \n اجور التوصيل: ${trip.price}"),
      ),
    );
  }

  Future<bool> deleteTrip(int id) async {
    http.Response response = await http.delete(HosttingTaxi.deleteTrip(id),
        headers: HosttingTaxi().getHeader());
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }
    return false;
  }

  Future<void> addMarkerFromSocket(dynamic data) async {
    var body = jsonDecode(data);
    if (body['event'] == "App\\Events\\TripDeleteEvent" ||
        body['event'] == "App\\Events\\TripOrderEvent" ||
        body['event'] == "App\\Events\\ChangeStatusDriverEvent") {
      var storeg = GetStorage();
      var dat = jsonDecode(body['data']);
      if (storeg.read('role') == 'driver') {
        if (body['event'] == "App\\Events\\TripDeleteEvent") {
          mark.removeWhere(
              (element) => element.markerId.value == dat['trip_id'].toString());
          update();
        } else {
          if (body['event'] == "App\\Events\\TripOrderEvent") {
            var trip = TripModelForSocket.fromJson(dat['trip_data']);
            if (trip.status == 'available') {
              await addTripInMap(trip);
              update();
            } else {
              if (trip.status == 'selected') {
                mark.removeWhere(
                    (element) => element.markerId.value == trip.id.toString());
                update();
              }
            }
          }
        }
      } else {
        if (storeg.read('role') == 'user') {
          if (body['event'] == "App\\Events\\ChangeStatusDriverEvent") {
            var car = SendDriverStateModel.fromJson(dat['data']);
            BitmapDescriptor icon;
            if (car.state == 'busy') {
              icon = await BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(),
                'lib/asset/images/car_not_free.png',
              );
            } else {
              icon = await BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(),
                'lib/asset/images/car_free.png',
              );
            }
            mark.add(Marker(
              markerId: MarkerId(car.id),
              position: LatLng(double.parse(car.late), double.parse(car.long)),
              onTap: () async {
                if (tripUserAdd != null && tripUserAdd!.id == car.tripId) {
                  icon = await BitmapDescriptor.fromAssetImage(
                      const ImageConfiguration(), 'lib/asset/images/myCar.png');
                  Get.dialog(
                    AlertDialog(
                      actions: [
                        ButtonPrimary(
                            press: () {
                              Get.back();
                            },
                            text: 'موافق')
                      ],
                      title: const Text('معلومات السائق'),
                      content: Text(
                          'اسم السائق: ${car.firstName} ${car.lastName}\nرقم الجوال: ${car.phone}\nلون السيارة: ${car.carColor}\nنوع السيارة: ${car.carType}\nرقم اللوحة: ${car.carNumber}'),
                    ),
                  );
                }
              },
              icon: icon,
            ));
            update();
          } else {
            if (body['event'] == "App\\Events\\TripOrderEvent") {
              var trip = TripModelForSocket.fromJson(dat['trip_data']);
              var storeg = GetStorage();
              if (trip.phone == storeg.read('phone')) {
                if (trip.status == 'available') {
                  tripUserAdd = trip;
                } else {
                  if (trip.status == 'selected') {
                    Get.back();
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  Future<dynamic> routeTrip() async {
    http.Response response = await http.get(
        headers: HosttingTaxi().getHeader(), HosttingTaxi.getLastTrip);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body['message'] != 'Rating') {
        if (body['message']['trip_id'] != null &&
            body['message']['driver_id'] != null) {
          Get.bottomSheet(RouteSheet(
            driverId: body['message']['driver_id'].toString(),
            tripId: body['message']['trip_id'].toString(),
          ));
        }
      }
    }
  }

  Future<bool> sendRouteTrip(double route, int idTrip, int idDriver) async {
    http.Response response = await http.post(
        HosttingTaxi.rating(route, idTrip, idDriver),
        headers: HosttingTaxi().getHeader());
    if (response.statusCode == 200) {
      Get.back();
      return jsonDecode(response.body)['message'];
    }
    return false;
  }
}
