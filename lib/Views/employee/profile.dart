import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/employee/account_report.dart';
import 'package:flutter_app_alameen/Views/employee/TBook.dart';
import 'package:flutter_app_alameen/Views/widgets/social_icon.dart';
import 'package:flutter_app_alameen/constant.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  final employee;

  Profile({this.employee});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var data;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text('العميل',
                style: TextStyle(
                    fontSize: 30, color: Colors.white, fontFamily: 'Cairo')),
            backgroundColor: kPrimaryColor,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Icon(
                          Icons.account_circle,
                          size: 120,
                          color: Colors.blue,
                        ),
                      ) //Text
                      ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(8.0),
                    child: Text('${widget.employee['customerName']}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontFamily: 'Cairo')),
                  )),
                  //for social icon
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(20.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                              spreadRadius: 2.0,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            SocialIcon(
                              icon: Icons.call,
                              color: Colors.green,
                            ),
                            SocialIcon(
                              icon: Icons.chat_bubble,
                              color: Colors.teal,
                            ),
                            SocialIcon(
                              icon: Icons.message,
                              color: Colors.red,
                            ),
                            SocialIcon(
                              icon: Icons.location_pin,
                              color: Colors.yellow,
                            ),
                            SocialIcon(
                              icon: Icons.language,
                              color: Colors.redAccent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Expanded(
                      flex: 2,
                      child: ListView(
                        children: [
                          ExpansionTile(
                            title: Text('التقارير',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontFamily: 'Cairo')),
                            children: [
                              Divider(
                                color: Colors.grey,
                              ),
                              ListTile(
                                title: Text('دفتر الأستاذ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontFamily: 'Cairo')),
                                leading: Icon(
                                  Icons.picture_as_pdf_sharp,
                                  color: Colors.red,
                                ),
                                trailing: Icon(Icons.arrow_forward),
                                onTap: () {
                                  Get.to(
                                    () => TBook(
                                      employee: widget.employee,
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text('كشف الحساب',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontFamily: 'Cairo')),
                                leading: Icon(
                                  Icons.picture_as_pdf_sharp,
                                  color: Colors.red,
                                ),
                                trailing: Icon(Icons.arrow_forward),
                                onTap: () {
                                  Get.to(() => AccountReport(
                                        employee: widget.employee,
                                      ));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
