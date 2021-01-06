import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:erp/constants.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

void main() => runApp(attendance1());

class attendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DateTimePicker',
      home: attendance1(),
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en', 'IN')],
    );
  }
}

class attendance1 extends StatefulWidget {
  final String text;

  attendance1({Key key, @required this.text}) : super(key: key);

  @override
  attend createState() => attend(text.toString());
}

class attend extends State<attendance1> {
  String pkmpid;
  attend(this.pkmpid);
  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  TextEditingController _controller2;
  TextEditingController _controller3;
  //String _initialValue;
  String _valueChanged2 = '';
  String _valueToValidate2 = '';
  String _valueSaved2 = '';
  String _valueChanged3 = '';
  String _valueToValidate3 = '';
  String _valueSaved3 = '';
  List data;
  String dropdownValue = 'One';
  String checkin = '',
      checkout = '',
      mbreak = '',
      whour = '',
      overtime = '',
      Res = '';
  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'en_IN';
    //_initialValue = DateTime.now().toString();
    _controller2 = TextEditingController(text: DateTime.now().toString());
    _controller3 = TextEditingController(text: DateTime.now().toString());
    String lsHour = TimeOfDay.now().hour.toString().padLeft(2, '0');
    String lsMinute = TimeOfDay.now().minute.toString().padLeft(2, '0');
    _getValue();
  }

  /// This implementation is just to simulate a load data behavior
  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = '2000-10-22 14:30';
        _controller2.text = '';
        _controller3.text = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter DateTimePicker Demo'),
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
                              Form(
                                key: _oFormKey,
                                child: Column(
                                  children: <Widget>[
                                    DateTimePicker(
                                      type: DateTimePickerType.dateTime,
                                      dateMask: 'd MMMM, yyyy - hh:mm a',
                                      controller: _controller2,
                                      //initialValue: _initialValue,
                                      firstDate: DateTime.now().subtract(
                                          Duration(
                                              days: 5, hours: 0, minutes: 00)),
                                      lastDate: DateTime.now(),
                                      //icon: Icon(Icons.event),
                                      dateLabelText: 'Date Time',
                                      use24HourFormat: false,
                                      onChanged: (val) =>
                                          setState(() => _valueChanged2 = val),
                                      validator: (val) {
                                        setState(() => _valueToValidate2 = val);
                                        return null;
                                      },
                                      onSaved: (val) =>
                                          setState(() => _valueSaved2 = val),
                                    ),
                                    DateTimePicker(
                                      type: DateTimePickerType.dateTime,
                                      dateMask: 'd MMMM, yyyy - hh:mm a',
                                      controller: _controller3,
                                      //initialValue: _initialValue,
                                      firstDate: DateTime.now().subtract(
                                          Duration(
                                              days: 5, hours: 0, minutes: 00)),
                                      lastDate: DateTime.now(),
                                      //icon: Icon(Icons.event),
                                      dateLabelText: 'Date Time',
                                      use24HourFormat: false,
                                      onChanged: (val) =>
                                          setState(() => _valueChanged3 = val),
                                      validator: (val) {
                                        setState(() => _valueToValidate3 = val);
                                        return null;
                                      },
                                      onSaved: (val) =>
                                          setState(() => _valueSaved3 = val),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'DateTimePicker data value onChanged:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    SelectableText(_valueChanged2 ?? ''),
                                    SelectableText(_valueChanged3 ?? ''),
                                    SizedBox(height: 10),
                                    RaisedButton(
                                      onPressed: () {
                                        final loForm = _oFormKey.currentState;

                                        if (loForm.validate()) {
                                          loForm.save();
                                        }
                                        setState(() {
                                          checkin = _valueChanged2.toString();
                                          checkout = _valueChanged3.toString();

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
                                      },
                                      child: Text('Submit'),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      'DateTimePicker data value validator:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    SelectableText(_valueToValidate2 ?? ''),
                                    SelectableText(_valueToValidate3 ?? ''),
                                    SizedBox(height: 10),
                                    Text(
                                      'DateTimePicker data value onSaved:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    SelectableText(_valueSaved2 ?? ''),
                                    SelectableText(_valueSaved3 ?? ''),
                                    SizedBox(height: 20),
                                    RaisedButton(
                                      onPressed: () {
                                        final loForm = _oFormKey.currentState;
                                        loForm.reset();

                                        setState(() {
                                          _valueChanged2 = '';
                                          _valueChanged3 = '';
                                          _valueToValidate2 = '';
                                          _valueToValidate3 = '';
                                          _valueSaved2 = '';
                                          _valueSaved3 = '';
                                        });
                                      },
                                      child: Text('Reset'),
                                    ),
                                  ],
                                ),
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
