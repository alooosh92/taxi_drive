import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/screen/trip/widget/buttom_sheet.dart';
import 'package:taxi_drive/screen/trip/widget/choise_trip.dart';
import 'package:taxi_drive/widget/progress_def.dart';
import 'package:taxi_drive/widget/text_form_fiels_def.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    final Completer<GoogleMapController> mapControllerMap =
        Completer<GoogleMapController>();
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: const FloatingButtonTripScreen(),
      body: FutureBuilder(
        future: tripController.getPosition(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const ProgressDef();
          }
          return GetBuilder<TripController>(
            init: tripController,
            builder: (controllerGet) {
              return GoogleMap(
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
              );
            },
          );
        },
      ),
    );
  }
}

class FloatingButtonTripScreen extends StatelessWidget {
  const FloatingButtonTripScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    return GetBuilder<TripController>(
        init: tripController,
        builder: (controller) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormFieldRadius(
                        controller: controller.start,
                        // hint: "نقطة البداية",
                        hint: "انقر هنا لتحديد نقطة البداية",
                        readOnly: true,
                        iconStart: Icons.location_on_outlined,
                        ontap: () => tripController.isStart = true.obs,
                        color: ColorManager.white,
                        textStyle: FontManager.w500s15cB,
                        line: 1,
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldRadius(
                        controller: controller.end,
                        // hint: "نقطة النهاية",
                        hint: "انقر هنا لتحديد نقطة النهاية",
                        readOnly: true,
                        iconStart: Icons.location_on_outlined,
                        ontap: () => tripController.isStart = false.obs,
                        color: ColorManager.white,
                        textStyle: FontManager.w500s15cB,
                        line: 1,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                //width: MediaQuery.sizeOf(context).width * 0.3,
                child: FloatingActionButton(
                  onPressed: () => buttomSheet(
                    context: context,
                    headerText: "إضافة طلب",
                    contener: const ChoiseTrip(),
                  ),
                  backgroundColor: ColorManager.primary,
                  child: const Icon(
                    Icons.add,
                    color: ColorManager.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
