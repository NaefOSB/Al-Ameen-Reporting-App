import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/material/material_amount.dart';
import 'package:flutter_app_alameen/Views/widgets/custom_refresh.dart';
import 'package:flutter_app_alameen/Views/widgets/custom_text.dart';
import 'package:flutter_app_alameen/constant.dart';
import 'package:flutter_app_alameen/core/services/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MaterialDetails extends StatefulWidget {
  var material;
  final mtt;

  MaterialDetails({this.material, this.mtt});

  @override
  _MaterialDetailsState createState() => _MaterialDetailsState();
}

class _MaterialDetailsState extends State<MaterialDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.picture_as_pdf),
              ),
            ],
            title: Text('الصنف',
                style: TextStyle(
                    fontSize: 30, color: Colors.white, fontFamily: 'Cairo')),
            backgroundColor: kPrimaryColor,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            reverse: true,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                    alignment: Alignment.center,
                    child: FutureBuilder(
                      future: APIService.getMaterialDetails(
                          '${widget.material['guid']}'),
                      builder: (context, snapShot) {
                        if (snapShot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                              height: size.height,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator());
                        } else if (snapShot.hasData) {
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10.0),
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  '${widget.material['name']}',
                                  style: TextStyle(
                                      fontSize: 27,
                                      color: Colors.black,
                                      fontFamily: 'Cairo'),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Table(
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        children: [
                                          TableRow(children: [
                                            TableCell(
                                                child: Text(
                                              "المجموعة :",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontFamily: 'Cairo'),
                                              textAlign: TextAlign.right,
                                            )),
                                            TableCell(
                                                child: Text(
                                              '${snapShot.data['groupName']}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontFamily: 'Cairo'),
                                              textAlign: TextAlign.right,
                                            )),
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                                child: Text(
                                              "النوع :",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontFamily: 'Cairo'),
                                              textAlign: TextAlign.right,
                                            )),
                                            TableCell(
                                                child: Text(
                                              '${snapShot.data['typeName']}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontFamily: 'Cairo'),
                                              textAlign: TextAlign.right,
                                            )),
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                                child: Text(
                                              "الوحدة الأفتراضية :",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontFamily: 'Cairo'),
                                              textAlign: TextAlign.right,
                                            )),
                                            TableCell(
                                                child: Text(
                                              '${snapShot.data['unit']}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontFamily: 'Cairo'),
                                              textAlign: TextAlign.right,
                                            )),
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                                child: Text(
                                              "العملة :",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontFamily: 'Cairo'),
                                              textAlign: TextAlign.right,
                                            )),
                                            TableCell(
                                                child: Text(
                                              '${snapShot.data['currency']}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontFamily: 'Cairo'),
                                              textAlign: TextAlign.right,
                                            )),
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                                child: Text(
                                              "الكمية الحالية :",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontFamily: 'Cairo'),
                                              textAlign: TextAlign.right,
                                            )),
                                            TableCell(
                                                child: Text(
                                              '${snapShot.data['quantity']}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontFamily: 'Cairo'),
                                              textAlign: TextAlign.right,
                                            )),
                                          ]),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 800.0,
                                      height: 50.0,
                                      child: Card(
                                        color: Colors.grey,
                                        child: Center(
                                          child: Text(
                                            'رصيد الحركة',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontFamily: 'Cairo'),
                                            textAlign: TextAlign.end,
                                          ), //Text
                                        ), //Center
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.3,
                                                height: 50.0,
                                                child: Card(
                                                  child: Center(
                                                    child: Text(
                                                      'الإدخال',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.black,
                                                          fontFamily: 'Cairo'),
                                                      textAlign: TextAlign.end,
                                                    ), //Text
                                                  ), //Center
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.7,
                                                height: 50.0,
                                                child: Card(
                                                  child: Center(
                                                    child: Text(
                                                      '${snapShot.data['input']}',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontFamily: 'Cairo'),
                                                      textAlign: TextAlign.end,
                                                    ), //Text
                                                  ), //Center
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.3,
                                                height: 50.0,
                                                child: Card(
                                                  child: Center(
                                                    child: Text(
                                                      'الإخراج',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.black,
                                                          fontFamily: 'Cairo'),
                                                      textAlign: TextAlign.end,
                                                    ), //Text
                                                  ), //Center
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.7,
                                                height: 50.0,
                                                child: Card(
                                                  child: Center(
                                                    child: Text(
                                                      '${snapShot.data['output']}',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontFamily: 'Cairo'),
                                                      textAlign: TextAlign.end,
                                                    ), //Text
                                                  ), //Center
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.3,
                                                height: 50.0,
                                                child: Card(
                                                  child: Center(
                                                    child: Text(
                                                      'الرصيد',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.black,
                                                          fontFamily: 'Cairo'),
                                                      textAlign: TextAlign.end,
                                                    ), //Text
                                                  ), //Center
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.7,
                                                height: 50.0,
                                                child: Card(
                                                  child: Center(
                                                    child: Text(
                                                      '${snapShot.data['balance']}',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontFamily: 'Cairo'),
                                                      textAlign: TextAlign.end,
                                                    ), //Text
                                                  ), //Center
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ExpansionTile(
                                title: Text(
                                  'التقارير',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontFamily: 'Cairo'),
                                ),
                                children: [
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  ListTile(
                                    title: Text(
                                      'كميات المستودعات',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontFamily: 'Cairo'),
                                    ),
                                    leading: Icon(
                                      Icons.picture_as_pdf_sharp,
                                      color: Colors.red,
                                    ),
                                    trailing: Icon(Icons.arrow_forward),
                                    onTap: () {
                                      Get.to(() => MaterialAmount(
                                            material: snapShot.data,
                                          ));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return Container(
                              height: size.height - size.height / 8,
                              alignment: Alignment.center,
                              child: CustomRefresh(
                                title: 'خطأ بالأتصال',
                                onTap: () => setState(() {}),
                              ));
                        }
                      },
                    )),
              ],
            ),
          )),
    );
  }
}
