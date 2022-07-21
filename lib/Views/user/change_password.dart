import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/home/home.dart';
import 'package:flutter_app_alameen/Views/widgets/custom_alert.dart';
import 'package:flutter_app_alameen/Views/widgets/rounded_button.dart';
import 'package:flutter_app_alameen/Views/widgets/rounded_input_field.dart';
import 'package:flutter_app_alameen/core/services/api.dart';
import 'package:flutter_app_alameen/core/services/shared_preferences_service.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _passwordController;

  TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    _passwordController = new TextEditingController();
    _confirmPasswordController = new TextEditingController();
    super.initState();
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
            title: Text('تغيير كلمة المرور'),
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
                        hintText: 'كلمة المرور الجديدة',
                        isPassword: true,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'الرجاء إدخال كلمة المرور';
                          }
                        },
                        icon: Icons.lock,
                        controller: _passwordController,
                      ),
                      RoundedTextField(
                        hintText: 'تأكيد كلمة المرور الجديدة',
                        isPassword: true,
                        controller: _confirmPasswordController,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'الرجاء تأكيد كلمة المرور';
                          } else if (_passwordController.text !=
                              _confirmPasswordController.text) {
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
                          if (_formKey.currentState.validate()) {
                            setState(() => _isLoading = true);
                            var userGuid = SharedPreferencesService()
                                .getString('guid')
                                .toString();
                            var result = await APIService.changePassword(
                                userGuid, _passwordController.text.toString());
                            setState(() => _isLoading = false);
                            if(result == 200) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) =>
                                      CustomAlert(
                                        onPressed: () {
                                          Get.offAll(Home());
                                        },
                                        title: 'عملية ناجحة',
                                        content: 'تمت عملية التعديل بنجاح',
                                        btnText: 'موافق',
                                      ));
                            }
                          }
                        },
                      ),
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
