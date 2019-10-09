import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../app/home_screen.dart';
import '../models/user.dart';
import '../widgets/outlined_text_field.dart';
import '../widgets/rounded_button.dart';
import 'sign_up_screen_1.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreen createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  TextEditingController _nationalIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CircleAvatar(
                  child: Image.asset('assets/logo.png'),
                  backgroundColor: Colors.transparent,
                  radius: 64,
                ),
                Padding(padding: EdgeInsets.only(bottom: 32)),
                OutlinedTextField(
                  textKey: 'national_id',
                  controller: _nationalIdController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 32)),
                OutlinedTextField(
                  textKey: 'password',
                  controller: _passwordController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 72)),
                RoundedButton(textKey: 'sign_in', onPressed: signIn),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                RoundedButton(
                  textKey: 'sign_up',
                  navigateTo: SignUpScreen1(),
                  outlined: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
