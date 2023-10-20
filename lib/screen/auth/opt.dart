import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/auth/widget/row_text_button.dart';
import 'package:taxi_drive/widget/button_primary.dart';

class OptScreen extends StatelessWidget {
  const OptScreen({super.key, required this.phone});
  final String phone;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String? otpval;
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
              press: () {},
            ),
            ButtonPrimary(press: () {}, text: "التحقق من الرقم")
          ],
        ),
      ),
    );
  }
}
