import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/widget/app_bar_all.dart';
import 'package:taxi_drive/widget/button_primary.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({
    super.key,
    required this.tileAppBar,
    this.listTile,
    this.listText,
    this.isRegister,
  });
  final String tileAppBar;
  final List<String>? listTile;
  final List<String>? listText;
  final bool? isRegister;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAll(
        press: () => Get.back(),
        icon: Icons.arrow_back_ios,
        title: tileAppBar,
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image.asset(
                  'lib/asset/images/logo.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  width: MediaQuery.sizeOf(context).height * 0.2,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  width: MediaQuery.sizeOf(context).width,
                  child: ListView.builder(
                    itemCount: listText!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listTile == null ? "" : listTile![index],
                            style: FontManager.w400s16cB,
                            overflow: TextOverflow.fade,
                          ),
                          Text(
                            listText == null ? "" : listText![index],
                            style: FontManager.w400s14cG,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                ButtonPrimary(press: () {}, text: "متابعة")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
