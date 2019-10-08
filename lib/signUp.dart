import 'package:Tazkrtak/mainApp.dart';
import 'package:Tazkrtak/models/user.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  static String tag = 'test-page';
  @override
  _SignUp createState() => new _SignUp();
}

class SignUp2 extends StatefulWidget {
  static String tag = 'test-page';
  @override
  _SignUp2 createState() => new _SignUp2();
}

class SignUp3 extends StatefulWidget {
  static String tag = 'test-page';
  @override
  _SignUp3 createState() => new _SignUp3();
}

class _SignUp3 extends State<SignUp3> {
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
      MaterialPageRoute(builder: (context) => Main()),
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
              Directionality(
                textDirection: TextDirection.rtl,
                child: new TextFormField(
                  obscureText: true,
                  controller: _passwordController,
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
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 2.5),
                      )),
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 32)),
              Directionality(
                textDirection: TextDirection.rtl,
                child: new TextFormField(
                  controller: _confirmPasswordController,
                  decoration: new InputDecoration(
                      labelText: 'تأكيد كلمة المرور ',
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
              new ButtonTheme(
                height: 56,
                splashColor: Colors.greenAccent,
                child: new RaisedButton(
                  textTheme: ButtonTextTheme.accent,
                  child: new Text('إنشاء حساب',
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

class _SignUp2 extends State<SignUp2> {
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
              Directionality(
                textDirection: TextDirection.rtl,
                child: new TextFormField(
                  controller: _nationalIdController,
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
                  controller: _phoneNumberController,
                  decoration: new InputDecoration(
                      labelText: 'رقم الهاتف',
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
              new ButtonTheme(
                height: 56,
                splashColor: Colors.greenAccent,
                child: new RaisedButton(
                  textTheme: ButtonTextTheme.accent,
                  child: new Text('استمرار',
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
                      MaterialPageRoute(builder: (context) => SignUp3()),
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

class _SignUp extends State<SignUp> {
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
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: new TextFormField(
                    controller: _nameController,
                    decoration: new InputDecoration(
                        labelText: 'الأسم',
                        labelStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.5),
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
                    controller: _emailController,
                    decoration: new InputDecoration(
                        labelText: 'البريد الالكترونى',
                        labelStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.blueGrey, width: 2.5),
                        )),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 32)),
                new ButtonTheme(
                  height: 56,
                  splashColor: Colors.greenAccent,
                  child: new RaisedButton(
                    textTheme: ButtonTextTheme.accent,
                    child: new Text('استمرار',
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
                        MaterialPageRoute(builder: (context) => SignUp2()),
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
