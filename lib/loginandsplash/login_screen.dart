import './auth_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 130,
          ),
          Center(),
          SizedBox(height: 10,),
          Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AuthScreen.routeName);
              },
              child: Text(
                'Sign In',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              color: kMaroonColor,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 150, vertical: 15),
              splashColor: Colors.redAccent[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
                side: BorderSide(color: kMaroonColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
