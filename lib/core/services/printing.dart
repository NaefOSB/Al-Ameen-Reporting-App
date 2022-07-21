import 'package:flutter_app_alameen/Model/vm_material_quantity.dart';
import 'package:flutter_app_alameen/Views/reporting/pdf_api.dart';
import 'package:flutter_app_alameen/Views/reporting/test_pdf.dart';

class Printing {
  static printBill(
      {invoice, title, accountName, currency, firstDate, endDate}) async {
    // to make to report
    final pdfFile = await TestPDF.generateTBookInvoice(
        invoice: invoice,
        title: title,
        accountName: accountName,
        currency: currency,
        firstDate: firstDate,
        endDate: endDate);
    // to open pdf file
    PdfApi.openFile(pdfFile);
  }

  static printBillForEmployeeAccountDetails(
      {invoice, title, accountName, currency, firstDate, endDate}) async {
    // to make to report
    final pdfFile = await TestPDF.generateEmployeeAccountDetails(
        invoice: invoice,
        title: title,
        accountName: accountName,
        currency: currency,
        firstDate: firstDate,
        endDate: endDate);
    // to open pdf file
    PdfApi.openFile(pdfFile);
  }

  static printMaterialQuantity(
      {List<VMaterialQuantity> material, quantityName, currency, group, category}) async {
    // to make to report
    final pdfFile = await TestPDF.generateMaterialQuantity(
      materialQuantity: material,
      quantityName: quantityName,
      currency: currency,
      group:group ,
      category:category ,
    );
    // to open pdf file
    PdfApi.openFile(pdfFile);
  }
}
