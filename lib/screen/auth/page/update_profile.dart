import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/models/update_user.dart';
import 'package:taxi_drive/models/user_register.dart';
import 'package:taxi_drive/res/validator_manager.dart';
import 'package:taxi_drive/screen/auth/auth_controller.dart';
import 'package:taxi_drive/screen/auth/page/opt.dart';
import 'package:taxi_drive/screen/trip/trip_screen.dart';
import 'package:taxi_drive/widget/app_bar_all.dart';
import 'package:taxi_drive/widget/button_primary.dart';
import 'package:taxi_drive/widget/progress_def.dart';
import 'package:taxi_drive/widget/snackbar_def.dart';
import 'package:taxi_drive/widget/text_form_fiels_def.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    AuthController authController = Get.find();
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController email = TextEditingController();
    String? region;
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
            child: FutureBuilder(
              future: authController.getRegion(),
              builder: (BuildContext context, AsyncSnapshot regionCity) {
                return FutureBuilder<UserRegister?>(
                  future: authController.userProfile(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ProgressDef();
                    }
                    name.text = snapshot.data.name;
                    email.text = snapshot.data.email ?? '';
                    phone.text = snapshot.data.phone;
                    region = snapshot.data.region;
                    return Form(
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
                          ),
                          const SizedBox(height: 30),
                          DropdownButtonFormField<String?>(
                              value: region,
                              validator: (value) =>
                                  ValidatorManager.name(value),
                              decoration: inputDecorationDef(radius: 30),
                              items: regionCity.data,
                              onChanged: (value) {
                                region = value!;
                              }),
                          Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: ButtonPrimary(
                                press: () async {
                                  if (formKey.currentState!.validate()) {
                                    var user = UpdateUser(
                                        name: name.text,
                                        phone: phone.text,
                                        email: email.text,
                                        region: region!);
                                    var b = await authController
                                        .updateProfile(user);
                                    if (b) {
                                      snackbarDef(
                                          "ملاحظة", "تم تعديل البيانات بنجاح");
                                    } else {
                                      snackbarDef("تحذير",
                                          "هناك خطأ ما الرجاء الاتصال بالمسؤول");
                                    }

                                    if (snapshot.data.phone != phone.text) {
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
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
