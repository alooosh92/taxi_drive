import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/widget/row_text_press.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorManager.primary,
      width: MediaQuery.sizeOf(context).width,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.close,
                        color: ColorManager.white,
                      )),
                ],
              ),
              Image.asset(
                'lib/asset/images/logo.png',
                fit: BoxFit.cover,
              ),
              Text(
                name,
                style: FontManager.w500s22cW,
              ),
              RowTextPress(
                icon: Icons.account_box,
                press: () {},
                text: "حسابي",
              ),
              RowTextPress(
                icon: Icons.account_box,
                press: () {},
                text: "من نحن",
              ),
              RowTextPress(
                  icon: Icons.account_box,
                  press: () {},
                  text: "شروط الاستخدام"),
              RowTextPress(
                icon: Icons.account_box,
                press: () {},
                text: "تواصل معنا",
              ),
              RowTextPress(
                icon: Icons.account_box,
                press: () {},
                text: "شارك التطبيق مع اصدقائك",
              ),
              RowTextPress(
                icon: Icons.account_box,
                press: () {},
                text: "تسجيل الخروج",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
