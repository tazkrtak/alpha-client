import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/user.dart';
import '../util/app_localizations.dart';
import 'sign_up_screen_3.dart';

class SignUpScreen2 extends StatefulWidget {
  static String tag = 'test-page';

  @override
  _SignUpScreen2 createState() => new _SignUpScreen2();
}

class _SignUpScreen2 extends State<SignUpScreen2> {
  TextEditingController _nationalIdController = new TextEditingController();
  String _nationalId = "";
  TextEditingController _phoneNumberController = new TextEditingController();
  String _phoneNumber = "";

  void addToModel() {
    setState(() {
      _nationalId = _nationalIdController.text;
      _phoneNumber = _phoneNumberController.text;
    });
    User().nationalId = _nationalId;
    User().phoneNumber = _phoneNumber;
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
                  percent: 0.7,
                  center: Text("70.0%", style: TextStyle(color: Colors.white)),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.green,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 32)),
              new TextFormField(
                controller: _nationalIdController,
                decoration: new InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('national_id'),
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
                controller: _phoneNumberController,
                decoration: new InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('mobile_number'),
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
                      AppLocalizations.of(context).translate('continue'),
                      style: new TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  color: Colors.green,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () {
                    addToModel();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen3()),
                    );
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
