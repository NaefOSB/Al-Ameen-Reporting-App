import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomRefresh extends StatefulWidget {
  final String title;
  final Function onTap;

  CustomRefresh({this.title, this.onTap});

  @override
  _CustomRefreshState createState() => _CustomRefreshState();
}

class _CustomRefreshState extends State<CustomRefresh> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 150,
        alignment: Alignment.center,
        child: InkWell(
          onTap: widget.onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.refresh,
                size: 40.0,
              ),
              CustomText(
                title: widget.title,
                alignment: Alignment.center,
              ),
            ],
          ),
        ));
  }
}
