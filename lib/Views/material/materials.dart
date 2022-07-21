import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/widgets/custom_text.dart';
import 'package:flutter_app_alameen/Views/widgets/drawer_list.dart';
import 'package:flutter_app_alameen/Views/widgets/loading.dart';
import 'package:flutter_app_alameen/Views/widgets/my_expansion_tile_list.dart';
import 'package:flutter_app_alameen/constant.dart';
import 'package:flutter_app_alameen/core/services/api.dart';
import 'package:get/get.dart';

class Materials extends StatefulWidget {
  @override
  _MaterialsState createState() => _MaterialsState();
}

class _MaterialsState extends State<Materials> {
  TextEditingController _searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              'الاصناف',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: 30, color: Colors.white, fontFamily: 'Cairo'),
            ),
            backgroundColor: kPrimaryColor,
            centerTitle: true,
          ),
          endDrawer: CustomDrawer(
            selectedPageId: 3,
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                            });
                          },
                          icon: Icon(Icons.clear),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
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
                          future: APIService.getMaterialLevel0(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: Loading());
                            } else if (snapshot.hasError) {
                              return CustomText(
                                  title: 'خطأ في تحميل البيانات',
                                  alignment: Alignment.center);
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
                                        isAccount: false,
                                      ));
                                }
                                return Text(
                                  'لا توجد نتائج',
                                  style: TextStyle(fontFamily: 'Cairo'),
                                );
                              }
                              return Text('');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
