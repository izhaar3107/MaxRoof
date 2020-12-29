import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:erp/constants.dart';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'providers/projectlist.dart';
import 'models/model.dart';

import 'models/common_functions.dart';
import 'package:http/http.dart' as http;
import 'package:erp/SuperVisor/projectlist.dart';
import 'package:erp/providers/auth.dart';
import 'widgets/customtext.dart';

class attendance1 extends StatefulWidget {
  final String text;

  attendance1({Key key, @required this.text}) : super(key: key);

  @override
  attend createState() => attend(text.toString());
}

class attend extends State<attendance1> {
  String pkmpid;
  attend(this.pkmpid);
  List data;
  String dropdownValue = 'One';
  String checkin = '',
      checkout = '',
      mbreak = '',
      whour = '',
      overtime = '',
      Res = '';
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
                        DropdownSearch<attendancemodel>(
                          label: "Type",
                          onFind: (String filter) async {
                            var response = await Dio().get(
                              AttendanceTypeAPI +
                                  "DatabaseName=" +
                                  Provider.of<Auth>(context, listen: false)
                                      .databasename,
                              queryParameters: {"TempFields": filter},
                            );
                            var models =
                                attendancemodel.fromJsonList(response.data);
                            return models;
                          },
                          onChanged: (attendancemodel data) {
                            setState(() {
                              dropdownValue = data.toString();
                            });
                          },
                        ),

                        Column(
                          children: <Widget>[
                            if (dropdownValue == 'Present' ||
                                dropdownValue == 'Half Day')
                              FlatButton(
                                child: OutlineButton(
                                  child: Text("Select Date & Time"),
                                  borderSide: BorderSide(color: Colors.blue),
                                  shape: StadiumBorder(),
                                ),
                                onPressed: () {
                                  DateTimeRangePicker(
                                      startText: "From",
                                      endText: "To",
                                      doneText: "Yes",
                                      cancelText: "Cancel",
                                      interval: 5,
                                      initialStartTime:
                                          DateTime.now().add(Duration(days: 0)),
                                      initialEndTime:
                                          DateTime.now().add(Duration(days: 0)),
                                      mode: DateTimeRangePickerMode.dateAndTime,
                                      minimumTime: DateTime.now()
                                          .subtract(Duration(days: 5)),
                                      maximumTime: DateTime.now()
                                          .subtract(Duration(days: 0)),
                                      use24hFormat: true,
                                      onConfirm: (start, end) {
                                        setState(() {
                                          checkin = start.toString();
                                          checkout = end.toString();

                                          Future<String> getData2() async {
                                            var dio = Dio();
                                            Response response = await dio.get(
                                                'http://maxroof.theiis.com/api/AttendanceInfoAPI?DatabaseName=' +
                                                    Provider.of<Auth>(context,
                                                            listen: false)
                                                        .databasename +
                                                    '&PkEmpId=' +
                                                    pkmpid);

                                            setState(() {
                                              mbreak = response.data['MBreak'];
                                              whour = response.data['WHour'];
                                              overtime =
                                                  response.data['Overtime'];
                                            });
                                          }

                                          getData2();
                                        });
                                      }).showPicker(context);
                                },
                              ),
                            if (dropdownValue == 'Present' ||
                                dropdownValue == 'Half Day')
                              Text("Checkin time: $checkin"),
                            if (dropdownValue == 'Present' ||
                                dropdownValue == 'Half Day')
                              Text("Checkout time: $checkout"),
                            if (dropdownValue == 'Present' ||
                                dropdownValue == 'Half Day')
                              TextFormField(
                                enabled: false,
                                style: TextStyle(fontSize: 16),
                                decoration: getInputDecoration(
                                  'Meal Time: $mbreak',
                                  Icons.ten_k,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Can not be empty';
                                  }
                                },
                                onSaved: (value) {
                                  //     _passwordData['ContactNumber'] = value;
                                },
                              ),
                            if (dropdownValue == 'Present' ||
                                dropdownValue == 'Half Day')
                              TextFormField(
                                enabled: false,
                                style: TextStyle(fontSize: 16),
                                decoration: getInputDecoration(
                                  'Work Hour: $whour',
                                  Icons.ten_k,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Can not be empty';
                                  }
                                },
                                onSaved: (value) {
                                  //     _passwordData['ContactNumber'] = value;
                                },
                              ),
                            if (dropdownValue == 'Present' ||
                                dropdownValue == 'Half Day')
                              TextFormField(
                                enabled: false,
                                style: TextStyle(fontSize: 16),
                                decoration: getInputDecoration(
                                  'Over Time: $overtime',
                                  Icons.ten_k,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Can not be empty';
                                  }
                                },
                                onSaved: (value) {
                                  //     _passwordData['ContactNumber'] = value;
                                },
                              ),
                            if (dropdownValue == 'Present' ||
                                dropdownValue == 'Half Day')
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
                                        await dio.get(Attendancepostapi);
                                    response = await dio
                                        .post(Attendancepostapi, data: {
                                      "UserId": Provider.of<Auth>(context,
                                              listen: false)
                                          .session,
                                      "DatabaseName": Provider.of<Auth>(context,
                                              listen: false)
                                          .databasename,
                                      "pkEmpId": pkmpid,
                                      "WType": dropdownValue,
                                      "AtDate": checkin,
                                      "TimeIn": checkin,
                                      "TimeOut": checkout,
                                      "MBreak": mbreak,
                                      "WHour": whour,
                                      "Overtime": overtime,
                                    });
                                    setState(() {
                                      Res = response.statusMessage;
                                    });
                                  }

                                  getData2();
                                },
                              ),
                            if (dropdownValue == 'Absent' ||
                                dropdownValue == 'Rest Day' ||
                                dropdownValue == 'Unpaid Leave' ||
                                dropdownValue == 'Paid Holiday' ||
                                dropdownValue == 'Sick Leave' ||
                                dropdownValue == 'Annual Leave' ||
                                dropdownValue == 'Paid Casual Leave' ||
                                dropdownValue == 'Unpaid Casual Leave' ||
                                dropdownValue == 'Extra Hours Adjustment' ||
                                dropdownValue == 'Maternity Leave')
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                                              await dio.get(Attendancepostapi);
                                          response = await dio
                                              .post(Attendancepostapi, data: {
                                            "UserId": Provider.of<Auth>(context,
                                                    listen: false)
                                                .session,
                                            "DatabaseName": Provider.of<Auth>(
                                                    context,
                                                    listen: false)
                                                .databasename,
                                            "AtDate": "0",
                                            "TimeIn": "0",
                                            "TimeOut": "0",
                                            "pkempid": pkmpid,
                                            "WType": dropdownValue,
                                            "MBreak": "0",
                                            "WHour": "0",
                                            "Overtime": "0",
                                          });
                                          setState(() {
                                            Res =
                                                response.statusCode.toString();
                                          });
                                        }

                                        getData2();
                                        Fluttertoast.showToast(
                                          msg: Res,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                        );
                                      },
                                    )
                                  ])
                          ],
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
