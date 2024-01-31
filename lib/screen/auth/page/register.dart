import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/models/user_register.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/res/validator_manager.dart';
import 'package:taxi_drive/screen/auth/auth_controller.dart';
import 'package:taxi_drive/screen/auth/page/login.dart';
import 'package:taxi_drive/screen/auth/page/opt.dart';
import 'package:taxi_drive/screen/auth/widget/row_text_button.dart';
import 'package:taxi_drive/widget/button_primary.dart';
import 'package:taxi_drive/widget/progress_def.dart';
import 'package:taxi_drive/widget/snackbar_def.dart';
import 'package:taxi_drive/widget/text_form_fiels_def.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
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
            child: FutureBuilder<List<DropdownMenuItem<String>>>(
              future: authController.getRegion(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ProgressDef();
                }
                String? region;
                return Form(
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
                        keyType: TextInputType.phone,
                      ),
                      TextFormFieldRadius(
                        controller: email,
                        hint: "البريد الإلكتروني",
                        keyType: TextInputType.name,
                      ),
                      DropdownButtonFormField<String>(
                          validator: (value) => ValidatorManager.name(value),
                          decoration: inputDecorationDef(radius: 30),
                          items: snapshot.data,
                          onChanged: (value) {
                            region = value;
                          }),
                      ButtonPrimary(
                          press: () async {
                            if (formKey.currentState!.validate()) {
                              var user = UserRegister(
                                  name: name.text,
                                  phone: phone.text,
                                  email: email.text,
                                  region: region!);
                              var b = await authController.register(user);
                              if (b) {
                                Get.to(OptScreen(phone: phone.text));
                              } else {
                                snackbarDef("خطأ",
                                    "هناك خطأ ما الرجاء التواصل مع المسؤول");
                              }
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
