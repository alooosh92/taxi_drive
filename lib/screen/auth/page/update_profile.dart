import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxi_drive/models/update_user.dart';
import 'package:taxi_drive/res/validator_manager.dart';
import 'package:taxi_drive/screen/auth/auth_controller.dart';
import 'package:taxi_drive/screen/auth/page/opt.dart';
import 'package:taxi_drive/screen/trip/trip_screen.dart';
import 'package:taxi_drive/widget/app_bar_all.dart';
import 'package:taxi_drive/widget/button_primary.dart';
import 'package:taxi_drive/widget/snackbar_def.dart';
import 'package:taxi_drive/widget/text_form_fiels_def.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    AuthController authController = Get.find();
    var storeg = GetStorage();
    TextEditingController name =
        TextEditingController(text: authController.user!.name);
    TextEditingController phone =
        TextEditingController(text: authController.user!.phone);
    TextEditingController email =
        TextEditingController(text: authController.user!.email);
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
                    //   validator: (value) => ValidatorManager.email(value),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: ButtonPrimary(
                        press: () async {
                          if (formKey.currentState!.validate()) {
                            var user = UpdateUser(
                                name: name.text,
                                phone: phone.text,
                                email: email.text);
                            var b = await authController.updateProfile(user);
                            if (b) {
                              snackbarDef("ملاحظة", "تم تعديل البيانات بنجاح");
                            } else {
                              snackbarDef("تحذير",
                                  "هناك خطأ ما الرجاء الاتصال بالمسؤول");
                            }

                            if (storeg.read("phone") != phone.text) {
                              await authController.login(phone.text);
                              Get.offAll(OptScreen(phone: phone.text));
                            } else {
                              Get.off(const TripScreen());
                            }
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
