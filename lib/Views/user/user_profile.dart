import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/user/change_password.dart';
import 'package:flutter_app_alameen/Views/user/create_user.dart';
import 'package:flutter_app_alameen/constant.dart';
import 'package:flutter_app_alameen/core/services/api.dart';
import 'package:flutter_app_alameen/core/services/shared_preferences_service.dart';
import 'package:get/get.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('المستخدم',
              style: TextStyle(
                  fontSize: 30, color: Colors.white, fontFamily: 'Cairo')),
          backgroundColor: kPrimaryColor,
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.account_circle,
                      size: 120,
                      color: Colors.blue,
                    ) //Text
                    ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      '${SharedPreferencesService().getString('userName')}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontFamily: 'Cairo')),
                )),
                Expanded(
                  flex: 2,
                  child: ListView(
                    children: [
                      ExpansionTile(
                        title: Text('إعدادات الحساب',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontFamily: 'Cairo')),
                        children: [
                          Divider(
                            color: Colors.grey,
                          ),
                          ListTile(
                            title: Text('تغير كلمة المرور',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: 'Cairo')),
                            leading: Icon(
                              Icons.lock,
                              color: Colors.red,
                            ),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () => Get.to(() => ChangePassword()),
                          ),
                        ],
                      ),
                      (SharedPreferencesService().getBool('isAdmin')!=null&& SharedPreferencesService().getBool('isAdmin'))
                          ? ExpansionTile(
                              title: Text('إعدادات اُخرى',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontFamily: 'Cairo')),
                              children: [
                                Divider(
                                  color: Colors.grey,
                                ),
                                ListTile(
                                  title: Text('إنشاء مستخدم جديد',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontFamily: 'Cairo')),
                                  leading: Icon(
                                    Icons.person,
                                    color: Colors.red,
                                  ),
                                  trailing: Icon(Icons.arrow_forward),
                                  onTap: () => Get.to(() => CreateUser()),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
