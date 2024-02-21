import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/res/key.dart';
import 'package:taxi_drive/screen/auth/auth_controller.dart';
import 'package:taxi_drive/screen/splash/splash.dart';
import 'package:taxi_drive/screen/trip/trip_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    GetStorage();
    Timer(const Duration(seconds: 2), () async {
      var v = await authController.getVersion();
      v = v ?? '';
      if (int.parse(version.substring(version.indexOf('+'))) >=
          int.parse(v.substring(v.indexOf('+')))) {
        var b = await authController.checkToken();
        if (b) {
          Get.offAll(const TripScreen());
        } else {
          Get.offAll(const SplashScreen());
        }
      } else {
        Get.dialog(AlertDialog(
          title: const Text('تحديث'),
          content: const Text('هذا الاصدار قديم الرجاء تحديث التطبيق'),
          actions: [
            TextButton(
                onPressed: () async {
                  if (await canLaunchUrl(urlGoolePlay)) {
                    await launchUrl(urlGoolePlay);
                  }
                },
                child: const Text(
                  'تحديث',
                  style: TextStyle(color: ColorManager.red),
                ))
          ],
        ));
      }
    });
    return Scaffold(
      backgroundColor: ColorManager.brown,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Stack(
          children: [
            Image.asset(
              'lib/asset/images/street.png',
              fit: BoxFit.cover,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
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
            const Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: Text(
                'في كل مكان وأي مكان نحن معك',
                textAlign: TextAlign.center,
                style: FontManager.w600s33cW,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
