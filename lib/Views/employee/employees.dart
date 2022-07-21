import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/employee/profile.dart';
import 'package:flutter_app_alameen/Views/widgets/custom_text.dart';
import 'package:flutter_app_alameen/Views/widgets/drawer_list.dart';
import 'package:flutter_app_alameen/constant.dart';
import 'package:flutter_app_alameen/core/services/api.dart';
import 'package:get/get.dart';

class Employees extends StatefulWidget {
  @override
  _EmployeesState createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  TextEditingController _search = new TextEditingController();
  var searchText = '';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text('العمـلاء',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontSize: 30, color: Colors.white, fontFamily: 'Cairo')),
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
            selectedPageId: 2,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        style: TextStyle(fontFamily: 'Cairo'),
                        controller: _search,
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _search.clear();
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
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
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(
                          child: FutureBuilder(
                        future: APIService.getEmployees(),
                        builder: (BuildContext context, AsyncSnapshot snapShot) {
                          if (snapShot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapShot.hasData) {
                            return ListView.builder(
                              itemCount: snapShot.data.length,
                              itemBuilder: (context, index) {
                                final employee = snapShot.data[index];
                                if (employee['customerName']
                                    .toString()
                                    .contains(_search.text.toString())) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => Profile(
                                            employee: employee,
                                          ));
                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        child: Icon(Icons.person),
                                      ),
                                      title: Text(employee['customerName'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontFamily: 'Cairo')),
                                      subtitle: Text(
                                          "  الرصيد:${employee['balance'].toStringAsFixed(1)}   ${employee['currency']}  ",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.grey,
                                              fontFamily: 'Cairo')),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    child: null,
                                  );
                                }
                              },
                            );
                          } else {
                            return Center(
                              child: CustomText(
                                alignment: Alignment.center,
                                title: 'خطأ بالأتصال',
                              ),
                            );
                          }
                        },
                      )),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
