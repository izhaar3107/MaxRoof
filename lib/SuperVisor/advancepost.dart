import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:erp/constants.dart';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/projectlist.dart';
import 'models/model.dart';

import 'models/common_functions.dart';
import 'package:http/http.dart' as http;
import 'package:erp/SuperVisor/projectlist.dart';
import 'package:erp/providers/auth.dart';
import 'widgets/customtext.dart';

class advancepost extends StatefulWidget {
  final String text;

  advancepost({Key key, @required this.text}) : super(key: key);

  @override
  attend createState() => attend(text.toString());
}

class attend extends State<advancepost> {
  String pkmpid;
  attend(this.pkmpid);
  List data;
  String dropdownValue = 'One';
  String advanceamount;
  Future<String> getData() async {
    var dio = Dio();
    Response response = await dio.get('');

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    String _authData;

    return Scaffold(
      appBar: AppBar(
        title: Text("Employe ID " + pkmpid.toString()),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Card(
          child: Container(
            width: double.infinity,
            // height: 400,
            child: Card(
              elevation: 4,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[],
                        ),
                        DropdownSearch<advancemodel>(
                          label: "Deduct from",
                          onFind: (String filter) async {
                            var response = await Dio().get(
                              advancepostapi +
                                  "pkEmpId=" +
                                  pkmpid +
                                  "&DatabaseName=" +
                                  Provider.of<Auth>(context, listen: false)
                                      .databasename,
                              queryParameters: {"DeductMonth": filter},
                            );
                            var models =
                                advancemodel.fromJsonList(response.data);
                            return models;
                          },
                          onChanged: (advancemodel data) {
                            setState(() {
                              dropdownValue = data.toString();
                            });
                          },
                        ),
                        TextFormField(
                          style: TextStyle(fontSize: 16),
                          decoration: getInputDecoration(
                            'Advance Amount: ',
                            Icons.ten_k,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Can not be empty';
                            }
                          },
                          onSaved: (value) {
                            advanceamount = value;
                          },
                        ),
                        new OutlineButton(
                          shape: StadiumBorder(),
                          textColor: Colors.blue,
                          child: Text('Submit'),
                          borderSide: BorderSide(
                              color: Colors.blue,
                              style: BorderStyle.solid,
                              width: 1),
                          onPressed: () {
                            Future<String> getData2() async {
                              var dio = Dio();
                              Response response =
                                  await dio.get(advancepostapi2);
                              response = await dio.post(advancepostapi2, data: {
                                "UserId":
                                    Provider.of<Auth>(context, listen: false)
                                        .session,
                                "DatabaseName":
                                    Provider.of<Auth>(context, listen: false)
                                        .databasename,
                                "pkEmpId": pkmpid,
                                "DeductFrom": dropdownValue,
                                "Amount": advanceamount
                              });
                              setState(() {});
                            }

                            getData2();
                          },
                        ),

                        // PopupMenuButton(
                        //     onSelected: (int courseId) {
                        //       Provider.of<Courses>(context, listen: false)
                        //           .toggleWishlist(courseId, true)
                        //           .then((_) => CommonFunctions.showSuccessToast(
                        //               'Removed from wishlist.'));
                        //     },
                        //     icon: Icon(
                        //       Icons.more_horiz,
                        //     ),
                        //     itemBuilder: (_) => [
                        //           PopupMenuItem(
                        //             child: Text('Remove from wishlist'),
                        //             value: course.id,
                        //           ),
                        //         ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration getInputDecoration(String hintext, IconData iconData) {
  return InputDecoration(
    enabledBorder: kDefaultInputBorder,
    focusedBorder: kDefaultFocusInputBorder,
    focusedErrorBorder: kDefaultFocusErrorBorder,
    errorBorder: kDefaultFocusErrorBorder,
    filled: true,
    hintStyle: TextStyle(color: Colors.black),
    hintText: hintext,
    fillColor: Colors.white,
    prefixIcon: Icon(
      iconData,
      color: kFormInputColor,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 5),
  );
}
