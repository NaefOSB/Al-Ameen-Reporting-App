import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/accounting/accounts.dart';
import 'package:flutter_app_alameen/Views/employee/employees.dart';
import 'package:flutter_app_alameen/Views/material/materials.dart';
import 'package:flutter_app_alameen/Views/widgets/custom_button.dart';
import 'package:flutter_app_alameen/Views/widgets/drawer_list.dart';
import 'package:flutter_app_alameen/constant.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'الأمين',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 31,
              color: Colors.white,
            ),
          ),
          backgroundColor: kPrimaryColor,
          centerTitle: true,
        ),
        endDrawer: CustomDrawer(
          selectedPageId: 0,
        ),
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomButton(
                  title: 'الحسابات',
                  imagePath: 'assets/images/accounts.PNG',
                  onPressed: () => Get.to(() => Accounts()),
                ),
                CustomButton(
                    title: 'العمـلاء',
                    imagePath: 'assets/images/employee.PNG',
                    onPressed: () => Get.to(() => Employees())),
                CustomButton(
                    title: 'الأصنـاف',
                    imagePath: 'assets/images/paper.PNG',
                    onPressed: () => Get.to(() => Materials())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
