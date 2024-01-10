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
import 'package:taxi_drive/res/hostting.dart';
import 'package:taxi_drive/screen/trip/widget/map.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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

  @override
  void onInit() async {
    await getFavoritLocation();
    await getTripForDriver();
    await getUserTrips();
    if (startPostion == null) {
      await checkPermission();
      var loc = await Geolocator.getCurrentPosition();
      startPostion = LatLng(loc.latitude, loc.longitude);
    }
    super.onInit();
  }

  Future<void> addTripMarker(LatLng pos) async {
    var icG = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    var icY = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
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

  Future<bool> acceptedTrip(int tripId) async {
    var storge = GetStorage();
    http.Response response = await http.put(
        HosttingTaxi.acceptedTrip(tripId, storge.read('id')),
        headers: HosttingTaxi().getHeader());
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
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
      WebSocketChannel channel =
          IOWebSocketChannel.connect(HosttingTaxi.websocket);
      channel.sink.add(HosttingTaxi.openSocket);
      var icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        'lib/asset/images/trip2.png',
      );
      var body = jsonDecode(response.body);
      for (var element in body) {
        var trip = TripModelForSocket.fromJson(element);
        mark.add(
          Marker(
            markerId: MarkerId(trip.id.toString()),
            position: LatLng(trip.fromLate, trip.fromLong),
            icon: icon,
            // onTap: () async {
            //   await onTapTrip(trip, channel);
            //   // startPostion = LatLng(trip.fromLate, trip.fromLong);
            //   // endPostion = LatLng(trip.toLate, trip.toLong);
            //   // addPolyLine(trip.id);
            //   // if (!trip.isAccepted) {
            //   //   Get.dialog(
            //   //     AlertDialog(
            //   //       actions: [
            //   //         ElevatedButton(
            //   //             style: const ButtonStyle(
            //   //                 backgroundColor: MaterialStatePropertyAll(
            //   //                     ColorManager.primary)),
            //   //             onPressed: () async {
            //   //               var b = await acceptedTrip(trip.id);
            //   //               if (b) {
            //   //                 Get.back();
            //   //                 snackbarDef("ملاحظة", "تم قبول الطلب بنجاح");
            //   //                 trip.isAccepted = true;
            //   //                 channel.sink.add(Hostting.acceptTrip(trip.id));
            //   //                 mark.removeWhere((element) =>
            //   //                     element.markerId.value != trip.id);
            //   //               }
            //   //             },
            //   //             child: const Text("قبول")),
            //   //         ElevatedButton(
            //   //             onPressed: () {
            //   //               Get.back();
            //   //             },
            //   //             child: const Text("إلغاء"))
            //   //       ],
            //   //       title: const Text("معلومات الرحلة"),
            //   //       content: Text(
            //   //           "نقطة البداية: ${trip.start} \n نقطة النهاية: ${trip.end} \n اجور التوصيل: ${trip.price}"),
            //   //     ),
            //   //   );
            //   // }
            // },
          ),
        );
      }
      update();
    }
  }

  Future<void> getFavoritLocation() async {
    http.Response response = await http.get(HosttingTaxi.getUserLocation,
        headers: HosttingTaxi().getHeader());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var element in body) {
        UserLocation loc = UserLocation.frommJson(element);
        var mar = Marker(
            markerId: MarkerId(loc.id!.toString()),
            position: LatLng(loc.lat, loc.long),
            infoWindow: InfoWindow(title: loc.name),
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

  Future<bool> addTripToDB(WebSocketChannel channel) async {
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
    return false;
  }

  Future<void> addPolyLine(String name) async {
    if (startPostion != null && endPostion != null) {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          HosttingTaxi.mapKey,
          PointLatLng(startPostion!.latitude, startPostion!.longitude),
          PointLatLng(endPostion!.latitude, endPostion!.longitude));
      listPostionForPolyline.clear();
      for (var element in result.points) {
        listPostionForPolyline.add(LatLng(element.latitude, element.longitude));
      }
      start.text = result.startAddress!;
      end.text = result.endAddress!;
      masafa = result.distance;
      time = result.duration;
      price = (result.distanceValue! * 2).toString();
      polyline.add(
        Polyline(
          polylineId: PolylineId(name),
          points: listPostionForPolyline,
          width: 6,
          color: Colors.blueAccent,
        ),
      );
      update();
    }
  }

  Future<void> getPosition() async {
    await checkPermission();
    var loc = await Geolocator.getCurrentPosition();
    cam = CameraPosition(
      target: LatLng(loc.latitude, loc.longitude),
      zoom: 12,
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

  Future<void> addMarkerFromSocket(
      dynamic data, WebSocketChannel channel) async {
    var storeg = GetStorage();
    var body = jsonDecode(data);
    var data2 = jsonDecode(body['data']);
    if (data2['data'] != null) {
      var icon = BitmapDescriptor.defaultMarker;
      var arguments = data2['data'];
      if (arguments['driver_id'] != null && storeg.read("role") == "user") {
        var car = SendDriverStateModel.fromJson(arguments);
        if (car.isOnline) {
          icon = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(),
            'lib/asset/images/car_free.png',
          );
        } else {
          icon = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(),
            'lib/asset/images/car_not_free.png',
          );
        }
        mark.add(Marker(
          markerId: MarkerId(car.id),
          position: LatLng(double.parse(car.late), double.parse(car.long)),
          icon: icon,
        ));
        update();
      } else {
        if (arguments['trip_id'] != null && storeg.read("role") == "driver") {
          var trip = TripModelForSocket.fromJson(arguments);
          icon = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(),
            'lib/asset/images/trip2.png',
          );
          mark.add(Marker(
            markerId: MarkerId(trip.id.toString()),
            position: LatLng(trip.fromLate, trip.fromLong),
            icon: icon,
          ));
          update();
        } else {
          if (arguments[0] == "AcceptTrip" && storeg.read("role") == "driver") {
            mark.removeWhere(
                (element) => element.markerId.value == arguments[1]);
            update();
          }
        }
      }
    }
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

  Future<void> onTapTrip(
      TripModelForSocket trip, WebSocketChannel channel) async {
    startPostion = LatLng(trip.fromLate, trip.fromLong);
    endPostion = LatLng(trip.toLate, trip.toLong);
    addPolyLine(trip.id.toString());
  }
}
