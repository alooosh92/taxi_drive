import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/screen/trip/widget/buttom_sheet.dart';
import 'package:taxi_drive/screen/trip/widget/choise_trip.dart';
import 'package:taxi_drive/widget/button_primary.dart';
import 'package:taxi_drive/widget/snackbar_def.dart';
import 'package:taxi_drive/widget/text_form_fiels_def.dart';

class FloatingButtonTripScreen extends StatelessWidget {
  const FloatingButtonTripScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    var storeg = GetStorage();
    return GetBuilder<TripController>(
      init: tripController,
      builder: (controller) {
        return tripController.tripAccsepted == null ||
                !tripController.tripAccsepted!
            ? TripAccsseptedNullOrFalse(storeg: storeg, controller: controller)
            : storeg.read("role") == "user"
                ? const TripAccsseptedUserTrue()
                : const TripAccsseptedDriverTrue();
      },
    );
  }
}

class TripAccsseptedUserTrue extends StatelessWidget {
  const TripAccsseptedUserTrue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(right: 30),
      decoration: const BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('اسم السائق: علاء بعاج', style: FontManager.w700s15cB),
                  Text('رقم الجوال: +963956108642',
                      style: FontManager.w700s15cB),
                  Text('لون السيارة: أصفر', style: FontManager.w700s15cB),
                  Text('رقم اللوحة: 658452', style: FontManager.w700s15cB),
                  Text('نوع السيارة: كيا', style: FontManager.w700s15cB),
                  Text('المسافة : 3.2', style: FontManager.w700s15cB),
                  Text('قيمة الرحلة: 15200', style: FontManager.w700s15cB),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          ButtonPrimary(
            press: () {},
            text: 'اتصال',
            color: ColorManager.white,
            textStyle: FontManager.w700s15cB,
          )
        ],
      ),
    );
  }
}

class TripAccsseptedDriverTrue extends StatelessWidget {
  const TripAccsseptedDriverTrue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(right: 30),
      decoration: const BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('اسم المستخدم: علاء بعاج', style: FontManager.w700s15cB),
                  Text('رقم الجوال: +963956108642',
                      style: FontManager.w700s15cB),
                  Text('المسافة : 3.2', style: FontManager.w700s15cB),
                  Text('قيمة الرحلة: 15200', style: FontManager.w700s15cB),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonPrimary(
                press: () {},
                text: 'اتصال',
                color: ColorManager.white,
                textStyle: FontManager.w700s15cB,
                autoSize: Size(MediaQuery.sizeOf(context).width / 2 - 50, 50),
              ),
              ButtonPrimary(
                press: () {},
                text: 'انهاء الرحلة',
                color: ColorManager.red,
                textStyle: FontManager.w700s15cB,
                autoSize: Size(MediaQuery.sizeOf(context).width / 2 - 50, 50),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TripAccsseptedNullOrFalse extends StatelessWidget {
  const TripAccsseptedNullOrFalse({
    super.key,
    required this.storeg,
    required this.controller,
  });

  final GetStorage storeg;
  final TripController controller;

  @override
  Widget build(BuildContext context) {
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
                  enabled: storeg.read("role") == "user" &&
                      controller.tripAccsepted == null,
                  readOnly: true,
                  iconStart: Icons.location_on_outlined,
                  ontap: () => controller.isStart = true.obs,
                  color: ColorManager.white,
                  textStyle: FontManager.w500s15cB,
                  line: 1,
                  bordarColor: ColorManager.red,
                ),
                const SizedBox(height: 10),
                TextFormFieldRadius(
                  controller: controller.end,
                  enabled: storeg.read("role") == "user" &&
                      controller.tripAccsepted == null,
                  hint: "انقر هنا لتحديد نقطة النهاية",
                  readOnly: true,
                  iconStart: Icons.location_on_outlined,
                  ontap: () => controller.isStart = false.obs,
                  color: ColorManager.white,
                  textStyle: FontManager.w500s15cB,
                  line: 1,
                  bordarColor: ColorManager.red,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: storeg.read("role") == "user",
          child: SizedBox(
            child: FloatingActionButton(
              onPressed: controller.tripAccsepted == null
                  ? () => {
                        if (controller.startPostion != null &&
                            controller.endPostion != null &&
                            controller.price != null)
                          {
                            buttomSheet(
                              context: context,
                              headerText: "إضافة طلب",
                              contener: const ChoiseTrip(),
                            )
                          }
                        else
                          {
                            snackbarDef("تحزير",
                                "يجب تحديد نقطة البدايو والنهاية للرحلة")
                          }
                      }
                  : controller.tripAccsepted!
                      ? null
                      : () {
                          Get.dialog(
                            AlertDialog(
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (controller.tripUserAdd != null) {
                                      controller.deleteTrip(
                                          controller.tripUserAdd!.id);
                                      controller.changetripaccsepted(null);
                                      Get.back();
                                    }
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          ColorManager.red)),
                                  child: const Text(
                                    'حذف الرحلة',
                                    style: TextStyle(color: ColorManager.white),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    'عودة',
                                  ),
                                ),
                              ],
                              title: const Text('إلغاء الطلب'),
                              content:
                                  const Text('هل انت متأكد من الغاء الطلب؟'),
                            ),
                          );
                        },
              backgroundColor: controller.tripAccsepted ?? true
                  ? ColorManager.primary
                  : ColorManager.red,
              child: controller.tripAccsepted ?? true
                  ? const Icon(Icons.add, color: ColorManager.white, size: 30)
                  : CircularCountDownTimer(
                      onComplete: () => controller.changetripaccsepted(null),
                      isReverse: true,
                      duration: 100,
                      fillColor: ColorManager.red,
                      ringColor: ColorManager.red,
                      textStyle: const TextStyle(color: ColorManager.white),
                      height: 50,
                      width: 50,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
