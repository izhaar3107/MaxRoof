import 'package:erp/SuperVisor/widgets/project_list.dart';
import 'package:erp/constants.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'dart:convert';
import '../models/model.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';

class leadsprovider with ChangeNotifier {
  List<leads> _items = [];
  List<leads> _topItems = [];

  leadsprovider();

  List<leads> get items {
    return [..._items];
  }

  List<leads> get topItems {
    return [..._topItems];
  }

  int get itemCount {
    return _items.length;
  }

  leads findById(int id) {
    // return _topItems.firstWhere((course) => course.id == id);
  }

  Future<void> fetchprescription(BuildContext context) async {
    var url = projectlistapi +
        'pkEmpId=' +
        Provider.of<Auth>(context, listen: false).session +
        '&DatabaseName=' +
        Provider.of<Auth>(context, listen: false).databasename;

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List;
      if (extractedData == null) {
        return;
      }
      // print(extractedData);
      _items = buildpreslist(extractedData);
      print(_items);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<leads> buildpreslist(List extractedData) {
    final List<leads> loadedCourses = [];
    extractedData.forEach((courseData) {
      loadedCourses.add(leads(
          projectid: (courseData['pkPrjId']),
          projectname: (courseData['Project']),
          sdate: (courseData['SDate']),
          city: (courseData['City'])));

      // print(catData['name']);
    });
    return loadedCourses;
  }
}
