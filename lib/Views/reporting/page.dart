import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/reporting/pdf_api.dart';
import 'package:flutter_app_alameen/Views/reporting/test_pdf.dart';
import 'package:flutter_app_alameen/Views/reporting/widget/button_widget.dart';
import 'package:flutter_app_alameen/Views/reporting/widget/title_widget.dart';

class PdfPages extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPages> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      title: Text('gfgx'),
      centerTitle: true,
    ),
    body: Container(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TitleWidget(
              icon: Icons.picture_as_pdf,
              text: 'Generate Invoice',
            ),
            const SizedBox(height: 48),
            ButtonWidget(
              text: 'Invoice PDF',
              onClicked: () async {

                  // to make to report
                  final pdfFile = await TestPDF.generateTBookInvoice();

                  // to open pdf file
                  PdfApi.openFile(pdfFile);







              },
            ),
          ],
        ),
      ),
    ),
  );
}