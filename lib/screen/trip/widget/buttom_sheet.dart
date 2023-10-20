import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/screen/trip/widget/header_bottom_sheet.dart';

Future<dynamic> buttomSheet({
  required BuildContext context,
  required String headerText,
  required Widget contener,
}) {
  return showFlexibleBottomSheet(
    minHeight: 0.5,
    initHeight: 0.5,
    maxHeight: 0.5,
    context: context,
    isExpand: true,
    bottomSheetColor: Colors.transparent,
    builder: (context, scrollController, bottomSheetOffset) {
      return Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.sizeOf(context).height / 2,
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
