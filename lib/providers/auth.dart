import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../SuperVisor/models/http_exception.dart';
import '../SuperVisor/models/user.dart';
import 'dart:async';
import '../constants.dart';
import 'dart:io';

class Auth with ChangeNotifier {
  String _session;
  String _role;
  String _databasename;
  String _profilePic;
  String _EmpCode;
  String _Employee;

  User _user;

  Auth();

  bool get isAuth {
    return session != null;
  }

  String get session {
    if (_session != null) {
      return _session;
    }
    return null;
  }

  String get role {
    if (_role != null) {
      return _role;
    }
    return null;
  }

  String get databasename {
    if (_databasename != null) {
      return _databasename;
    }
    return null;
  }

  String get profilePic {
    if (_profilePic != null) {
      return _profilePic;
    }
    return null;
  }

  String get Employee {
    if (_Employee != null) {
      return _Employee;
    }
    return null;
  }

  String get EmpCode {
    if (_EmpCode != null) {
      return _EmpCode;
    }
    return null;
  }

  User get user {
    return _user;
  }

  Future<void> login(String email, String password, String DatabaseName) async {
    var url = loginapi +
        '/?username=$email&password=$password&DatabaseName=$DatabaseName';

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      print(responseData['success']);
      if (responseData['success'] == false) {
        throw HttpException('Auth Failed');
      }
      if (responseData['success'] == 'true') {
        _session = responseData['pkEmpId'];
        _role = "Supervisor";
        _databasename = "$DatabaseName";
        _Employee = responseData['Employee'];
        _EmpCode = responseData['EmpCode'];
        _profilePic = responseData['profilePic'];

        final loadedUser = User(
          userId: responseData['pkEmpId'],
          role: responseData['pkEmpId'],
        );

        _user = loadedUser;
        // print(_user.firstName);
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _session,
          'user': jsonEncode(_user),
          'role': _role,
          'databasename': _databasename,
          'Employee': _Employee,
          'EmpCode': _EmpCode,
          'profilePic': _profilePic,
        });
        prefs.setString('userData', userData);
        print(userData);
      }
    } catch (error) {
      throw (error);
    }
    // return _authenticate(email, password, 'verifyPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    _session = extractedUserData['token'];
    _role = extractedUserData['role'];
    _databasename = extractedUserData['databasename'];
    _EmpCode = extractedUserData['EmpCode'];
    _Employee = extractedUserData['Employee'];
    _profilePic = extractedUserData['profilePic'];

    // print(jsonDecode(extractedUserData['user']));
    Map userMap = jsonDecode(extractedUserData['user']);
    _user = User.fromJson(userMap);
    notifyListeners();

    // _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _session = null;
    _role = null;
    _databasename = null;
    _Employee = null;
    _EmpCode = null;
    _profilePic = null;
    // _user = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  void _autoLogout() {
    // if (_authTimer != null) {
    //   _authTimer.cancel();
    // }
    // final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    // _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
