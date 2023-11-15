import 'package:flutter/material.dart';
import 'package:taxi_drive/res/color_manager.dart';

class DrawerButtonDef extends StatelessWidget {
  const DrawerButtonDef({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 20,
      child: IconButton(
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
        icon: const Icon(Icons.list_sharp,
            textDirection: TextDirection.ltr,
            color: ColorManager.primary,
            size: 40),
      ),
    );
  }
}
