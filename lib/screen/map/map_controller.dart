// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  List<LatLng> list = RxList<LatLng>();
  Set<Marker> mark = RxSet<Marker>();
  LatLng? myLocation;

  Future<void> addMarker() async {
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
    var loc = await Geolocator.getCurrentPosition();
    myLocation = LatLng(loc.latitude, loc.longitude);
    mark.add(Marker(
      markerId: const MarkerId("myLocation"),
      position: myLocation!,
    ));
    update();
  }

  Future<void> addPolyLine() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyCxsin6TH7ouxNCDVoRp7IJihc4JxThkG8",
        const PointLatLng(36.221476, 37.168481),
        const PointLatLng(36.210604, 37.149414));
    for (var element in result.points) {
      list.add(LatLng(element.latitude, element.longitude));
    }
    update();
    // var masafa = result.distance;
    // var time = result.duration;
    // var timeInS = result.durationValue;
    // var locS = result.startAddress;
    // var locE = result.endAddress;
  }

  Future<void> checkPermission() async {
    var b = await Geolocator.checkPermission();
    var a = await Geolocator.requestPermission();
  }
}
