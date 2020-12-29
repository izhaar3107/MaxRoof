import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../SuperVisor/models/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../SuperVisor/models/http_exception.dart';
import '../constants.dart';
import 'package:erp/SuperVisor/models/model.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kSecondaryColor, //change your color here
        ),
        title: Text("ERP"),
        backgroundColor: kBackgroundColor,
      ),
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(),
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 94.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'DatabaseName': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).login(
          _authData['email'], _authData['password'], _authData['DatabaseName']);

      if (Provider.of<Auth>(context, listen: false).role == 'role1') {
        Navigator.pushNamedAndRemoveUntil(context, '/admin', (r) => false);

        CommonFunctions.showSuccessToast('Login Successful ');
      } else if (Provider.of<Auth>(context, listen: false).role ==
          'Supervisor') {
        Navigator.pushNamedAndRemoveUntil(context, '/supervisor', (r) => false);

        CommonFunctions.showSuccessToast('Login Successful Supervisor');
      } else if (Provider.of<Auth>(context, listen: false).role == 'role2') {
        Navigator.pushNamedAndRemoveUntil(context, '/admin', (r) => false);

        CommonFunctions.showSuccessToast('Login Successful ');
      }
    } on HttpException catch (error) {
      var errorMsg = 'Auth failed';
      CommonFunctions.showErrorDialog(errorMsg, context);
    } catch (error) {
      print(error);
      const errorMsg = 'Could not authenticate!';
      CommonFunctions.showErrorDialog(errorMsg, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: 360,
      constraints: BoxConstraints(minHeight: 260),
      width: deviceSize.width * 0.8,
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: Colors.grey,
                  ), // myIcon is a 48px-wide widget.
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  _authData['email'] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Colors.grey,
                  ),
                ),
                obscureText: true,
                controller: _passwordController,
                onSaved: (value) {
                  _authData['password'] = value;
                },
              ),
              DropdownSearch<companymodel>(
                label: "Select Company",
                onFind: (String filter) async {
                  var response = await Dio().get(
                    companyapi,
                    queryParameters: {"DatabaseName": filter},
                  );
                  var models = companymodel.fromJsonList(response.data);
                  return models;
                },
                onChanged: (companymodel data) {
                  print(data.companyname);
                },
                onSaved: (companymodel data) {
                  _authData['DatabaseName'] = data.companyname.toString();
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ButtonTheme(
                  minWidth: deviceSize.width * 0.8,
                  child: RaisedButton(
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      side: BorderSide(color: kBlueColor),
                    ),
                    splashColor: Colors.blueAccent,
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
                    color: kBlueColor,
                    textColor: Colors.white,
                  ),
                ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
