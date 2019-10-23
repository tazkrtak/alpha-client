import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/sign_up_bloc/bloc.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';
import '../screens/sign_up_form_1.dart';
import '../screens/sign_up_form_2.dart';
import '../widgets/progress_bar.dart';

class SignUpScreen extends StatelessWidget {
  static PageController pageController;
  static TextEditingController nameController;
  static TextEditingController emailController;
  static TextEditingController phoneNumberController;
  static TextEditingController nationalIdController;
  static TextEditingController passwordController;
  static TextEditingController confirmController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocProvider<SignUpBloc>(
        builder: (context) => SignUpBloc(),
        child: _SignUpForm(),
      ),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  StreamController _progressIndicatorStreamController = StreamController<int>();
  @override
  void initState() {
    SignUpScreen.pageController = PageController(initialPage: 0);
    SignUpScreen.nameController = TextEditingController();
    SignUpScreen.emailController = TextEditingController();
    SignUpScreen.phoneNumberController = TextEditingController();
    SignUpScreen.nationalIdController = TextEditingController();
    SignUpScreen.passwordController = TextEditingController();
    SignUpScreen.confirmController = TextEditingController();
    _progressIndicatorStreamController.add(50);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 64.0),
                StreamBuilder<int>(
                    stream: _progressIndicatorStreamController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ProgressBar(snapshot.data);
                      } else {
                        return ProgressBar(0);
                      }
                    }),
                SizedBox(height: 32.0),
                Expanded(
                  child: PageView(
                    controller: SignUpScreen.pageController,
                    scrollDirection: Axis.horizontal,
                    pageSnapping: false,
                    onPageChanged: _onPageChange,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      SignUpForm1(),
                      SignUpForm2(),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }

  Future<bool> _onWillPop() {
    if (SignUpScreen.pageController.page == 0) {
      return Future<bool>.value(true);
    } else {
      SignUpScreen.pageController.animateToPage(0,
          curve: Curves.easeOutBack, duration: Duration(milliseconds: 400));
      return Future<bool>.value(false);
    }
  }

  void _onPageChange(int page) {
    page == 1
        ? _progressIndicatorStreamController.add(100)
        : _progressIndicatorStreamController.add(50);
  }

  @override
  void dispose() {
    SignUpScreen.pageController.dispose();
    SignUpScreen.nameController.dispose();
    SignUpScreen.emailController.dispose();
    SignUpScreen.phoneNumberController.dispose();
    SignUpScreen.nationalIdController.dispose();
    SignUpScreen.passwordController.dispose();
    SignUpScreen.confirmController.dispose();
    super.dispose();
  }
}
