import 'package:flutter/material.dart';
import 'package:taxi_drive/widget/app_bar_all.dart';
import 'package:taxi_drive/widget/button_primary.dart';
import 'package:taxi_drive/widget/text_form_fiels_def.dart';

class MakeAComplaintScreen extends StatelessWidget {
  const MakeAComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController note = TextEditingController();
    return Scaffold(
      appBar: appBarAll(
          press: () {}, icon: Icons.arrow_back_ios, title: "تقديم شكوى"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              "lib/asset/images/MakeAComplaintScreen.png",
              width: MediaQuery.sizeOf(context).height / 3,
              height: MediaQuery.sizeOf(context).height / 3,
            ),
            TextFormFieldRadius(
              controller: note,
              hint: "نص الرسالة",
              radius: 10,
              line: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ButtonPrimary(press: () {}, text: "ارسال الشكوى"),
            )
          ],
        ),
      ),
    );
  }
}
