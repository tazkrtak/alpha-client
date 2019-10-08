import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/user.dart';
import '../util/app_localizations.dart';
import 'sign_up_screen_2.dart';

class SignUpScreen1 extends StatefulWidget {
  static String tag = 'test-page';

  @override
  _SignUpScreen1 createState() => new _SignUpScreen1();
}

class _SignUpScreen1 extends State<SignUpScreen1> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = new TextEditingController();
    String _name = "";
    String _email = "";
    void addToModel() {
      setState(() {
        _name = _nameController.text;
        _email = _emailController.text;
      });
      User().name = _name;
      User().email = _email;
    }

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
                    percent: 0.3,
                    center:
                        Text("30.0%", style: TextStyle(color: Colors.white)),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.green,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 32)),
                new TextFormField(
                  controller: _nameController,
                  decoration: new InputDecoration(
                      labelText: AppLocalizations.of(context).translate('name'),
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
                  controller: _emailController,
                  decoration: new InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('email'),
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
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen2()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
