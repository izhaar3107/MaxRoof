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

class attendancemodel {
  final String id;
  final String name;

  attendancemodel({this.id, this.name});

  factory attendancemodel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return attendancemodel(
      id: json["Id"],
      name: json["TempFields"],
    );
  }

  static List<attendancemodel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => attendancemodel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.name}';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(attendancemodel model) {
    return this?.id == model?.id;
  }

  @override
  String toString() => name;
}

class advancemodel {
  final String id;
  final String name;

  advancemodel({this.id, this.name});

  factory advancemodel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return advancemodel(
      id: json["Id"],
      name: json["DeductMonth"],
    );
  }

  static List<advancemodel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => advancemodel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.name}';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(advancemodel model) {
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
