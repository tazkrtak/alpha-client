import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
                  onPressed: () {},
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
