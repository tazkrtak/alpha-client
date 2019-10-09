import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/user.dart';
import '../widgets/outlined_text_field.dart';
import '../widgets/rounded_button.dart';
import 'sign_up_screen_2.dart';

class SignUpScreen1 extends StatefulWidget {
  @override
  _SignUpScreen1 createState() => _SignUpScreen1();
}

class _SignUpScreen1 extends State<SignUpScreen1> {
  @override
  Widget build(BuildContext context) {
    String _name = "";
    String _email = "";
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    void addToModel() {
      setState(() {
        _name = _nameController.text;
        _email = _emailController.text;
      });
      User().name = _name;
      User().email = _email;
    }

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
                    percent: 0.3,
                    center:
                        Text("30.0%", style: TextStyle(color: Colors.white)),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.green,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 32)),
                OutlinedTextField(
                  textKey: 'name',
                  controller: _nameController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 32)),
                OutlinedTextField(
                  textKey: 'email',
                  controller: _emailController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 32)),
                RoundedButton(
                  textKey: 'continue',
                  onPressed: addToModel,
                  navigateTo: SignUpScreen2(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
