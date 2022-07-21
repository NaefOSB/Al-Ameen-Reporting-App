import 'package:flutter/material.dart';

import 'my_expansion_tile.dart';

class MyExpansionTileList extends StatelessWidget {
  final List<dynamic> elementList;
  final state;
  final bool isAccount;

  MyExpansionTileList({this.elementList, this.state = 1,this.isAccount=true});

  List<Widget> _getChildren() {
    List<Widget> children = [];
    elementList.forEach((element) {
      children.add(
        new MyExpansionTile(element['guid'], element['name'], state,
            element['islast'], element,isAccount: isAccount,),
      );
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: _getChildren(),
    );
  }
}