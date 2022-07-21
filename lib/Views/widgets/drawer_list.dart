import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'MyHeaderDrawer.dart';
import 'menu_item.dart';

class CustomDrawer extends StatefulWidget {
  final int selectedPageId;

  CustomDrawer({this.selectedPageId});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              MyHeaderDrawer(),
              Container(
                padding: EdgeInsets.only(
                  top: 15,
                ),
                child: Column(
                  children: [
                    MenuItem(
                      id: 0,
                      title: "الرئيسية",
                      icon: Icons.home,
                      selectedPageIndex: widget.selectedPageId,
                    ),
                    MenuItem(
                      id: 1,
                      title: "الحسابات",
                      icon: Icons.switch_account,
                      selectedPageIndex: widget.selectedPageId,
                    ),
                    MenuItem(
                      id: 2,
                      title: "العملاء",
                      icon: Icons.group,
                      selectedPageIndex: widget.selectedPageId,
                    ),
                    MenuItem(
                      id: 3,
                      title: "الأصناف",
                      icon: Icons.auto_awesome_mosaic,
                      selectedPageIndex: widget.selectedPageId,
                    ),
                    Divider(),
                    MenuItem(
                      id: 5,
                      title: "إعدادات السيرفر",
                      icon: FontAwesomeIcons.server,
                      selectedPageIndex: widget.selectedPageId,
                    ),
                    MenuItem(
                      id: 4,
                      title: "الخروج",
                      icon: Icons.logout,
                      selectedPageIndex: widget.selectedPageId,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
