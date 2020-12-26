import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:erp/SuperVisor/advancepost.dart';
import 'package:erp/SuperVisor/attendance.dart';
import 'package:erp/constants.dart';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/projectlist.dart';
import '../models/model.dart';

import '../models/common_functions.dart';
import 'package:http/http.dart' as http;
import 'package:erp/SuperVisor/advance.dart';
import 'package:erp/providers/auth.dart';
import 'customtext.dart';

class advance_list extends StatelessWidget {
  final project course;

  advance_list({
    @required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => second(
                text: course.projectid,
              ),
            ));
      },
      child: Container(
        width: double.infinity,
        // height: 400,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
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
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[],
                    ),

                    ListTile(
                      title: Customtext(
                        text: 'Project Name : ' + course.projectname,
                        colors: kTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        color: Colors.grey,
                      ),
                    )

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
    );
  }
}

class second extends StatefulWidget {
  final String text;

  second({Key key, @required this.text}) : super(key: key);

  @override
  HomePageState createState() => HomePageState(text.toString());
}

class HomePageState extends State<second> {
  String text;
  HomePageState(this.text);
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(employelist +
            "fkPrjId=" +
            text +
            "&DatabaseName=" +
            Provider.of<Auth>(context, listen: false).databasename),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });
    print(data[1]["Employee"]);

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employe list : ID " + text.toString()),
      ),
      body: data == null
          ? LinearProgressIndicator()
          : ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[],
                                  ),

                                  ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => advancepost(
                                              text: data[index]["pkEmpId"],
                                            ),
                                          ));
                                    },
                                    title: Customtext(
                                      text: 'Employee Name:' +
                                          data[index]["Employee"],
                                      colors: kTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.arrow_forward_ios),
                                      color: Colors.grey,
                                    ),
                                  )

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
                );
              },
            ),
    );
  }
}
