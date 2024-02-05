import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/widget/button_primary.dart';
import 'package:taxi_drive/widget/route_sheet.dart';

class RouteButton extends StatelessWidget {
  const RouteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonPrimary(
      press: () => Get.bottomSheet(const RouteSheet()),
      text: 'أضف تقييمك',
    );
  }
}
