import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../blocs/sign_up_bloc/bloc.dart';
import '../models/user.dart';
import '../signing/sign_up_screen_1.dart';
import '../util/secret_generator.dart';
import '../widgets/outlined_text_field.dart';
import '../widgets/progress_bar.dart';
import '../widgets/rounded_button.dart';

class SignUpScreen2 extends StatelessWidget {
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
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  SignUpBloc _signUpBloc;

  bool get isPopulated =>
      _nationalIdController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignUpState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    _nationalIdController.addListener(_onNationalIdChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          // TODO: Show "Signing up..." Snack bar.
        }
        if (state.isFailure) {
          // TODO: Show "Failed to Sign up..." Snack bar.
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(SignedIn());
          Navigator.of(context).pop(); // SignUpScreen2
          Navigator.of(context).pop(); // SignUpScreen1
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
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
                          child: ProgressBar(100)),
                      Padding(padding: EdgeInsets.only(bottom: 32)),
                      OutlinedTextField(
                        textKey: 'national_id',
                        controller: _nationalIdController,
                        keyboardType: TextInputType.number,
                        validator: (_) {
                          return !state.isNationalIdValid ? 'Invalid ID' : null;
                        },
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 32)),
                      OutlinedTextField(
                        textKey: 'password',
                        obscureText: true,
                        controller: _passwordController,
                        validator: (_) {
                          return !state.isPasswordValid
                              ? 'Invalid Password'
                              : null;
                        },
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 32)),
                      OutlinedTextField(
                        textKey: 'password_confirm',
                        obscureText: true,
                        controller: _confirmPasswordController,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 32)),
                      RoundedButton(
                        textKey: 'sign_up',
                        onPressed: isSignUpButtonEnabled(state)
                            ? _onFormSubmitted
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nationalIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onNationalIdChanged() {
    _signUpBloc.dispatch(
      NationalIdChanged(nationalId: _nationalIdController.text),
    );
  }

  void _onPasswordChanged() {
    _signUpBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _signUpBloc.dispatch(
      Submitted(
        User(
            name: SignUpScreen1.name,
            email: SignUpScreen1.email,
            phoneNumber: SignUpScreen1.phoneNumber,
            nationalId: _nationalIdController.text,
            password: _passwordController.text,
            balance: 0,
            secret: SecretGenerator.generate()),
      ),
    );
    SignUpScreen1.name = null;
    SignUpScreen1.email = null;
    SignUpScreen1.phoneNumber = null;
  }
}
