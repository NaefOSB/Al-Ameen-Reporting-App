import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/core/services/api.dart';
import '../material/material_details.dart';
import '../accounting/account_details.dart';
import 'loading.dart';

class MyExpansionTile extends StatefulWidget {
  final String guid;
  final String name;
  final int state;
  final bool isLast;
  final accountOrMt;
  final bool isAccount;
  final double fontSize;

  MyExpansionTile(
      this.guid, this.name, this.state, this.isLast, this.accountOrMt,
      {this.isAccount = true, this.fontSize = 20.0});

  @override
  State createState() => new MyExpansionTileState();
}

class MyExpansionTileState extends State<MyExpansionTile> {
  PageStorageKey _key;

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // _key = new PageStorageKey('${widget.guid}');
    return Padding(
      padding: EdgeInsets.only(right: (widget.state == 0) ? 0 : 20.0),
      child: new ExpansionTile(
        key: _key,
        leading: (widget.isLast != null && widget.isLast)
            ? Icon(
                Icons.insert_drive_file_outlined,
              )
            : Icon(
                (_isExpanded)
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_left,
              ),
        trailing: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.transparent,
        ),
        onExpansionChanged: (value) {
          setState(() {
            if (widget.isLast != null && widget.isLast) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (widget.isAccount)
                          ? AccountDetails(account: widget.accountOrMt)
                          : MaterialDetails(material: widget.accountOrMt)));
            }
            _isExpanded = value;
          });
        },
        title: new Text(widget.name,
            style: TextStyle(
                fontSize: widget.fontSize,
                color: Colors.black,
                fontFamily: 'Cairo')),
        children: <Widget>[
          new FutureBuilder(
            future: (widget.isAccount)
                ? APIService.getAccountSubLevel(widget.guid)
                : APIService.getMaterialSubLevel(widget.guid),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Loading(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'خطأ في تحميل البيانات',
                    style: TextStyle(fontFamily: 'Cairo'),
                  ),
                );
              } else {
                List<dynamic> json = snapshot.data;
                List<Widget> reasonList = [];
                json.forEach((element) {
                  reasonList.add(new MyExpansionTile(
                    element['guid'],
                    element['name'],
                    1,
                    element['islast'],
                    element,
                    isAccount: widget.isAccount,
                    fontSize: widget.fontSize - 2,
                  ));
                });
                return new Column(children: reasonList);
              }
            },
          )
        ],
      ),
    );
  }
}
