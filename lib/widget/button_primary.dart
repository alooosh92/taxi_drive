import 'package:flutter/material.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    super.key,
    required this.press,
    required this.text,
    this.color,
    this.textStyle,
    this.autoSize,
  });
  final String text;
  final void Function()? press;
  final Color? color;
  final TextStyle? textStyle;
  final Size? autoSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? ColorManager.primary,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        maximumSize: autoSize ?? Size(MediaQuery.sizeOf(context).width, 50),
        minimumSize: autoSize ?? Size(MediaQuery.sizeOf(context).width, 50),
      ),
      onPressed: press,
      child: Text(text, style: textStyle ?? FontManager.w600s16cW),
    );
  }
}
