import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/auth/auth_controller.dart';
import 'package:taxi_drive/screen/auth/page/update_profile.dart';
import 'package:taxi_drive/widget/row_text_press.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
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
                authController.user!.name,
                style: FontManager.w500s22cW,
              ),
              RowTextPress(
                icon: Icons.account_box,
                press: () => Get.to(const UpdateProfile()),
                text: "حسابي",
              ),
              RowTextPress(
                icon: Icons.factory_outlined,
                press: () {},
                text: "من نحن",
              ),
              RowTextPress(
                  icon: Icons.private_connectivity_outlined,
                  press: () async {},
                  text: "شروط الاستخدام"),
              RowTextPress(
                icon: Icons.privacy_tip_outlined,
                press: () {},
                text: "الخصوصية",
              ),
              RowTextPress(
                icon: Icons.contact_emergency_outlined,
                press: () {},
                text: "تواصل معنا",
              ),
              RowTextPress(
                icon: Icons.share,
                press: () async {
                  // ignore: unused_local_variable
                  final result =
                      await Share.shareUri(Uri.parse("https://google.com"));
                },
                text: "شارك التطبيق مع اصدقائك",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
