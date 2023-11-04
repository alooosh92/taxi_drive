import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_drive/screen/trip/widget/map.dart';

class TripController extends GetxController {
  List<LatLng> listPostionForPolyline = [];
  Set<Marker> mark = {};
  List<DropdownMenuItem<int?>> listLoction = [];
  CameraPosition? cam;
  LatLng? startPostion;
  LatLng? endPostion;
  int? textStartPostion;
  int? textEndPostion;
  RxBool? isStart = RxBool(true);
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  String? masafa;
  String? time;
  String? price;

  @override
  void onInit() async {
    if (startPostion == null) {
      var loc = await Geolocator.getCurrentPosition();
      startPostion = LatLng(loc.latitude, loc.longitude);
    }
    super.onInit();
  }

  void addMarker(LatLng pos) {
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
      isStart!.value ? startPostion = pos : endPostion = pos;
      isStart!.value = !(isStart!.value);
      if (startPostion != null && endPostion != null) {
        addPolyLine();
      }
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

  Future<void> addPolyLine() async {
    if (startPostion != null && endPostion != null) {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyCxsin6TH7ouxNCDVoRp7IJihc4JxThkG8",
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
      update();
    }
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
          print("object");
          Get.off(MapScreen(title: "title"));
        },
        child: const Text("إختيار موقع من الخريطة"),
      )
    ];
  }
}

    // var masafa = result.distance;
    // var time = result.duration;
    // var timeInS = result.durationValue;
    // var locS = result.startAddress;
    // var locE = result.endAddress;
    // var tar = await placemarkFromCoordinates(
    //     startPostion!.latitude, startPostion!.longitude);
    // textStartPostion.text = "${tar[4].street}";