import 'package:flutter/material.dart';
import 'package:taxi_drive/res/font_manager.dart';

class LocationInSheet extends StatelessWidget {
  const LocationInSheet({
    super.key,
    required this.color,
    required this.desc,
    required this.name,
  });
  final String name;
  final String desc;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, color: color),
            Text(
              name,
              style: FontManager.w500s16cB,
            )
          ],
        ),
        Text(
          desc,
          style: FontManager.w400s12cG,
        )
      ],
    );
  }
}
