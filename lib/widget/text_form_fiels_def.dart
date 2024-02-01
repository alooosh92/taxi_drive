import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/models/add_user_location.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/widget/snackbar_def.dart';

class TextFormFieldRadius extends StatelessWidget {
  const TextFormFieldRadius({
    super.key,
    required this.controller,
    required this.hint,
    this.iconStart,
    this.iconEnd,
    this.topPadding,
    this.keyType,
    this.radius,
    this.validator,
    this.line,
    this.label,
    this.enabled,
    this.ontap,
    this.readOnly,
    this.color,
    this.textStyle,
    this.bordarColor,
  });

  final TextEditingController controller;
  final String hint;
  final IconData? iconStart;
  final IconData? iconEnd;
  final double? topPadding;
  final TextInputType? keyType;
  final double? radius;
  final String? Function(String?)? validator;
  final int? line;
  final String? label;
  final bool? enabled;
  final void Function()? ontap;
  final bool? readOnly;
  final Color? color;
  final TextStyle? textStyle;
  final Color? bordarColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 0),
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(radius ?? 30)),
        child: TextFormField(
          onTap: ontap,
          readOnly: readOnly ?? false,
          enabled: enabled,
          validator: validator,
          controller: controller,
          keyboardType: keyType,
          maxLines: line,
          style: FontManager.w400s14cB,
          decoration: inputDecorationDef(
              radius: radius ?? 30,
              label: label,
              hint: hint,
              iconEnd: iconEnd,
              iconStart: iconStart,
              textStyle: textStyle,
              val: controller.text,
              bordarCa: bordarColor),
        ),
      ),
    );
  }
}

InputDecoration inputDecorationDef({
  required double radius,
  String? hint,
  IconData? iconStart,
  IconData? iconEnd,
  String? label,
  TextStyle? textStyle,
  String? val,
  Color? bordarCa,
}) {
  return InputDecoration(
    isDense: true,
    hintText: hint,
    labelStyle: textStyle ?? FontManager.w500s16cG,
    hintStyle: textStyle ?? FontManager.w500s16cG,
    prefixIcon: iconStart == null ? null : Icon(iconStart),
    suffixIcon: iconEnd == null
        ? null
        : iconEnd == Icons.favorite
            ? Favorite(isStart: val)
            : Icon(iconEnd),
    prefixIconColor: ColorManager.black,
    suffixIconColor: ColorManager.black,
    contentPadding:
        const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: bordarCa ?? ColorManager.primary)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: bordarCa ?? ColorManager.primary)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: ColorManager.primary, width: 3)),
  );
}

class Favorite extends StatelessWidget {
  const Favorite({
    super.key,
    required this.isStart,
  });
  final String? isStart;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        TextEditingController name = TextEditingController();
        Get.dialog(AlertDialog(
          title: const Column(
            children: [
              Text(
                "إضافة الموقع الى المفضلة",
                style: FontManager.w400s14cB,
              ),
              Divider(),
            ],
          ),
          content: TextFormFieldRadius(
            controller: name,
            hint: "اسم الموقع",
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  TripController tripController = Get.find();
                  UserLocation loc = UserLocation(
                    lat: tripController.start.text == isStart
                        ? tripController.startPostion!.latitude
                        : tripController.endPostion!.latitude,
                    long: tripController.start.text == isStart
                        ? tripController.startPostion!.longitude
                        : tripController.endPostion!.longitude,
                    name: name.text,
                  );
                  var b = await tripController.addUserLocation(loc);
                  Get.back();
                  if (b) {
                    snackbarDef("ملاحظة", "تم اضافة الموقع الى المفضلة");
                  } else {
                    snackbarDef("تحذير", "هذا الموقع مضاف مسبقاً");
                  }
                },
                child: const Text("اضافة", style: FontManager.w400s14cP)),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("إلغاء", style: FontManager.w400s14cB)),
          ],
        ));
      },
      child: Container(
        width: 25,
        decoration: const BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            )),
        child: const Center(
            child: Icon(
          Icons.favorite_outlined,
          color: ColorManager.white,
        )),
      ),
    );
  }
}
