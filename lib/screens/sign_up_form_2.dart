import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../blocs/sign_up_bloc/bloc.dart';
import '../models/user.dart';
import '../screens/sign_up_screen.dart';
import '../util/app_localizations.dart';
import '../util/totp.dart';
import '../widgets/outlined_text_field.dart';
import '../widgets/rounded_button.dart';

class SignUpForm2 extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm2> {
  SignUpBloc _signUpBloc;

  bool get isPopulated =>
      SignUpScreen.nationalIdController.text.isNotEmpty &&
      SignUpScreen.passwordController.text.isNotEmpty &&
      SignUpScreen.confirmController.text.isNotEmpty;

  bool isFormValid(SignUpState state) {
    return state.isNationalIdValid &&
        state.isPasswordValid &&
        state.isConfirmPasswordValid;
  }

  bool isSignUpButtonEnabled(SignUpState state) {
    return isPopulated &&
        isFormValid(state) &&
        !state.isChecking &&
        !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    SignUpScreen.nationalIdController.addListener(_onNationalIdChanged);
    SignUpScreen.passwordController.addListener(_onPasswordChanged);
    SignUpScreen.confirmController.addListener(_onConfirmPasswordChanged);
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
        if (state.isNationalIdUnique) {
          _signUpBloc.dispatch(
            Submitted(
              User(
                name: SignUpScreen.nameController.text,
                email: SignUpScreen.emailController.text,
                phoneNumber: SignUpScreen.phoneNumberController.text,
                nationalId: SignUpScreen.nationalIdController.text,
                password: SignUpScreen.passwordController.text,
                balance: 0,
                chargedBalance: 0,
                lastTransactionId: "",
                secret: TOTP.generateSecret(),
              ),
            ),
          );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(SignedIn());
          Navigator.of(context).pop(); // SignUpScreen
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
                  textKey: 'national_id',
                  controller: SignUpScreen.nationalIdController,
                  keyboardType: TextInputType.number,
                  validator: (_) {
                    if (!state.isNationalIdValid) {
                      return AppLocalizations.of(context)
                          .translate("invalid_id");
                    } else if (state.isNationalIdUsed) {
                      return AppLocalizations.of(context)
                          .translate("national_id_used");
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 32.0),
                OutlinedTextField(
                  textKey: 'password',
                  obscureText: true,
                  controller: SignUpScreen.passwordController,
                  validator: (_) {
                    return !state.isPasswordValid
                        ? AppLocalizations.of(context)
                            .translate("invalid_password")
                        : null;
                  },
                ),
                SizedBox(height: 32.0),
                OutlinedTextField(
                  textKey: 'confirm_password',
                  obscureText: true,
                  controller: SignUpScreen.confirmController,
                  validator: (_) {
                    return !state.isConfirmPasswordValid
                        ? AppLocalizations.of(context)
                            .translate("not_matching_passwords")
                        : null;
                  },
                ),
                SizedBox(height: 32.0),
                RoundedButton(
                  textKey: 'sign_up',
                  onPressed:
                      isSignUpButtonEnabled(state) ? _onFormSubmitted : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onNationalIdChanged() {
    _signUpBloc.dispatch(
      NationalIdChanged(nationalId: SignUpScreen.nationalIdController.text),
    );
  }

  void _onPasswordChanged() {
    _signUpBloc.dispatch(
      PasswordChanged(password: SignUpScreen.passwordController.text),
    );
  }

  void _onConfirmPasswordChanged() {
    _signUpBloc.dispatch(
      ConfirmPasswordChanged(
          password: SignUpScreen.passwordController.text,
          confirmPassword: SignUpScreen.confirmController.text),
    );
  }

  void _onFormSubmitted() {
    _signUpBloc.dispatch(NationalIdSubmitted(
        nationalId: SignUpScreen.nationalIdController.text));
  }
}
