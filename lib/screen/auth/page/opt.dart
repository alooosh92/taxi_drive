import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/models/verify.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/auth/auth_controller.dart';
import 'package:taxi_drive/screen/auth/widget/row_text_button.dart';
import 'package:taxi_drive/screen/trip/trip_screen.dart';
import 'package:taxi_drive/widget/button_primary.dart';
import 'package:taxi_drive/widget/progress_def.dart';
import 'package:taxi_drive/widget/snackbar_def.dart';

class OptScreen extends StatelessWidget {
  const OptScreen({super.key, required this.phone});
  final String phone;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String? otpval;
    AuthController authController = Get.find();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("رمز التحقق من الرقم الهاتف",
                style: FontManager.w700s18cB),
            Text("الرجاء ادخال رمز التحقق المرسل الى الرقم:$phone",
                style: FontManager.w400s14cB),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: OtpTextField(
                keyboardType: TextInputType.number,
                numberOfFields: 4,
                autoFocus: true,
                borderWidth: 2,
                showFieldAsBox: true,
                fieldWidth: 45,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderColor: ColorManager.primary,
                focusedBorderColor: ColorManager.primary,
                onSubmit: (value) => otpval = value,
              ),
            ),
            RowTextButton(
              text: "لم تستلم رمز التحقق؟",
              textButton: "إعادة ارسال الرمز",
              press: () async {
                Get.dialog(const ProgressDef());
                await authController.login(phone);
                Get.back();
              },
            ),
            ButtonPrimary(
                press: () async {
                  if (otpval != null && otpval!.length > 3) {
                    var toknFCM = await FirebaseMessaging.instance.getToken();
                    var verify =
                        Verify(code: otpval!, phone: phone, fcmToken: toknFCM);
                    var b = await authController.verify(verify);
                    if (b) {
                      Get.offAll(const TripScreen());
                    } else {
                      snackbarDef("خطأ", "رمز التحقق خاطئ");
                    }
                  }
                },
                text: "التحقق من الرقم")
          ],
        ),
      ),
    );
  }
}
