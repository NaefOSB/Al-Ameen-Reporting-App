import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/home/home.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Views/authentication/splash_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'إستعلامات الأمين',
      theme: ThemeData(fontFamily: 'Cairo'),
      // home: SplashScreen(),
      home: Home(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
