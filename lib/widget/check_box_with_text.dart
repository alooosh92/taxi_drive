import 'package:flutter/material.dart';
import 'package:taxi_drive/res/color_manager.dart';

class CheckBoxWithText extends StatefulWidget {
  const CheckBoxWithText({
    super.key,
    required this.text,
  });
  final String text;
  @override
  State<CheckBoxWithText> createState() => _CheckBoxWithTextState();
}

bool _check = false;

class _CheckBoxWithTextState extends State<CheckBoxWithText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _check,
          onChanged: (value) {
            setState(() {
              _check = !_check;
            });
          },
          checkColor: ColorManager.white,
          activeColor: ColorManager.primary,
        ),
        Text(widget.text)
      ],
    );
  }
}
