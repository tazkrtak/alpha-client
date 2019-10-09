import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../app/home_screen.dart';
import '../models/user.dart';
import '../widgets/outlined_text_field.dart';
import '../widgets/rounded_button.dart';

class SignUpScreen3 extends StatefulWidget {
  @override
  _SignUpScreen3 createState() => _SignUpScreen3();
}

class _SignUpScreen3 extends State<SignUpScreen3> {
  String _password = "";
  String _confirmPassword = "";

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Container(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: LinearPercentIndicator(
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
              OutlinedTextField(
                textKey: 'password',
                controller: _passwordController,
              ),
              Padding(padding: EdgeInsets.only(bottom: 32)),
              OutlinedTextField(
                textKey: 'password_confirm',
                controller: _confirmPasswordController,
              ),
              Padding(padding: EdgeInsets.only(bottom: 32)),
              RoundedButton(
                textKey: 'sign_up',
                onPressed: signUp,
                navigateTo: HomeScreen(),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
