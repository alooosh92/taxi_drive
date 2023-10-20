import 'package:flutter/material.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';

class RowTextPress extends StatelessWidget {
  const RowTextPress({
    super.key,
    required this.icon,
    required this.press,
    required this.text,
  });
  final void Function() press;
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: ColorManager.white, size: 25),
                const SizedBox(width: 15),
                Text(text, style: FontManager.w500s15cW)
              ],
            ),
            const Icon(Icons.arrow_forward_ios,
                color: ColorManager.white, size: 25),
          ],
        ),
      ),
    );
  }
}
