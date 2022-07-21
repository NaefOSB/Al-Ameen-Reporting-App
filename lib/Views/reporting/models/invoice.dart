import 'package:flutter_app_alameen/Views/reporting/models/supplier.dart';

import 'customer.dart';

class Invoice {
   InvoiceInfo info;
   Supplier supplier;
   Customer customer;
   bool isMultiPages;
   List<InvoiceItem> items;

   Invoice({
    this.info,
    this.supplier,
    this.customer,
    this.isMultiPages,
    this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final int count;
  final double multiTotalPrice;

  const InvoiceInfo({
    this.description,
    this.number,
    this.date,
    this.count,
    this.multiTotalPrice
  });
}

class InvoiceItem {
   String productMark;
   String productName;
   String unitName;
   var quantity;
   double unitPrice;
   DateTime date;
   int rowNumber;


   InvoiceItem({
    this.productMark,
    this.productName,
    this.unitName,
    this.quantity,
    this.unitPrice,
    this.date,
    this.rowNumber
  });
}