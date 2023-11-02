import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_drive/screen/map/map_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.find();
    final Completer<GoogleMapController> mapControllerMap =
        Completer<GoogleMapController>();
    CameraPosition camPos = const CameraPosition(
      target: LatLng(36.199084, 37.158289),
      zoom: 14,
    );

    return Scaffold(
      body: GetBuilder<MapController>(
        init: mapController,
        builder: (controllerGet) {
          return GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: controllerGet.mark,
            onTap: (late) {
              setState(() {
                controllerGet.mark.add(
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
                points: controllerGet.list,
                width: 6,
                color: Colors.blueAccent,
              )
            },
            initialCameraPosition: camPos,
            onMapCreated: (controller) async {
              mapControllerMap.complete(controller);
              await controllerGet.checkPermission();
              await controllerGet.addMarker();
              await controllerGet.addPolyLine();
            },
          );
        },
      ),
    );
  }
}
