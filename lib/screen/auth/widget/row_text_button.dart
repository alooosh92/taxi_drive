import 'package:flutter/material.dart';
import 'package:taxi_drive/res/font_manager.dart';

class RowTextButton extends StatelessWidget {
  const RowTextButton({
    super.key,
    required this.text,
    required this.textButton,
    required this.press,
  });
  final String text;
  final String textButton;
  final void Function() press;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: FontManager.w500s15cB,
        ),
        TextButton(
          onPressed: press,
          child: Text(textButton, style: FontManager.w700s15cB),
        )
      ],
    );
  }
}
