import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Model/server_details_model.dart';
import 'package:flutter_app_alameen/Views/widgets/custom_text_form_field.dart';
import 'package:flutter_app_alameen/Views/widgets/rounded_button.dart';
import 'package:flutter_app_alameen/core/services/user_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ServerDetails extends StatefulWidget {
  @override
  _ServerDetailsState createState() => _ServerDetailsState();
}

class _ServerDetailsState extends State<ServerDetails> {
  String groupValue = '';
  TextEditingController globalController;
  TextEditingController localController;

  @override
  void initState() {
    setDataToControllers();
    super.initState();
  }

  setDataToControllers() async {
    ServerDetailsModel server = await UserStorage().getServerDetails();
    globalController = TextEditingController(text: server.global);
    localController = TextEditingController(text: server.local);
    groupValue = server.selectedServer;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'تفاصيل السيرفر',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: size.height * 0.15,
            ),
            CustomTextFormField(
              controller: globalController,
              hintText: 'عنوان السيرفر العالمي',
              icon: FontAwesomeIcons.globe,
              onClear: () {
                setState(() {
                  globalController.clear();
                });
              },
            ),
            CustomTextFormField(
              controller: localController,
              hintText: 'عنوان السيرفر المحلي',
              icon: FontAwesomeIcons.server,
              onClear: () {
                setState(() {
                  localController.clear();
                });
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    groupValue = 'global';
                  });
                },
                child: Row(
                  children: [
                    Radio(
                        value: 'global',
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value;
                          });
                        }),
                    Text('السيرفر العالمي'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    groupValue = 'local';
                  });
                },
                child: Row(
                  children: [
                    Radio(
                        value: 'local',
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value;
                          });
                        }),
                    Text('السيرفر المحلي'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 20, 30.0, 0),
              child: RoundedButton(
                text: 'حـفـظ',
                press: () {
                  ServerDetailsModel serverData = ServerDetailsModel(
                      global: globalController.text,
                      local: localController.text,
                      selectedServer: groupValue);
                  UserStorage().setServerDetails(serverData);
                  Get.snackbar('عملية ناجحة', 'تم الحفظ بنجاح');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
