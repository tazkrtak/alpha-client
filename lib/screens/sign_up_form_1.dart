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

  bool isFormValid(SignUpState state) {
    return state.isNameValid && state.isEmailValid && state.isPhoneNumberValid;
  }

  bool isContinueButtonEnabled(SignUpState state) {
    return isPopulated && isFormValid(state) && !state.isChecking;
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
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isChecking) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context).translate("sign_up_checking"),
              ),
            ),
          );
        }
        if (state.isEmailUnique && state.isPhoneNumberUnique) {
          SignUpScreen.pageController.animateToPage(
            1,
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 400),
          );
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
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
                    if (!state.isEmailValid) {
                      return AppLocalizations.of(context)
                          .translate("invalid_email");
                    } else if (state.isEmailUsed) {
                      return AppLocalizations.of(context)
                          .translate("email_used");
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 32.0),
                OutlinedTextField(
                  textKey: 'mobile_number',
                  prefixText: '+2',
                  keyboardType: TextInputType.number,
                  controller: SignUpScreen.phoneNumberController,
                  validator: (_) {
                    if (!state.isPhoneNumberValid) {
                      return AppLocalizations.of(context)
                          .translate("invalid_phone");
                    } else if (state.isPhoneNumberUsed) {
                      return AppLocalizations.of(context)
                          .translate("phone_used");
                    } else {
                      return null;
                    }
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
      ),
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
    _signUpBloc
      ..dispatch(StartChecking())
      ..dispatch(
        EmailSubmitted(email: SignUpScreen.emailController.text),
      )
      ..dispatch(
        PhoneNumberSubmitted(
            phoneNumber: SignUpScreen.phoneNumberController.text),
      );
  }
}
