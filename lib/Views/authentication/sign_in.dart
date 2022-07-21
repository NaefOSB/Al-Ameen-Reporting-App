import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/home/home.dart';
import 'package:flutter_app_alameen/Views/widgets/custom_alert.dart';
import 'package:flutter_app_alameen/core/services/api.dart';
import 'package:flutter_app_alameen/core/services/shared_preferences_service.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var _formKey = GlobalKey<FormState>();
  var passwordController = new TextEditingController();
  var userNameController = new TextEditingController();
  bool _isPasswordSeen = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/signInIcons.png",
                          ),
                          fit: BoxFit.fill)),
                  height: size.height * 0.4,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 60, 10, 0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاء إدخال اسم المستخدم';
                        }
                        return null;
                      },
                      controller: userNameController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontFamily: 'Cairo'),
                      // autofocus: true,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        labelText: 'اسم المستخدم',
                        prefixIcon: Icon(Icons.account_circle),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاء إدخال كلمة المرور';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) => signInProcess(),
                      controller: passwordController,
                      obscureText: _isPasswordSeen,
                      style: TextStyle(fontFamily: 'Cairo'),
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        labelText: 'كلمة المـرور',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordSeen = !_isPasswordSeen;
                            });
                          },
                          icon: Icon((_isPasswordSeen)
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 7.0),
                      textColor: Colors.white,
                      color: Color(int.parse("0xffDD7A2B")),
                      child: Text('تسجيل الدخول',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 25,
                              // color: Colors.white,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo')),
                      onPressed: signInProcess,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signInProcess() async {
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = true);
      var user = await APIService.signIn(
          userNameController.text, passwordController.text);

      if (user != 'error' && user != 'wrongLoginInfo') {
        if (user != null &&
            user['userGuid'] != null &&
            user['isAdmin'] != null &&
            user != 'error') {
          var sp = await SharedPreferencesService().setUserData(
              userNameController.text.toString(),
              user['userGuid'].toString(),
              user['guid'],
              user['isAdmin']);
          setState(() => _isLoading = false);
          if (sp) {
            Get.offAll(Home());
          }
        }
      } else if (user == 'wrongLoginInfo') {
        setState(() => _isLoading = false);
        showDialog(
          context: context,
          builder: (context) => CustomAlert(
            title: 'حدث خطأ',
            content:
                'اسم المستخدم او كلمة المرور خاطئة ،الرجاء إدخال بيانات صحيحة!!',
            btnText: 'موافق',
            onPressed: () {
              Get.back();
            },
          ),
        );
      } else {
        setState(() => _isLoading = false);
        showDialog(
          context: context,
          builder: (context) => CustomAlert(
            title: 'حدث خطأ',
            content: 'حدث خطأ اثناء تسجيل الدخول ، الرجاء المحاولة لاحقاً' +user,
            btnText: 'موافق',
            onPressed: () {
              Get.back();
            },
          ),
        );
      }
    }
  }
}
