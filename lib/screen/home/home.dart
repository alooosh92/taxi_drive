import 'package:flutter/material.dart';
import 'package:taxi_drive/widget/drawer_home.dart';
import 'package:taxi_drive/widget/app_bar_all.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: appBarAll(
          press: () => scaffoldKey.currentState!.openDrawer(),
          icon: Icons.menu_sharp),
      drawer: const DrawerHome(name: "علاء بعاج"),
    );
  }
}
