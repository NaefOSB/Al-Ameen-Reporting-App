import 'package:flutter/material.dart';
import 'package:flutter_app_alameen/Views/widgets/text_input_filed.dart';

import '../../constant.dart';
import 'custom_text.dart';
import 'dropdown_button.dart';

class CustomDropDown extends StatefulWidget {
  final String hintText;
  final bool hasError;
  final String errorText;
  final IconData icon;
  final List<dynamic> elements;
  final TextEditingController controller;

  CustomDropDown(
      {this.icon,
      this.hintText,
      this.hasError = false,
      this.errorText,
      this.elements,
      this.controller});

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool isStretchedDropDown = false;
  String displayText;

  var groupValue;

  @override
  void initState() {
    displayText = widget.hintText;
    widget.controller.text = displayText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isStretchedDropDown = !isStretchedDropDown;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        // border: Border.all(color: Color(0xffbbbbbb)),
                        borderRadius: BorderRadius.all(Radius.circular(27))),
                    child: Column(
                      children: [
                        Container(
                            width: double.infinity,

                            // padding: EdgeInsets.only(right: 10),

                            constraints: BoxConstraints(
                              minHeight: 45,
                              minWidth: double.infinity,
                            ),
                            alignment: Alignment.center,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    widget.icon,
                                    color: kPrimaryColor,
                                  ),
                                  Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Column(
                                          children: [
                                            CustomText(
                                              title: displayText,
                                              color: Colors.grey.shade700,
                                              alignment: Alignment.center,
                                            ),
                                            Visibility(
                                                visible: widget.hasError,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: CustomText(
                                                    title: widget.errorText,
                                                    color: Colors.red.shade700,
                                                    fontSize: 11.0,
                                                  ),
                                                )),
                                          ],
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                        isStretchedDropDown
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward,
                                        color: kPrimaryColor),
                                  )
                                ],
                              ),
                            )),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ExpandedSection(
                            expand: isStretchedDropDown,
                            height: 100,
                            child: ListView.builder(
                              itemCount: widget.elements.length,
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return RadioListTile(
                                    title: CustomText(
                                      title: widget.elements[index]['loginName']
                                          .toString(),
                                      color: Colors.black87,
                                    ),
                                    value:
                                        widget.elements[index]['id'].toString(),
                                    groupValue: groupValue,
                                    onChanged: (val) {
                                      setState(() {
                                        groupValue = val;
                                        displayText = widget.elements[index]
                                                ['loginName']
                                            .toString();
                                        widget.controller.text = val;
                                        isStretchedDropDown =
                                            !isStretchedDropDown;
                                      });
                                    });
                              },
                            ),

                            // ),
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
