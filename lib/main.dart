import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/res/binding_def.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/screen/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Cairo", primaryColor: ColorManager.primary),
      locale: const Locale("ar"),
      supportedLocales: const [Locale("ar")],
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      initialBinding: BindingDef(),
      home: const SplashScreen(),
    );
  }
}
