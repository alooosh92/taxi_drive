import 'package:flutter/material.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/screen/trip/widget/header_bottom_sheet.dart';

Future<dynamic> buttomSheet({
  required BuildContext context,
  required String headerText,
  required Widget contener,
  double? heig,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(20),
        height: heig ?? MediaQuery.sizeOf(context).height / 2,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: ColorManager.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HeaderBottomSheet(text: headerText),
            contener,
          ],
        ),
      );
    },
  );
}
