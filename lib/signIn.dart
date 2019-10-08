import 'package:Tazkrtak/appLocalizations.dart';
import 'package:Tazkrtak/mainApp.dart';
import 'package:Tazkrtak/models/user.dart';
import 'package:Tazkrtak/signUp.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn extends StatefulWidget {
  @override
  _SignIn createState() => new _SignIn();
}

class _SignIn extends State<SignIn> {
  TextEditingController _nationalIdController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  String _nationalId = "";
  String _password = "";

  signIn() {
    setState(() {
      _nationalId = _nationalIdController.text;
      _password = _passwordController.text;
    });

    Firestore.instance
        .collection('users')
        .document(_nationalId)
        .get()
        .then((DocumentSnapshot ds) {
      User().name = ds['name'];
      User().email = ds['email'];
      User().password = ds['password'];
      User().nationalId = ds['national ID'];
      User().phoneNumber = ds['phone number'];
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Main()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        padding: EdgeInsets.all(16),
        child: new Center(
            child: SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CircleAvatar(
                child: Image.asset('assets/logo.png'),
                backgroundColor: Colors.transparent,
                radius: 64,
              ),
              Padding(padding: EdgeInsets.only(bottom: 32)),
              new TextFormField(
                obscureText: true,
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
                controller: _passwordController,
                obscureText: true,
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
                      borderSide: BorderSide(color: Colors.grey, width: 2.5),
                    )),
              ),
              Padding(padding: EdgeInsets.only(bottom: 72)),
              new ButtonTheme(
                height: 56,
                splashColor: Colors.greenAccent,
                child: new RaisedButton(
                  textTheme: ButtonTextTheme.accent,
                  child: new Text(
                      AppLocalizations.of(context).translate('sign_in'),
                      style: new TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  color: Colors.green,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () {
                    signIn();
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 16)),
              new ButtonTheme(
                height: 56,
                splashColor: Colors.greenAccent,
                child: new RaisedButton(
                  textTheme: ButtonTextTheme.accent,
                  child: new Text(
                      AppLocalizations.of(context).translate('sign_up'),
                      style: new TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                  color: Colors.white,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: new BorderSide(color: Colors.green, width: 2.5),
                      borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
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
