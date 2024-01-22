import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/widget/button_primary.dart';

class SaerchDriver extends StatelessWidget {
  const SaerchDriver({super.key});

  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    return Stack(
      children: [
        Column(
          children: [
            Image.asset(
              'lib/asset/images/radar.gif',
              fit: BoxFit.contain,
              height: 150,
              width: 150,
            ),
            ButtonPrimary(
              color: ColorManager.red,
              press: () async {
                await tripController.deleteTrip(tripController.tripUserAdd!.id);
                Get.back();
              },
              text: 'إلغاء الرحلة',
            ),
          ],
        ),
        CircularCountDownTimer(
          onComplete: () => Get.back(),
          isReverse: true,
          duration: 59,
          fillColor: ColorManager.gray,
          ringColor: ColorManager.primary,
          height: 50,
          width: 50,
        ),
      ],
    );
  }
}
