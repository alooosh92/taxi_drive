import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

Set<Marker> mark = {};
List<LatLng> list = [];

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> mapController =
        Completer<GoogleMapController>();
    CameraPosition camPos = const CameraPosition(
      target: LatLng(36.199084, 37.158289),
      zoom: 14,
    );
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          markers: mark,
          onTap: (late) {
            setState(() {
              mark.add(
                Marker(
                  markerId: const MarkerId("a"),
                  position: late,
                ),
              );
            });
          },
          polylines: {
            Polyline(
              polylineId: const PolylineId("aaaa"),
              points: list,
            )
          },
          initialCameraPosition: camPos,
          onMapCreated: (controller) async {
            mapController.complete(controller);
            await addMarker();
            await addPolyLine();
          },
        ),
      ),
    );
  }
}

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
}

Future<void> addPolyLine() async {
  PolylinePoints polylinePoints = PolylinePoints();
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAcShnaQHgtZPtGcqy24uNN6Wb9ziQgIxQ",
      const PointLatLng(36.199084, 37.158289),
      const PointLatLng(36.198090, 37.168222));
  for (var element in result.points) {
    list.add(LatLng(element.latitude, element.longitude));
  }
}
