import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Model/vm_material_quantity.dart';
import 'package:flutter_app_alameen/Views/widgets/custom_refresh.dart';
import 'package:flutter_app_alameen/core/services/api.dart';
import 'package:flutter_app_alameen/core/services/printing.dart';
import 'package:get/get.dart';

class MaterialAmount extends StatefulWidget {
  var material;

  MaterialAmount({this.material});

  @override
  _MaterialAmountState createState() => _MaterialAmountState();
}

class _MaterialAmountState extends State<MaterialAmount> {
  var myDate;

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
          title: Text(
            'كمية المستودعات',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: 28, color: Colors.white, fontFamily: 'Cairo'),
          ),
          backgroundColor: Color(int.parse("0xff029FCC")),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: APIService.getMaterialAmount(widget.material['id']),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapShot.hasData) {
              return Column(
                children: [
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, left: 10.0),
                    child: Text('الصنف : ${snapShot.data['nameOfMt']}',
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                            fontFamily: 'Cairo')),
                  ),
                  Divider(),
                  Table(
                    border: TableBorder.all(),
                    children: getDate(
                        unit: snapShot.data['unit'],
                        data: snapShot.data['nameStoreAndQun']),
                  ),
                ],
              );
            } else {
              return Center(
                child: CustomRefresh(
                  title: 'خطأ بالأتصال',
                  onTap: () => setState(() {}),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  List<TableRow> getDate({String unit, List<dynamic> data}) {
    myDate = data;
    List<TableRow> rows = List<TableRow>();
    TableRow header = TableRow(children: [
      TableCell(
        child: Text(
          'المستودع',
          style:
              TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Cairo'),
          textAlign: TextAlign.center,
        ),
      ),
      TableCell(
        child: Text(
          '$unit',
          style:
              TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Cairo'),
          textAlign: TextAlign.center,
        ),
      ),
    ]);
    rows.add(header);
    for (int i = 0; i < data.length; i++) {
      rows.add(TableRow(children: [
        TableCell(
            child: Text(
          '${data[i]['name'].toString()}',
          style:
              TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Cairo'),
          textAlign: TextAlign.center,
        )),
        TableCell(
            child: Text(
          '${data[i]['quantity'].toString()}',
          style:
              TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Cairo'),
          textAlign: TextAlign.center,
        )),
      ]));
    }
    return rows;
  }

  String getString(value) {
    if (value.toString() == 'null') {
      return "";
    }
    return value;
  }

  printData() {

    if (myDate != null && myDate.length > 0) {
      List<VMaterialQuantity> lists = new List<VMaterialQuantity>();
      for (int i = 0; i < myDate.length; i++) {
        lists.add(VMaterialQuantity(
            title: myDate[i]['name'], quantity: myDate[i]['quantity']));
      }

      Printing.printMaterialQuantity(
        material: lists,
        quantityName: widget.material['unit'],
        category: widget.material['name'],
        group: widget.material['groupName'],
        currency: widget.material['currency'],
      );
    }
  }
}
