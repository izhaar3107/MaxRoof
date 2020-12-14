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

  User get user {
    return _user;
  }

  Future<void> login(String email, String password) async {
    var url = supervisor + '/?username=$email&password=$password';

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

    // print(jsonDecode(extractedUserData['user']));
    Map userMap = jsonDecode(extractedUserData['user']);
    _user = User.fromJson(userMap);
    notifyListeners();

    // _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _session = null;
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
