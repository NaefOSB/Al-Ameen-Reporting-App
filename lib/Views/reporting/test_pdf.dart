import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_app_alameen/Model/vm_material_quantity.dart';
import 'package:flutter_app_alameen/Views/reporting/pdf_api.dart';
import 'package:flutter_app_alameen/Views/reporting/utils.dart';
import 'package:flutter_app_alameen/core/services/shared_preferences_service.dart';
import 'package:flutter_app_alameen/core/view_model/e_a_details.dart';
import 'package:flutter_app_alameen/core/view_model/t_book.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'models/invoice.dart';

class TestPDF {
  static Future<File> generateTBookInvoice(
      {List<VMTBook> invoice,
      title,
      accountName,
      currency,
      firstDate,
      endDate}) async {
    final pdf = Document();

    var arabicFont4 =
        Font.ttf(await rootBundle.load("assets/fonts/Janna-LT-Bold.ttf"));
    var assetImage = MemoryImage(
      (await rootBundle.load('assets/images/ameenback.PNG'))
          .buffer
          .asUint8List(),
    );

    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(
          base: arabicFont4,
        ),

        header: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: (invoice.length <= 10)
              ? buildHeader(assetImage, title)
              : buildHeader2(
                  assetImage, title, accountName, currency, firstDate, endDate),
        ),
        build: (context) => <Widget>[
          if (invoice.length <= 10) ...{
            SizedBox(height: 70),
            buildInvoiceInfoForTBook(
                accountName: accountName,
                currency: currency,
                fromDate: firstDate,
                endDate: endDate),
            SizedBox(height: 10),
            buildTBookBody(
              invoice: invoice,
            ),
          } else ...{
            for (int i = 0; i < invoice.length; i++) ...{
              Container(
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child:
                              Text('${invoice[i].balance.toStringAsFixed(1)}'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child:
                              Text('${invoice[i].credit.toStringAsFixed(1)}'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text('${invoice[i].debit.toStringAsFixed(1)}'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                              '${(invoice[i].bond == null) ? '' : invoice[i].bond}'),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                                '${Utils.formatDate(DateTime.parse(invoice[i].date))}')),
                      ])),
              (i == invoice.length - 1) ? getTotal(invoice) : Container(),
            }
          },
        ],

        // footer: (context)=>buildFooter(invoice),
        maxPages: 100,
      ),
    );

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Future<File> generateEmployeeAccountDetails(
      {List<EADetails> invoice,
      title,
      accountName,
      currency,
      firstDate,
      endDate}) async {
    final pdf = Document();

    var arabicFont4 =
        Font.ttf(await rootBundle.load("assets/fonts/Janna-LT-Bold.ttf"));
    var assetImage = MemoryImage(
      (await rootBundle.load('assets/images/ameenback.PNG'))
          .buffer
          .asUint8List(),
    );

    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(
          base: arabicFont4,
        ),

        header: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: (invoice.length <= 10)
              ? buildHeader(assetImage, title)
              : buildHeader3(
                  assetImage, title, accountName, currency, firstDate, endDate,
                  isEmployeeAccountDetails: true),
        ),
        build: (context) => <Widget>[
          if (invoice.length <= 10) ...{
            SizedBox(height: 70),
            buildInvoiceInfoForTBook(
                accountName: accountName,
                currency: currency,
                fromDate: firstDate,
                endDate: endDate),
            SizedBox(height: 10),
            buildTBookBody2(
              invoice: invoice,
            ),
          } else ...{
            for (int i = 0; i < invoice.length; i++) ...{
              Container(
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          child: Column(children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Text('${invoice[i].details}'),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child:
                              Text('${invoice[i].balance.toStringAsFixed(1)}'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child:
                              Text('${invoice[i].credit.toStringAsFixed(1)}'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text('${invoice[i].debit.toStringAsFixed(1)}'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                              '${(invoice[i].bond == null) ? '' : invoice[i].bond}'),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                                '${Utils.formatDate(DateTime.parse(invoice[i].date))}')),
                      ])),
              (i == invoice.length - 1) ? getTotal2(invoice) : Container(),
            }
          },
        ],

        // footer: (context)=>buildFooter(invoice),
        maxPages: 100,
      ),
    );

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Future<File> generateMaterialQuantity(
      {List<VMaterialQuantity> materialQuantity,
      String quantityName,
      category,
      group,
      currency}) async {
    final pdf = Document();

    var arabicFont4 =
        Font.ttf(await rootBundle.load("assets/fonts/Janna-LT-Bold.ttf"));
    var assetImage = MemoryImage(
      (await rootBundle.load('assets/images/ameenback.PNG'))
          .buffer
          .asUint8List(),
    );

    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(
          base: arabicFont4,
        ),

        header: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: buildHeader(assetImage, 'كمية المستودعات')),
        build: (context) => <Widget>[
          SizedBox(height: 70),
          buildInvoiceInfoForTBook2(
              category: category, group: group, currency: currency),
          SizedBox(height: 10),
          buildTBookBody3(
              quantityName: quantityName, quantity: materialQuantity),
        ],

        // footer: (context)=>buildFooter(invoice),
        maxPages: 100,
      ),
    );

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(assetImage, title) => Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  height: 60,
                  width: 200,
                  child: Image(
                    assetImage,
                  ),
                ),
                Text(title,
                    style: TextStyle(
                      fontSize: 24,

                      // fontWeight: FontWeight.bold
                    )),
                buildStoreNameAndDate(),
              ]),
            ],
          ),
        ),
      );

  static Widget buildHeader2(
          assetImage, title, accountName, currency, firstDate, endDate,
          {isEmployeeAccountDetails = false}) =>
      Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  height: 60,
                  width: 200,
                  child: Image(
                    assetImage,
                  ),
                ),
                Text(title,
                    style: TextStyle(
                      fontSize: 24,

                      // fontWeight: FontWeight.bold
                    )),
                buildStoreNameAndDate(),
              ]),
              SizedBox(height: 70),
              buildInvoiceInfoForTBook(
                  accountName: accountName,
                  currency: currency,
                  fromDate: firstDate,
                  endDate: endDate),
              SizedBox(height: 10),

              // buildTBookBody(
              //   invoice: invoice,
              // ),
              Container(
                  color: PdfColors.grey300,
                  alignment: Alignment.centerLeft,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (isEmployeeAccountDetails)
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: Text('البيان'),
                              )
                            : Container(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Text('الرصيد'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                          child: Text('دائن'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: Text('مدين'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 30.0),
                          child: Text('أصل السند'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Text('التاريخ'),
                        ),
                      ])),
            ],
          ),
        ),
      );

  static Widget buildHeader3(
          assetImage, title, accountName, currency, firstDate, endDate,
          {isEmployeeAccountDetails = false}) =>
      Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  height: 60,
                  width: 200,
                  child: Image(
                    assetImage,
                  ),
                ),
                Text(title,
                    style: TextStyle(
                      fontSize: 24,

                      // fontWeight: FontWeight.bold
                    )),
                buildStoreNameAndDate(),
              ]),
              SizedBox(height: 70),
              buildInvoiceInfoForTBook(
                  accountName: accountName,
                  currency: currency,
                  fromDate: firstDate,
                  endDate: endDate),
              SizedBox(height: 10),

              // buildTBookBody(
              //   invoice: invoice,
              // ),
              Container(
                  color: PdfColors.grey300,
                  alignment: Alignment.centerLeft,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    (isEmployeeAccountDetails)
                        ? Padding(
                            padding: EdgeInsets.only(right: 50),
                            child: Text('البيان'),
                          )
                        : Container(),
                    Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Text('الرصيد'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Text('دائن'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Text('مدين'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Text('أصل السند'),
                    ),
                    SizedBox(width: 20.0),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text('التاريخ'),
                    ),
                  ])),
            ],
          ),
        ),
      );

  // static Widget buildHeader4(
  //     assetImage,title) =>
  //     Directionality(
  //       textDirection: TextDirection.rtl,
  //       child: Container(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //               Container(
  //                 height: 60,
  //                 width: 200,
  //                 child: Image(
  //                   assetImage,
  //                 ),
  //               ),
  //               Text('كمية المستودعات',
  //                   style: TextStyle(
  //                     fontSize: 24,
  //
  //                     // fontWeight: FontWeight.bold
  //                   )),
  //               buildStoreNameAndDate(),
  //             ]),
  //             SizedBox(height: 70),
  //             Row(
  //               children: [
  //                 Expanded(child: Text('$title'),),
  //                 Text('الصنف :'),
  //               ]
  //             ),
  //             SizedBox(height: 10),
  //
  //             // buildTBookBody(
  //             //   invoice: invoice,
  //             // ),
  //             Container(
  //                 color: PdfColors.grey300,
  //                 alignment: Alignment.centerLeft,
  //                 child:
  //                 Row(mainAxisAlignment: MainAxisAlignment.end, children: [
  //                   (isEmployeeAccountDetails)
  //                       ? Padding(
  //                     padding: EdgeInsets.only(right: 50),
  //                     child: Text('البيان'),
  //                   )
  //                       : Container(),
  //                   Padding(
  //                     padding: EdgeInsets.only(right: 30.0),
  //                     child: Text('الرصيد'),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(right: 30.0),
  //                     child: Text('دائن'),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(right: 30.0),
  //                     child: Text('مدين'),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(right: 30.0),
  //                     child: Text('أصل السند'),
  //                   ),
  //                   SizedBox(width: 20.0),
  //                   Padding(
  //                     padding: EdgeInsets.only(right: 20.0),
  //                     child: Text('التاريخ'),
  //                   ),
  //                 ])),
  //           ],
  //         ),
  //       ),
  //     );

  static Widget buildStoreNameAndDate() => Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RichText(
                text: TextSpan(
              text:
                  '${SharedPreferencesService().getString('userName').toString()}',
            )),
            // Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 1 * PdfPageFormat.mm),
            RichText(
                text: TextSpan(
              text: '${Utils.formatDate(DateTime.now())}',
            )),
          ],
        ),
      );

  static Widget buildInvoiceInfoForTBook(
      {accountName, currency, fromDate, endDate}) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: Row(children: [
            SizedBox(width: 200),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                width: 300,
                child: Column(children: [
                  Row(children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      child: Text('$accountName'),
                    )),
                    Text('الحساب:'),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      child: Text('$currency'),
                    )),
                    Container(child: Text('العملة:')),
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('')),
                        RichText(
                            text: TextSpan(
                                text: 'إعتباراً من تاريخ  ',
                                children: [
                              TextSpan(text: ' ${Utils.formatDate(fromDate)} '),
                              TextSpan(text: ' إلى تاريخ  '),
                              TextSpan(text: ' ${Utils.formatDate(endDate)} '),
                            ])),
                      ]),
                ]),
              ),
            ),
          ]),
        ));
  }

  static Widget buildInvoiceInfoForTBook2({category, group, currency}) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: Row(children: [
            SizedBox(width: 200),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                width: 300,
                child: Column(children: [
                  Row(children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      child: Text('$category'),
                    )),
                    Text('الصنف'),
                  ]),
                  Row(children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      child: Text('$group'),
                    )),
                    Text('المجموعة'),
                  ]),
                  Row(children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      child: Text('$currency'),
                    )),
                    Text('العملة'),
                  ]),
                ]),
              ),
            ),
          ]),
        ));
  }

  static Widget buildTBookBody({List<VMTBook> invoice}) {
    List<dynamic> data;
    List headers = ['الرصيد', 'دائن', 'مدين', 'أصل السند', 'التاريخ'];
    var debit = 0.0;
    var credit = 0.0;
    var totalBalance = 0.0;

    data = invoice.map((item) {
      debit += item.debit;
      credit += item.credit;
      return [
        '${item.balance.toStringAsFixed(1)}',
        '${item.credit.toStringAsFixed(1)}',
        '${item.debit.toStringAsFixed(1)}',
        (item.bond == null) ? '' : '${item.bond}',
        Utils.formatDate(DateTime.parse(item.date))
      ];
    }).toList();
    totalBalance = debit - credit;
    List debitAndCreditRow = [
      '',
      credit.toStringAsFixed(1),
      debit.toStringAsFixed(1),
      '',
      ''
    ];
    data.add(debitAndCreditRow);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(children: [
        Table.fromTextArray(
          headers: headers,
          data: data,
          border: null,
          headerDecoration: BoxDecoration(color: PdfColors.grey300),
          cellHeight: 30,
          cellAlignments: {
            0: Alignment.center,
            1: Alignment.center,
            2: Alignment.center,
            3: Alignment.center,
            4: Alignment.center,
          },
        ),
        buildFinalTotal(
            title: 'إجمالي الرصيد', total: totalBalance.toStringAsFixed(1)),
      ]),
    );
  }

  static Widget buildTBookBody2({List<EADetails> invoice}) {
    List<dynamic> data;
    List headers = ['البيان', 'الرصيد', 'دائن', 'مدين', 'أصل السند', 'التاريخ'];
    var debit = 0.0;
    var credit = 0.0;
    var totalBalance = 0.0;

    data = invoice.map((item) {
      debit += item.debit;
      credit += item.credit;
      return [
        '${item.details.toString()}',
        '${item.balance.toStringAsFixed(1)}',
        '${item.credit.toStringAsFixed(1)}',
        '${item.debit.toStringAsFixed(1)}',
        (item.bond == null) ? '' : '${item.bond}',
        Utils.formatDate(DateTime.parse(item.date))
      ];
    }).toList();
    totalBalance = debit - credit;
    List debitAndCreditRow = [
      '',
      '',
      credit.toStringAsFixed(1),
      debit.toStringAsFixed(1),
      '',
      ''
    ];
    data.add(debitAndCreditRow);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(children: [
        Table.fromTextArray(
          headers: headers,
          data: data,
          border: null,
          headerDecoration: BoxDecoration(color: PdfColors.grey300),
          cellHeight: 30,
          cellAlignments: {
            0: Alignment.center,
            1: Alignment.center,
            2: Alignment.center,
            3: Alignment.center,
            4: Alignment.center,
          },
        ),
        buildFinalTotal(
            title: 'إجمالي الرصيد', total: totalBalance.toStringAsFixed(1)),
      ]),
    );
  }

  static Widget buildTBookBody3(
      {List<VMaterialQuantity> quantity, String quantityName}) {
    List<dynamic> data;
    List headers = ['$quantityName', 'المستودع'];

    var total = 0.0;

    data = quantity.map((item) {
      total += item.quantity;
      return [
        '${item.quantity.toStringAsFixed(1)}',
        '${item.title}',
      ];
    }).toList();
    List<String> totalRow = [total.toStringAsFixed(1), ''];
    data.add(totalRow);

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Table.fromTextArray(
          headers: headers,
          data: data,
          border: null,
          headerDecoration: BoxDecoration(color: PdfColors.grey300),
          cellHeight: 30,
          cellAlignments: {
            0: Alignment.center,
            1: Alignment.center,
          },
        ));
  }

  static getTotal(List<VMTBook> invoice) {
    var debit = 0.0;
    var credit = 0.0;
    var totalBalance = 0.0;
    invoice.map((item) {
      debit += item.debit;
      credit += item.credit;
    }).toList();
    totalBalance = debit - credit;

    return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Row(children: [
          Container(
              color: PdfColors.grey300,
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 2),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${totalBalance.toStringAsFixed(1)}'),
                    SizedBox(width: 20),
                    Text('إجمالي الرصيد'),
                  ])),
          Container(
              color: PdfColors.grey300,
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 2),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${credit.toStringAsFixed(1)}'),
                    SizedBox(width: 20),
                    Text('إجمالي الدائن'),
                  ])),
          Container(
              color: PdfColors.grey300,
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 2),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${debit.toStringAsFixed(1)}'),
                    SizedBox(width: 20),
                    Text('إجمالي المدين'),
                  ])),
        ]));
  }

  static getTotal2(List<EADetails> invoice) {
    var debit = 0.0;
    var credit = 0.0;
    var totalBalance = 0.0;
    invoice.map((item) {
      debit += item.debit;
      credit += item.credit;
    }).toList();
    totalBalance = debit - credit;

    return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Row(children: [
          Container(
              color: PdfColors.grey300,
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 2),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${totalBalance.toStringAsFixed(1)}'),
                    SizedBox(width: 20),
                    Text('إجمالي الرصيد'),
                  ])),
          Container(
              color: PdfColors.grey300,
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 2),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${credit.toStringAsFixed(1)}'),
                    SizedBox(width: 20),
                    Text('إجمالي الدائن'),
                  ])),
          Container(
              color: PdfColors.grey300,
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 2),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${debit.toStringAsFixed(1)}'),
                    SizedBox(width: 20),
                    Text('إجمالي المدين'),
                  ])),
        ]));
  }

  static Widget buildFinalTotal({title, total}) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Row(
        children: [
          Container(
              color: PdfColors.grey300,
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 2),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$total'),
                    SizedBox(width: 20),
                    Text('$title'),
                  ])),
          Expanded(child: Text('')),
        ],
      ),
    );
  }

  ///////////////////////////////

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'العنوان', value: invoice.supplier.address),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'للتواصل ', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    String title,
    String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Text(title, style: style),

        RichText(
            text: TextSpan(
          text: value,
        )),
        SizedBox(width: 2 * PdfPageFormat.mm),
        RichText(
            text: TextSpan(
          text: title,
        )),
        // Text(value),
      ],
    );
  }
}
