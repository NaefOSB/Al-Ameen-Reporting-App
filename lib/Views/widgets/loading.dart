import 'package:flutter/material.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10.0,),
          Text('... الرجاء الأنتظار',style: TextStyle(
            fontFamily: 'Cairo'
          ),),
        ],
      ),
    );
  }
}
