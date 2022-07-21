import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/authentication/sign_in.dart';
import 'package:get/get.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            //image
            Container(
              height: size.height * 0.85,
              width: size.width,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Center(
                child: Image.asset(
                  'assets/images/ameenback.PNG',
                ),
              ),
            ),
            //btn to start
            Container(
                height: 70,
                width: 400,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: RaisedButton(
                  color: Color(int.parse("0xffDD7A2B")),
                  child: Text('ابـدأ الآن',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo')),
                  onPressed: () => Get.to(() => SignIn()),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
