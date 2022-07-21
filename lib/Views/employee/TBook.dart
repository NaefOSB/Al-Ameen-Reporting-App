import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/constant.dart';
import 'package:flutter_app_alameen/core/services/api.dart';
import 'package:flutter_app_alameen/core/services/printing.dart';
import 'package:flutter_app_alameen/core/view_model/t_book.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TBook extends StatefulWidget {
  final employee;

  TBook({this.employee});

  @override
  _TBookState createState() => _TBookState();
}

class _TBookState extends State<TBook> {
  bool _isReportRunning = false;
  var currencyName;
  List<Widget> rows = new List<Widget>();
  List<TableRow> tableRowList = new List<TableRow>();
  DateTime _selectedDate1 = DateTime.utc(2022, 1, 1);
  DateTime _selectedDate2 = DateTime.now();
  String selectedCurrency = "أختر العملة";
  String selectedCurrencyGuid = '';
  List cur = [];
  bool _hasReport = false;
  bool _noData = false;
  List<dynamic> reports = new List<dynamic>();

  getTableRows() async {
    tableRowList = new List<TableRow>();
    var heading = TableRow(children: [
      TableCell(
          child: Text(
        "التاريخ",
        style:
            TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Cairo'),
        textAlign: TextAlign.center,
      )),
      TableCell(
          child: Text(
        "أصل السند",
        style:
            TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Cairo'),
        textAlign: TextAlign.center,
      )),
      TableCell(
          child: Text(
        "مدين",
        style:
            TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Cairo'),
        textAlign: TextAlign.center,
      )),
      TableCell(
          child: Text(
        "دائن",
        style:
            TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Cairo'),
        textAlign: TextAlign.center,
      )),
      TableCell(
          child: Text(
        "الرصيد",
        style:
            TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Cairo'),
        textAlign: TextAlign.center,
      )),
    ]);
    tableRowList.add(heading);

    var dtotal;
    var ctotal;

    setState(() => _isReportRunning = true);
    reports = await APIService.getCustomerReport(
        id: widget.employee['accountGuid'],
        firstDate: _selectedDate1,
        endDate: _selectedDate2,
        currency: selectedCurrencyGuid) as List;
    setState(() => _isReportRunning = false);

    if (reports != null && reports.length > 0) {
      List<TableRow> retrievedData = new List<TableRow>();
      for (int i = 0; i < reports.length; i++) {
        var snd = (reports[i]['snd'] != null)
            ? reports[i]['snd']
            : reports[i]['snd1'];
        dtotal = double.parse(reports[i]['debitTotal'].toString());
        ctotal = double.parse(reports[i]['creditTotal'].toString());
        retrievedData.add(TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TableCell(
                child: Text(
              '${reports[i]['date'].toString()}',
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TableCell(
                child: Text(
              '$snd',
              style: TextStyle(
                  fontSize: 15, color: Colors.black, fontFamily: 'Cairo'),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TableCell(
                child: Text(
              '${reports[i]['debit'].toStringAsFixed(1)}',
              style: TextStyle(
                  fontSize: 15, color: Colors.black, fontFamily: 'Cairo'),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TableCell(
                child: Text(
              '${reports[i]['credit'].toStringAsFixed(1)}',
              style: TextStyle(
                  fontSize: 15, color: Colors.black, fontFamily: 'Cairo'),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TableCell(
                child: Text(
              '${reports[i]['balance'].toStringAsFixed(1)}',
              style: TextStyle(
                  fontSize: 15, color: Colors.black, fontFamily: 'Cairo'),
            )),
          ),
        ]));
        if (i == reports.length - 1) {
          tableRowList.addAll(retrievedData);
          _hasReport = true;
          setState(() {});
        }
      }
      var footer = TableRow(
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          children: [
            TableCell(
                child: Text(
              "المجموع",
              style: TextStyle(
                  fontSize: 15, color: Colors.black, fontFamily: 'Cairo'),
              textAlign: TextAlign.center,
            )),
            TableCell(
                child: Text(
              " ",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            )),
            TableCell(
                child: Text(
              '${dtotal.toStringAsFixed(1)}',
              style: TextStyle(
                  fontSize: 17, color: Colors.black, fontFamily: 'Cairo'),
              textAlign: TextAlign.center,
            )),
            TableCell(
                child: Text(
              '${ctotal.toStringAsFixed(1)}',
              style: TextStyle(
                  fontSize: 17, color: Colors.black, fontFamily: 'Cairo'),
              textAlign: TextAlign.center,
            )),
            TableCell(
                child: Text(
              '${(dtotal - ctotal).toStringAsFixed(1)}',
              style: TextStyle(
                  fontSize: 17, color: Colors.black, fontFamily: 'Cairo'),
              textAlign: TextAlign.center,
            )),
          ]);
      tableRowList.add(footer);
      setState(() {
        _noData = false;
      });
    } else {
      setState(() {
        _hasReport = false;
        _noData = true;
      });
    }
  }

  getCurrency() async {
    cur = await APIService.getCurrency();
  }

  @override
  void initState() {
    currencyName = widget.employee['currency'].toString();
    getCurrency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => printData(),
                icon: Icon(Icons.picture_as_pdf),
              ),
            ],
            title: Text('دفتر الأستاذ',
                style: TextStyle(
                    fontSize: 30, color: Colors.white, fontFamily: 'Cairo')),
            // backgroundColor: Color(int.parse("0xff029FCC")),
            backgroundColor: Colors.lightBlue.shade500,
            centerTitle: true,
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  Divider(),
                  Padding(
                    child: Table(
                      children: [
                        TableRow(children: [
                          TableCell(
                              child: Text(
                            "الزبون    :",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Cairo'),
                            textAlign: TextAlign.right,
                          )),
                          TableCell(
                              child: Text(
                            '${widget.employee['customerName']}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Cairo'),
                            textAlign: TextAlign.right,
                          )),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Text(
                            "الحساب :",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Cairo'),
                            textAlign: TextAlign.right,
                          )),
                          TableCell(
                              child: Text(
                            '${widget.employee['customerName']}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Cairo'),
                            textAlign: TextAlign.right,
                          )),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Text(
                            "العملة   :",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Cairo'),
                            textAlign: TextAlign.right,
                          )),
                          TableCell(
                              child: Text("$currencyName",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'Cairo'))),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Text(
                            "من تاريخ :",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Cairo'),
                            textAlign: TextAlign.right,
                          )),
                          TableCell(
                              child: Text(
                                  '${intl.DateFormat.yMMMEd().format(_selectedDate1)}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'Cairo'))),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Text(
                            "إلى تاريخ :",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Cairo'),
                            textAlign: TextAlign.right,
                          )),
                          TableCell(
                              child: Text(
                                  '${intl.DateFormat.yMMMEd().format(_selectedDate2)}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'Cairo'))),
                        ]),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                  ),

                  // for report button
                  RaisedButton(
                      // color: Color(int.parse("0xffDD7A2B")),
                      color: Colors.lightBlue.shade500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onPressed: () {
                        buildDialog(context);
                      },
                      child: Text('خيـارات التقريـر',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Cairo'))),
                  Divider(
                    color: Colors.black,
                  ),
                  ModalProgressHUD(
                    inAsyncCall: _isReportRunning,
                    child: Column(
                      children: [
                        Visibility(
                          visible: _hasReport,
                          child: Table(
                            border:
                                TableBorder.all(width: 1, color: Colors.grey),
                            children: tableRowList,
                          ),
                        ),
                        (_noData && !_hasReport)
                            ? Container(
                                child: Text(
                                  'لاتوجد اي بيانات لهذا الأستعلام !!',
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Cairo'),
                                ),
                                height: MediaQuery.of(context).size.height / 3,
                                alignment: Alignment.center,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          )),
    );
  }

  void buildDialog(BuildContext context) {
    showDialog(
        context: context,
        child: StatefulBuilder(builder: (context, setState) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Center(
                child: Text("خيارات التقرير",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: 'Cairo',
                    )),
              ),
              content: Container(
                height: 250,
                width: 200,
                child: Column(
                  children: [
                    Divider(
                      color: Colors.blue,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                      child: OutlineButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 7.0,
                        ),
                        child: Text(
                            '${intl.DateFormat.yMMMEd().format(_selectedDate1)}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Cairo')),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.utc(2022, 1, 1),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedDate1 = value;
                            });
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        highlightColor: Colors.blue,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: OutlineButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 7.0,
                        ),
                        child: Text(
                            '${intl.DateFormat.yMMMEd().format(_selectedDate2)}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Cairo')),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedDate2 = value;
                            });
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        highlightColor: Colors.blue,
                      ),
                    ),
                    DropdownButton(
                        hint: Text(
                          "$selectedCurrency",
                          style: TextStyle(fontFamily: 'Cairo'),
                        ),
                        items: cur.map((item) {
                          return DropdownMenuItem(
                            child: Text(item['name'],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Cairo')),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            selectedCurrency = newVal['name'].toString();
                            currencyName = selectedCurrency;
                            selectedCurrencyGuid = newVal['guid'];
                          });
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('إلغاء',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: kPrimaryColor,
                                  fontFamily: 'Cairo')),
                        ),
                        FlatButton(
                          onPressed: () {
                            getTableRows();
                            Get.back();
                          },
                          child: Text('موافق',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: kPrimaryColor,
                                  fontFamily: 'Cairo')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        barrierDismissible: false);
  }

  void printData() {
    if (reports != null && reports.length > 0) {
      // List headers = ['الرصيد', 'دائن', 'مدين', 'أصل السند', 'التاريخ'];
      List<VMTBook> lists = new List<VMTBook>();
      for (int i = 0; i < reports.length; i++) {
        lists.add(VMTBook(
            date: reports[i]['date'],
            balance: reports[i]['balance'],
            bond: (reports[i]['snd'] == null )?reports[i]['snd1']:reports[i]['snd'],
            credit: reports[i]['credit'],
            debit: reports[i]['debit']));


      }

      Printing.printBill(
          invoice: lists,
          accountName: widget.employee['customerName'],
          currency: currencyName,
          firstDate: _selectedDate1,
          endDate: _selectedDate2,
          title: 'دفتر الأستاذ');
    }
  }
}
