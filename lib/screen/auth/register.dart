import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/res/validator_manager.dart';
import 'package:taxi_drive/screen/auth/login.dart';
import 'package:taxi_drive/screen/auth/opt.dart';
import 'package:taxi_drive/screen/auth/widget/row_text_button.dart';
import 'package:taxi_drive/widget/button_primary.dart';
import 'package:taxi_drive/widget/text_form_fiels_def.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController email = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'lib/asset/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                  const Text(
                    "انشاء حساب",
                    style: FontManager.w600s30cB,
                  ),
                  TextFormFieldRadius(
                    controller: name,
                    hint: "الاسم",
                    validator: (value) => ValidatorManager.name(value),
                  ),
                  TextFormFieldRadius(
                    controller: phone,
                    hint: "رقم الهاتف",
                    validator: (value) => ValidatorManager.phone(value),
                  ),
                  TextFormFieldRadius(
                    controller: email,
                    hint: "البريد الإلكتروني",
                    validator: (value) => ValidatorManager.email(value),
                  ),
                  ButtonPrimary(
                      press: () {
                        if (formKey.currentState!.validate()) {
                          Get.to(OptScreen(phone: phone.text));
                        }
                      },
                      text: "انشاء حساب"),
                  RowTextButton(
                    text: "هل تملك حساب؟",
                    textButton: "سجل دخول",
                    press: () => Get.offAll(const LoginScreen()),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
