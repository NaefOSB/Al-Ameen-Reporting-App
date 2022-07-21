import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/accounting/account_t_book.dart';
import 'package:flutter_app_alameen/Views/widgets/custom_text.dart';
import 'package:flutter_app_alameen/constant.dart';
import 'package:flutter_app_alameen/core/services/api.dart';
import 'package:get/get.dart';

class AccountDetails extends StatefulWidget {
  final account;

  AccountDetails({this.account});

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('تفاصيل الحساب',
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
          body: FutureBuilder(
            future: APIService.getAccountDetails('${widget.account['guid']}'),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapShot.hasData) {
                var credit = snapShot.data['credit'];
                credit = credit.toStringAsFixed(1);

                var debit = snapShot.data['debit'];
                debit = debit.toStringAsFixed(1);

                var balance = snapShot.data['balance'];
                balance = balance.toStringAsFixed(1);
                return SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Center(
                      child: ListView(
                        physics: ScrollPhysics(),
                        children: [
                          Divider(),
                          // for the account name
                          Container(
                            margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              // 'اسم الصنف'
                              '${widget.account['name']}',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontFamily: 'Cairo'),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          // for account details
                          Table(
                            border: TableBorder.all(
                                width: 0, color: Colors.black45),
                            children: [
                              TableRow(children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 3.0),
                                    child: CustomText(
                                      title: 'العملة :',
                                      alignment: Alignment.centerRight,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 3.0),
                                    child: CustomText(
                                      title: '${snapShot.data['currency']}',
                                      alignment: Alignment.center,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 3.0),
                                    child: CustomText(
                                      title: "الحساب الرئيسي :",
                                      alignment: Alignment.centerRight,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 3.0),
                                    child: CustomText(
                                      title: '${snapShot.data['acParent']}',
                                      alignment: Alignment.center,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 3.0),
                                    child: CustomText(
                                      title: "الحساب الختامي :",
                                      alignment: Alignment.centerRight,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 3.0),
                                    child: CustomText(
                                      title: '${snapShot.data['acFinally']}',
                                      alignment: Alignment.center,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ]),
                            ],
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
                            // padding: EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      // width: 110.0,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height: 50.0,
                                      child: Card(
                                        child: CustomText(
                                          title: 'مدين',
                                          alignment: Alignment.center,
                                        ), //Center
                                      ),
                                    ),
                                    SizedBox(
                                      // width: 300.0,
                                      width: MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).size.width / 3,
                                      height: 50.0,
                                      child: Card(
                                        child: CustomText(
                                          title: '$credit',
                                          alignment: Alignment.center,
                                          fontSize: 20.0,
                                        ), //Center
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height: 50.0,
                                      child: Card(
                                        child: CustomText(
                                          title: 'دائن',
                                          alignment: Alignment.center,
                                        ), //Center
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).size.width / 3,
                                      height: 50.0,
                                      child: Card(
                                        child: CustomText(
                                          title: '$debit',
                                          alignment: Alignment.center,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height: 50.0,
                                      child: Card(
                                        child: CustomText(
                                          title: 'الرصيد',
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).size.width / 3,
                                      height: 50.0,
                                      child: Card(
                                        child: CustomText(
                                          title: '$balance',
                                          alignment: Alignment.center,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 800.0,
                                  height: 100.0,
                                  child: Card(
                                    child: CustomText(
                                      title: '${snapShot.data['balanceText']}',
                                      alignment: Alignment.center,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // for bill
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
                                  'دفتر الأستاذ',
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
                                  Get.to(() => AccountTBook(
                                        employee: snapShot.data,
                                      ));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                    child: CustomText(
                  title: 'خطأ بالأتصال',
                  alignment: Alignment.center,
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}
