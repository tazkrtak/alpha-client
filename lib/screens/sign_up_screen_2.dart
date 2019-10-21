import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../blocs/sign_up_bloc/bloc.dart';
import '../models/user.dart';
import '../screens/sign_up_screen_1.dart';
import '../util/app_localizations.dart';
import '../util/totp.dart';
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
  final TextEditingController _confirmController = TextEditingController();

  SignUpBloc _signUpBloc;

  bool get isPopulated =>
      _nationalIdController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignUpState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    _nationalIdController.addListener(_onNationalIdChanged);
    _passwordController.addListener(_onPasswordChanged);
    _confirmController.addListener(_onConfirmPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context).translate("sign_up_submitting"),
              ),
            ),
          );
        }
        if (state.isFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context).translate("sign_up_failure"),
              ),
            ),
          );
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
                          padding: EdgeInsets.all(16),
                          child: ProgressBar(100)),
                      Padding(padding: EdgeInsets.only(bottom: 32)),
                      OutlinedTextField(
                        textKey: 'national_id',
                        controller: _nationalIdController,
                        keyboardType: TextInputType.number,
                        validator: (_) {
                          return !state.isNationalIdValid
                              ? AppLocalizations.of(context)
                                  .translate("invalid_id")
                              : null;
                        },
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 32)),
                      OutlinedTextField(
                        textKey: 'password',
                        obscureText: true,
                        controller: _passwordController,
                        validator: (_) {
                          return !state.isPasswordValid
                              ? AppLocalizations.of(context)
                                  .translate("invalid_password")
                              : null;
                        },
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 32)),
                      OutlinedTextField(
                        textKey: 'confirm_password',
                        obscureText: true,
                        controller: _confirmController,
                        validator: (_) {
                          return !state.isConfirmPasswordValid
                              ? AppLocalizations.of(context)
                                  .translate("not_matching_passwords")
                              : null;
                        },
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
    _confirmController.dispose();
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

  void _onConfirmPasswordChanged() {
    _signUpBloc.dispatch(
      ConfirmPasswordChanged(
          password: _passwordController.text,
          confirmPassword: _confirmController.text),
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
          secret: TOTP.generateSecret(),
        ),
      ),
    );
    SignUpScreen1.name = null;
    SignUpScreen1.email = null;
    SignUpScreen1.phoneNumber = null;
  }
}
