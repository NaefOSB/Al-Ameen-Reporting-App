import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/home/home.dart';
import 'package:flutter_app_alameen/Views/server_details/server_details.dart';
import 'package:flutter_app_alameen/core/services/api.dart';
import 'package:get/get.dart';
import '../employee/employees.dart';
import '../material/materials.dart';
import '../accounting/accounts.dart';

class MenuItem extends StatelessWidget {
  final int id;
  final String title;
  final IconData icon;
  final int selectedPageIndex;

  MenuItem({this.id, this.title, this.icon, this.selectedPageIndex});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selectedPageIndex == id
          ? Color(int.parse("0xffDD7A2B"))
          : Colors.transparent,
      child: InkWell(
        onTap: () {
          // to close to drawer
          Get.back();

          if (id == 0) {
            if (selectedPageIndex == id) {
              Get.back();
            } else {
              Get.offAll(Home());
            }
          } else if (id == 1) {
            if (selectedPageIndex == id) {
              Get.back();
            } else {
              Get.to(Accounts());
            }
          } else if (id == 2) {
            if (selectedPageIndex == id) {
              Get.back();
            } else {
              Get.to(Employees());
            }
          } else if (id == 3) {
            if (selectedPageIndex == id) {
              Get.back();
            } else {
              Get.to(Materials());
            }
          } else if (id == 4) {
            APIService.signOut();
          } else if (id == 5) {
            Get.to(() => ServerDetails());
          }
        },
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                  child: Icon(
                icon,
                size: 25,
                color: Colors.black,
              )),
              Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
