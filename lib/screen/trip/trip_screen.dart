import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/screen/trip/widget/floating_button_trip_screen.dart';
import 'package:taxi_drive/widget/drawer_home.dart';
import 'package:taxi_drive/widget/progress_def.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  Widget build(BuildContext context) {
    var storeg = GetStorage();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    TripController tripController = Get.find();
    final Completer<GoogleMapController> mapControllerMap =
        Completer<GoogleMapController>();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: const FloatingButtonTripScreen(),
        drawer: DrawerHome(name: storeg.read("name") ?? ""),
        body: FutureBuilder(
          future: tripController.getPosition(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const ProgressDef();
            }
            return GetBuilder<TripController>(
              init: tripController,
              builder: (controllerGet) {
                return Stack(
                  children: [
                    GoogleMap(
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      markers: controllerGet.mark,
                      onTap: (late) {
                        controllerGet.addMarker(late);
                      },
                      polylines: {
                        Polyline(
                          polylineId: const PolylineId("aaaa"),
                          points: controllerGet.listPostionForPolyline,
                          width: 6,
                          color: Colors.blueAccent,
                        )
                      },
                      initialCameraPosition: controllerGet.cam!,
                      onMapCreated: (controller) async {
                        mapControllerMap.complete(controller);
                        await controllerGet.addCar();
                      },
                    ),
                    Positioned(
                        top: 10,
                        left: 20,
                        child: IconButton(
                          onPressed: () {
                            scaffoldKey.currentState!.openDrawer();
                          },
                          icon: const Icon(Icons.list_sharp,
                              textDirection: TextDirection.ltr,
                              color: ColorManager.primary,
                              size: 40),
                        ))
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
