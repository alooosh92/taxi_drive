import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_drive/models/add_trip.dart';
import 'package:taxi_drive/models/add_user_location.dart';
import 'package:taxi_drive/res/hostting.dart';
import 'package:taxi_drive/screen/auth/auth_controller.dart';
import 'package:taxi_drive/screen/trip/widget/map.dart';
import 'package:http/http.dart' as http;
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
      var info = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (isStart!.value) {
        startPostion = pos;
        start.text = info.first.street ?? "لا يوجد معلومات";
      } else {
        endPostion = pos;
        end.text = info.first.street ?? "لا يوجد معلومات";
      }
      if (startPostion != null && endPostion != null) {
        addPolyLine("test");
      }
      update();
    }
  }

  Future<bool> addUserLocation(UserLocation location) async {
    http.Response response = await http.post(Hostting.addUserLocation,
        headers: Hostting().getHeader(), body: jsonEncode(location.toJson()));
    if (response.statusCode == 200 && jsonDecode(response.body)) {
      return true;
    }
    return false;
  }

  Future<void> getFavoritLocation() async {
    http.Response response = await http.get(Hostting.getUserLocation,
        headers: Hostting().getHeader());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var element in body) {
        UserLocation loc = UserLocation.frommJson(element);
        var mar = Marker(
            markerId: MarkerId(loc.id!),
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

  Future<bool> addTripToDB(WebSocketChannel chanal) async {
    if (startPostion == null || endPostion == null || price == null) {
      return false;
    }
    var trip = AddTrip(
        fromLate: startPostion!.latitude,
        fromLong: startPostion!.longitude,
        toLate: endPostion!.latitude,
        toLong: endPostion!.longitude,
        price: double.parse(price!));
    http.Response response = await http.post(Hostting.addTrip,
        headers: Hostting().getHeader(), body: jsonEncode(trip.toJson()));
    if (response.statusCode == 200 && jsonDecode(response.body)) {
      AuthController authController = Get.find();
      chanal.sink.add(Hostting.sendLocation(
        authController.user!.phone,
        startPostion!.latitude,
        startPostion!.longitude,
        false,
        false,
      ));
      isStart = null;
      return true;
    }
    return false;
  }

  Future<void> addPolyLine(String name) async {
    if (startPostion != null && endPostion != null) {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          Hostting.mapKey,
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
      zoom: 14,
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

  Future<void> addMarkerFromSocket(dynamic data) async {
    var json = data.toString().substring(0, data.toString().indexOf(""));
    var body = jsonDecode(json);
    var arguments = body["arguments"] ?? "";
    if (arguments != "") {
      var icon = BitmapDescriptor.defaultMarker;
      if (arguments[3]) {
        if (arguments[4]) {
          icon = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(),
            'lib/asset/images/car_raedy.png',
          );
        } else {
          icon = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(),
            'lib/asset/images/car_work.png',
          );
        }
      } else {
        icon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          'lib/asset/images/trip2.png',
        );
      }
      mark.add(
        Marker(
            markerId: MarkerId(arguments[0]),
            position: LatLng(arguments[1], arguments[2]),
            icon: icon,
            onTap: !arguments[3] ? null : () {}),
      );
      update();
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

  Future<void> addCar() async {
    var ic = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'lib/asset/images/car.png');
    mark.add(Marker(
      markerId: const MarkerId("alaa"),
      position: const LatLng(36.199084, 37.158289),
      icon: ic,
    ));
    mark.add(Marker(
      markerId: const MarkerId("baaj"),
      position: const LatLng(36.198090, 37.168222),
      icon: ic,
    ));
    update();
  }
}
