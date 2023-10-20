import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/res/validator_manager.dart';
import 'package:taxi_drive/screen/auth/opt.dart';
import 'package:taxi_drive/widget/app_bar_all.dart';
import 'package:taxi_drive/widget/button_primary.dart';
import 'package:taxi_drive/widget/text_form_fiels_def.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController email = TextEditingController();
    return Scaffold(
      appBar: appBarAll(
          press: () => Get.back(),
          icon: Icons.arrow_back_ios,
          title: "تعديل الملف الشخصي"),
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
                children: [
                  Image.asset(
                    'lib/asset/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                  TextFormFieldRadius(
                    controller: name,
                    hint: "الاسم",
                    topPadding: 30,
                    validator: (value) => ValidatorManager.name(value),
                  ),
                  TextFormFieldRadius(
                    controller: phone,
                    hint: "رقم الهاتف",
                    topPadding: 30,
                    validator: (value) => ValidatorManager.phone(value),
                  ),
                  TextFormFieldRadius(
                    controller: email,
                    hint: "البريد الالكتروني",
                    topPadding: 30,
                    validator: (value) => ValidatorManager.email(value),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: ButtonPrimary(
                        press: () {
                          if (formKey.currentState!.validate()) {
                            Get.to(OptScreen(phone: phone.text));
                          }
                        },
                        text: "تحديث الملف الشخصي"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
