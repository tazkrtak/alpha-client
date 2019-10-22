import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/sign_up_bloc/bloc.dart';
import '../screens/sign_up_screen.dart';
import '../util/app_localizations.dart';
import '../widgets/outlined_text_field.dart';
import '../widgets/rounded_button.dart';

class SignUpForm1 extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm1> {
  SignUpBloc _signUpBloc;

  bool get isPopulated =>
      SignUpScreen.nameController.text.isNotEmpty &&
      SignUpScreen.emailController.text.isNotEmpty &&
      SignUpScreen.phoneNumberController.text.isNotEmpty;

  bool isContinueButtonEnabled(SignUpState state) {
    return state.isEmailValid &&
        state.isPhoneNumberValid &&
        state.isNameValid &&
        isPopulated;
  }

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    SignUpScreen.emailController.addListener(_onEmailChanged);
    SignUpScreen.phoneNumberController.addListener(_onPhoneNumberChanged);
    SignUpScreen.nameController.addListener(_onNameChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 32.0),
              OutlinedTextField(
                textKey: 'name',
                controller: SignUpScreen.nameController,
                validator: (_) {
                  return !state.isNameValid
                      ? AppLocalizations.of(context).translate("required")
                      : null;
                },
              ),
              SizedBox(height: 32.0),
              OutlinedTextField(
                textKey: 'email',
                controller: SignUpScreen.emailController,
                validator: (_) {
                  return !state.isEmailValid
                      ? AppLocalizations.of(context).translate("invalid_email")
                      : null;
                },
              ),
              SizedBox(height: 32.0),
              OutlinedTextField(
                textKey: 'mobile_number',
                prefixText: '+2',
                keyboardType: TextInputType.number,
                controller: SignUpScreen.phoneNumberController,
                validator: (_) {
                  return !state.isPhoneNumberValid
                      ? AppLocalizations.of(context).translate("invalid_phone")
                      : null;
                },
              ),
              SizedBox(height: 32.0),
              RoundedButton(
                textKey: 'continue',
                onPressed:
                    isContinueButtonEnabled(state) ? _onFormFinished : null,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onNameChanged() {
    _signUpBloc.dispatch(
      NameChanged(name: SignUpScreen.nameController.text),
    );
  }

  void _onEmailChanged() {
    _signUpBloc.dispatch(
      EmailChanged(email: SignUpScreen.emailController.text),
    );
  }

  void _onPhoneNumberChanged() {
    _signUpBloc.dispatch(
      PhoneNumberChanged(phoneNumber: SignUpScreen.phoneNumberController.text),
    );
  }

  void _onFormFinished() {
    SignUpScreen.pageController.animateToPage(1,
        curve: Curves.easeIn, duration: Duration(milliseconds: 400));
  }
}
