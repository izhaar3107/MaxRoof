import 'package:flutter/foundation.dart';

class companymodel {
  final String id;
  final String name;

  companymodel({this.id, this.name});

  factory companymodel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return companymodel(
      id: json["pkBookId"],
      name: json["DatabaseName"],
    );
  }

  static List<companymodel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => companymodel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.name}';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(companymodel model) {
    return this?.id == model?.id;
  }

  @override
  String toString() => name;
}

class project {
  String projectid;
  String projectname;

  project({@required this.projectid, @required this.projectname});
}
