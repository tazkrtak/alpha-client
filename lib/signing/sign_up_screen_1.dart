import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/sign_up_bloc/bloc.dart';
import '../models/user.dart';
import '../widgets/outlined_text_field.dart';
import '../widgets/progress_bar.dart';
import '../widgets/rounded_button.dart';
import 'sign_up_screen_2.dart';

class SignUpScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  SignUpBloc _signUpBloc;

  bool get isPopulated =>
      _nameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty;

  bool isContinueButtonEnabled(SignUpState state) {
    return state.isEmailValid && isPopulated;
  }

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    _emailController.addListener(_onEmailChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
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
                      child: ProgressBar(50),
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
                      validator: (_) {
                        return !state.isEmailValid ? 'Invalid Email' : null;
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 32)),
                    OutlinedTextField(
                      textKey: 'mobile_number',
                      controller: _phoneNumberController,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 32)),
                    RoundedButton(
                      textKey: 'continue',
                      onPressed: isContinueButtonEnabled(state)
                          ? _onFormFinished
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _signUpBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onFormFinished() {
    User().name = _nameController.text;
    User().email = _emailController.text;
    User().phoneNumber = _phoneNumberController.text;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (c) => SignUpScreen2()),
    );
  }
}
