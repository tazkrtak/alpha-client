import 'package:Tazkrtak/mainApp.dart';
import 'package:Tazkrtak/signUp.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _signIn createState() => new _signIn();
}

class _signIn extends State<SignIn> {
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
              Directionality(
                textDirection: TextDirection.rtl,
                child: new TextFormField(
                  obscureText: true,
                  decoration: new InputDecoration(
                      labelText: 'الرقم القومى',
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
              ),
              Padding(padding: EdgeInsets.only(bottom: 32)),
              Directionality(
                textDirection: TextDirection.rtl,
                child: new TextFormField(
                  obscureText: true,
                  decoration: new InputDecoration(
                      labelText: 'كلمة المرور',
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
              ),
              Padding(padding: EdgeInsets.only(bottom: 72)),
              new ButtonTheme(
                height: 56,
                splashColor: Colors.greenAccent,
                child: new RaisedButton(
                  textTheme: ButtonTextTheme.accent,
                  child: new Text('تسجيل دخول',
                      style: new TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  color: Colors.green,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Main()),
                    );
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 16)),
              new ButtonTheme(
                height: 56,
                splashColor: Colors.greenAccent,
                child: new RaisedButton(
                  textTheme: ButtonTextTheme.accent,
                  child: new Text('إنشاء حساب جديد',
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
