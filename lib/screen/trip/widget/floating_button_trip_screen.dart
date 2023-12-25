import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/screen/trip/widget/buttom_sheet.dart';
import 'package:taxi_drive/screen/trip/widget/choise_trip.dart';
import 'package:taxi_drive/widget/snackbar_def.dart';
import 'package:taxi_drive/widget/text_form_fiels_def.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class FloatingButtonTripScreen extends StatelessWidget {
  const FloatingButtonTripScreen({
    super.key,
    required this.chanal,
  });
  final WebSocketChannel chanal;
  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    var storeg = GetStorage();
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
                        hint: "انقر هنا لتحديد نقطة البداية",
                        enabled: storeg.read("role") == "user",
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
                        enabled: storeg.read("role") == "user",
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
              Visibility(
                visible: storeg.read("role") == "user",
                child: SizedBox(
                  child: FloatingActionButton(
                    onPressed: () => {
                      if (tripController.startPostion != null &&
                          tripController.endPostion != null &&
                          tripController.price != null)
                        {
                          buttomSheet(
                            context: context,
                            headerText: "إضافة طلب",
                            contener: ChoiseTrip(
                              channel: chanal,
                            ),
                          )
                        }
                      else
                        {
                          snackbarDef(
                              "تحزير", "يجب تحديد نقطة البدايو والنهاية للرحلة")
                        }
                    },
                    backgroundColor: ColorManager.primary,
                    child: const Icon(
                      Icons.add,
                      color: ColorManager.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
