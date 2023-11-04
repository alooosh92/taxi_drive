import 'package:flutter/material.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 0),
      child: TextFormField(
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
            iconStart: iconStart),
      ),
    );
  }
}

InputDecoration inputDecorationDef(
    {required double radius,
    String? hint,
    IconData? iconStart,
    IconData? iconEnd,
    String? label}) {
  return InputDecoration(
    label: Text(label ?? ""),
    isDense: true,
    hintText: hint,
    hintStyle: FontManager.w500s16cG,
    prefixIcon: iconStart == null ? null : Icon(iconStart),
    suffixIcon: iconEnd == null ? null : Icon(iconEnd),
    prefixIconColor: ColorManager.black,
    suffixIconColor: ColorManager.black,
    contentPadding:
        const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: ColorManager.primary)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: ColorManager.primary)),
  );
}
