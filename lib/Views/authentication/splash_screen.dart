import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/core/services/shared_preferences_service.dart';
import 'package:get/get.dart';
import '../home/home.dart';
import 'welcome.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getUserInfo() async {
    var user = await SharedPreferencesService().getUserInfo();
    if (user.length <= 0) {
      Get.offAll(Welcome());
    } else {
      Get.offAll(Home());
    }
  }

  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      getUserInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
        child: Center(
          child: Image.asset(
            'assets/images/ameenback.PNG',
            width: size.width,
            height: size.height,
          ),
        ),
      ),
    );
  }
}
