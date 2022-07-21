import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  Function onClear;
  IconData icon;

  CustomTextFormField({this.controller, this.hintText, this.onClear,this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: controller,
          style: TextStyle(fontFamily: 'Cairo'),
          onChanged: (value) {},
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.all(10.0),
            suffixIcon: IconButton(
              onPressed: onClear,
              icon: Icon(Icons.clear),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            prefixIcon: Icon(icon),
          ),
        ),
      ),
    );
  }
}
