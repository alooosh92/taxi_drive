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
              width: 6,
              color: Colors.blueAccent,
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
      "AIzaSyCxsin6TH7ouxNCDVoRp7IJihc4JxThkG8",
      const PointLatLng(36.221476, 37.168481),
      const PointLatLng(36.210604, 37.149414));
  for (var element in result.points) {
    list.add(LatLng(element.latitude, element.longitude));
  }
  var masafa = result.distance;
  var time = result.duration;
  var timeInS = result.durationValue;
  var locS = result.startAddress;
  var locE = result.endAddress;
}
