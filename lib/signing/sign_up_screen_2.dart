import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/user.dart';
import '../widgets/outlined_text_field.dart';
import '../widgets/rounded_button.dart';
import 'sign_up_screen_3.dart';

class SignUpScreen2 extends StatefulWidget {
  @override
  _SignUpScreen2 createState() => _SignUpScreen2();
}

class _SignUpScreen2 extends State<SignUpScreen2> {
  String _nationalId = "";
  String _phoneNumber = "";
  TextEditingController _nationalIdController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

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
                    percent: 0.7,
                    center:
                        Text("70.0%", style: TextStyle(color: Colors.white)),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.green,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 32)),
                OutlinedTextField(
                  textKey: 'national_id',
                  controller: _nationalIdController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 32)),
                OutlinedTextField(
                  textKey: 'mobile_number',
                  controller: _phoneNumberController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 32)),
                RoundedButton(
                  textKey: 'continue',
                  onPressed: addToModel,
                  navigateTo: SignUpScreen3(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
