import 'package:flutter/material.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    super.key,
    required this.press,
    required this.text,
    this.color,
  });
  final String text;
  final void Function() press;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? ColorManager.primary,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        maximumSize: Size(MediaQuery.sizeOf(context).width, 50),
        minimumSize: Size(MediaQuery.sizeOf(context).width, 50),
      ),
      onPressed: press,
      child: Text(text, style: FontManager.w600s16cW),
    );
  }
}
