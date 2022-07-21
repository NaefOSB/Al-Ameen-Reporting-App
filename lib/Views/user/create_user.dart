import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/home/home.dart';
import 'package:flutter_app_alameen/Views/widgets/custom_dropdown.dart';
import 'package:flutter_app_alameen/Views/widgets/rounded_button.dart';
import 'package:flutter_app_alameen/Views/widgets/rounded_input_field.dart';
import 'package:flutter_app_alameen/core/services/api.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  TextEditingController _userName;
  TextEditingController _user;
  TextEditingController _password;
  TextEditingController _confirmPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<dynamic> users = [];
  bool userHasError = false;
  bool _isLoading = false;

  @override
  void initState() {
    getUsers();
    _userName = new TextEditingController();
    _user = new TextEditingController();
    _password = new TextEditingController();
    _confirmPassword = new TextEditingController();
    super.initState();
  }

  getUsers() async {
    var data = await APIService.getUsers();

    setState(() {
      users = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text('إنشاء مستخدم'),
            centerTitle: true,
          ),
          body: Container(
            alignment: Alignment.center,
            child: Container(
              width: size.width * 0.85,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedTextField(
                        hintText: 'اسم المستخدم',
                        icon: Icons.person,
                        controller: _userName,
                        validator: (value) {
                          if (value.toString().isEmpty)
                            return 'الرجاء إدخال كلمة المرور الحالية';
                        },
                      ),
                      CustomDropDown(
                        icon: Icons.group,
                        elements: users,
                        hintText: 'أختر المستخدم',
                        controller: _user,
                        hasError: userHasError,
                        errorText: 'الرجاء إختيار مستخدم',
                      ),
                      RoundedTextField(
                        hintText: 'كلمة المرور ',
                        controller: _password,
                        isPassword: true,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'الرجاء إدخال كلمة المرور';
                          }
                        },
                      ),
                      RoundedTextField(
                        hintText: 'تأكيد كلمة المرور ',
                        controller: _confirmPassword,
                        isPassword: true,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'الرجاء تأكيد كلمة المرور';
                          } else if (_password.text != _confirmPassword.text) {
                            return 'لم تتطابق كلمات المرور المُدخلة';
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      RoundedButton(
                          text: "تعديل كلمة المرور",
                          fontSize: 15,
                          color: Colors.lightBlue.shade100,
                          // color: Color(int.parse("0xffF6921E")),
                          textColor: Colors.black.withOpacity(0.5),
                          // textColor: Colors.white,
                          press: () async {
                            try {
                              if (_formKey.currentState.validate() &&
                                  _user.text != 'أختر المستخدم') {
                                setState(() {
                                  userHasError = false;
                                  _isLoading = true;
                                });
                                var result = await APIService.createUser(
                                    _user.text, _userName.text, _password.text);
                                setState(() => _isLoading = false);
                                if (result == 200) {
                                  Get.offAll(Home());
                                }
                              } else {
                                setState(() {
                                  if (_user.text == 'أختر المستخدم') {
                                    userHasError = true;
                                  } else {
                                    userHasError = false;
                                  }
                                });
                              }
                            } catch (e) {
                              setState(() => _isLoading = false);
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
