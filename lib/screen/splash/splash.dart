import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/auth/page/login.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/widget/button_primary.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    tripController.checkPermission();
    return Scaffold(
      backgroundColor: ColorManager.brown,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Stack(
          children: [
            Image.asset(
              'lib/asset/images/street.png',
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              fit: BoxFit.fill,
            ),
            Center(
              child: Image.asset(
                'lib/asset/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Taxi',
                    style: FontManager.w600s33cW,
                  ),
                  Text(
                    'تنقل بسرعة و أمان',
                    style: FontManager.w600s33cW,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ButtonPrimary(
                    press: () => Get.offAll(const LoginScreen()),
                    text: "تسجيل الدخول"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
