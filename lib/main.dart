import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/firebase_options.dart';
import 'package:taxi_drive/res/binding_def.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/screen/auth/auth.dart';
import 'package:flu_wake_lock/flu_wake_lock.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FluWakeLock fluWakeLock = FluWakeLock();
  fluWakeLock.enable();
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
      home: const Auth(),
    );
  }
}
