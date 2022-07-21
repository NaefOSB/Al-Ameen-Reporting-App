import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final String imagePath;
  final Function onPressed;

  CustomButton({this.title, this.imagePath, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 70,
      width: 240,
      child: RaisedButton(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(title,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: 30, color: Colors.white, fontFamily: 'Cairo')),
            ),
            Expanded(flex: 1, child: Image.asset(imagePath,color:Colors.white ,)),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: onPressed,
        padding: EdgeInsets.all(10.0),
        // color: Color(int.parse("0xffF6921E")),
        color: Colors.lightBlue.shade500,
        textColor: Colors.white,
      ),
    );
  }
}
