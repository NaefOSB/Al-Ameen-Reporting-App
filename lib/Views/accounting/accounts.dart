import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/widgets/custom_text.dart';
import 'package:flutter_app_alameen/Views/widgets/drawer_list.dart';
import 'package:flutter_app_alameen/Views/widgets/loading.dart';
import 'package:flutter_app_alameen/Views/widgets/my_expansion_tile_list.dart';
import 'package:flutter_app_alameen/constant.dart';
import 'package:flutter_app_alameen/core/services/api.dart';
import 'package:get/get.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  TextEditingController _searchController = new TextEditingController();
  var searchText3 = '';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text('الحسابات',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontSize: 34, color: Colors.white, fontFamily: 'Cairo')),
            backgroundColor: kPrimaryColor,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          endDrawer: CustomDrawer(
            selectedPageId: 1,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  // for search text field
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        style: TextStyle(fontFamily: 'Cairo'),
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            searchText3 = value;
                          });
                        },
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                              });
                            },
                            icon: Icon(Icons.clear),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Center(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: FutureBuilder(
                            future: APIService.getAccountLevel0(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: Loading(),
                                );
                              } else if (snapshot.hasError) {
                                return CustomText(
                                  title: 'خطأ في تحميل البيانات',
                                  alignment: Alignment.center,
                                );
                              } else {
                                if (snapshot.hasData) {
                                  List<dynamic> json = snapshot.data;
                                  if (snapshot.data.toString().contains(
                                      _searchController.text.toString())) {
                                    return Theme(
                                        data: ThemeData().copyWith(
                                            dividerColor: Colors.transparent),
                                        child: new MyExpansionTileList(
                                          elementList: json,
                                          state: 0,
                                          isAccount: true,
                                        ));
                                  }
                                  return Text(
                                    'لا توجد نتائج',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                    ),
                                  );
                                }
                                return Center(
                                  child: Text(
                                    'لاتوجد بيانات',
                                    style: TextStyle(fontFamily: 'Cairo'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                  //Expanded(child: null)
                ],
              ),
            ),
          )),
    );
  }
}
