import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/user/user_profile.dart';
import 'package:flutter_app_alameen/core/services/shared_preferences_service.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  String userName;

  @override
  void initState() {
    userName = SharedPreferencesService().getString('userName');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(int.parse("0xff029FCC")),
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          Expanded(
              child: Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
            size: 50,
          )),
          Expanded(
              flex: 2,
              child: FlatButton(
                child: Text(
                    '${(userName.toString() == 'null') ? '' : userName}',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontFamily: 'Cairo')),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
              )),
        ],
      ),
    );
  }
}
