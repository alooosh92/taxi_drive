import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';

class HeaderBottomSheet extends StatelessWidget {
  const HeaderBottomSheet({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            IconButton(
                onPressed: () => Get.back(), icon: const Icon(Icons.close)),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Divider(
                color: ColorManager.gray,
                thickness: 6,
                indent: 100,
                endIndent: 100,
              ),
            ),
          ],
        ),
        Text(
          text,
          style: FontManager.w500s20cB,
        ),
        const Divider(
          color: ColorManager.gray,
        )
      ],
    );
  }
}
