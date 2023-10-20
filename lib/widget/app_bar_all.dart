import 'package:flutter/material.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';

AppBar appBarAll(
        {String? title,
        required void Function() press,
        required IconData icon}) =>
    AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title ?? "",
        style: FontManager.w500s28cB,
      ),
      leading: IconButton(
        onPressed: press,
        icon: Icon(icon, color: ColorManager.black),
      ),
    );
