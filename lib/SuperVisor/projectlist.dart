import 'dart:async';
import 'dart:convert';

import 'package:erp/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:erp/providers/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: projectlist(),
  ));
}

class projectlist extends StatefulWidget {
  @override
  static const routeName = '/my-project-list';

  HomePageState createState() => HomePageState();
}

class HomePageState extends State<projectlist> {
  List data;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            projectlistapi + Provider.of<Auth>(context, listen: false).session),
        headers: {"Accept": "application/json"});
    // print((Provider.of<Auth>(context, listen: false).session));

    this.setState(() {
      data = json.decode(response.body);
    });
    print(data[1]["Title"]);

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
        title: Text('Project List'),
      ),
      body: data == null
          ? LinearProgressIndicator()
          : ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  child: Card(
                      color: Colors.blue[50],
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 8.0,
                            ),
                            ListTile(
                              title: Text(
                                data[index]["TITLE"],
                                textAlign: TextAlign.justify,
                              ),
                              subtitle: Text(
                                data[index]["TITLE"],
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      )),
                );
              },
            ),
    );
  }
}
