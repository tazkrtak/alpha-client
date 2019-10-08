import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../app/home_screen.dart';
import '../models/user.dart';
import '../util/app_localizations.dart';

class SignUpScreen3 extends StatefulWidget {
  static String tag = 'test-page';

  @override
  _SignUpScreen3 createState() => new _SignUpScreen3();
}

class _SignUpScreen3 extends State<SignUpScreen3> {
  TextEditingController _passwordController = new TextEditingController();
  String _password = "";
  TextEditingController _confirmPasswordController =
      new TextEditingController();
  String _confirmPassword = "";

  void signUp() {
    setState(() {
      _password = _passwordController.text;
      _confirmPassword = _confirmPasswordController.text;
    });

    if (_password == _confirmPassword) {
      User().password = _password;
    }

    Firestore.instance.collection('users').document(User().nationalId).setData({
      'name': User().name,
      'email': User().email,
      'national ID': User().nationalId,
      'phone number': User().phoneNumber,
      'password': User().password
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        padding: EdgeInsets.all(16),
        child: new Container(
            child: SingleChildScrollView(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 70,
                  animation: true,
                  lineHeight: 40.0,
                  animationDuration: 1500,
                  percent: 1.0,
                  center: Text("100.0%", style: TextStyle(color: Colors.white)),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.green,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 32)),
              new TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: new InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('password'),
                    labelStyle: TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.green, width: 2.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Colors.blueGrey, width: 2.5),
                    )),
              ),
              Padding(padding: EdgeInsets.only(bottom: 32)),
              new TextFormField(
                controller: _confirmPasswordController,
                decoration: new InputDecoration(
                    labelText: AppLocalizations.of(context)
                        .translate('password_confirm'),
                    labelStyle: TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.green, width: 2.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Colors.blueGrey, width: 2.5),
                    )),
              ),
              Padding(padding: EdgeInsets.only(bottom: 32)),
              new ButtonTheme(
                height: 56,
                splashColor: Colors.greenAccent,
                child: new RaisedButton(
                  textTheme: ButtonTextTheme.accent,
                  child: new Text(
                      AppLocalizations.of(context).translate('sign_up'),
                      style: new TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  color: Colors.green,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () {
                    signUp();
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
