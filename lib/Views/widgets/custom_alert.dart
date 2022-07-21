import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String title, content, btnText;
  final Function onPressed;

  CustomAlert({this.title, this.content, this.btnText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text('$title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('$content'),
            ],
          ),
        ),
        actions: [FlatButton(onPressed: onPressed, child: Text('$btnText'))],
      ),
    );
  }
}
