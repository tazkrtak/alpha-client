import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../blocs/sign_in_bloc/bloc.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';
import '../widgets/outlined_text_field.dart';
import '../widgets/rounded_button.dart';
import 'sign_up_screen_1.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignInBloc>(
        builder: (context) => SignInBloc(),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  TextEditingController _nationalIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  SignInBloc _signInBloc;

  bool get isPopulated =>
      _nationalIdController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(SignInState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
    _nationalIdController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.isFailure) {
          final snackBar = SnackBar(content: Text('Failed to sing in. Please try again later.'));
          Scaffold.of(context).showSnackBar(snackBar);
        }
        if (state.isSubmitting) {
          final snackBar = SnackBar(content: Text('Signing in...'));
          Scaffold.of(context).showSnackBar(snackBar);
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(SignedIn());
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
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
                        keyboardType: TextInputType.number,
                        controller: _nationalIdController,
                        validator: (_) =>
                            !state.isNationalIdValid ? 'Invalid Id' : null,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 32)),
                      OutlinedTextField(
                        textKey: 'password',
                        obscureText: true,
                        controller: _passwordController,
                        validator: (_) =>
                            !state.isPasswordValid ? 'Invalid Password' : null,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 72)),
                      RoundedButton(
                        textKey: 'sign_in',
                        onPressed: isLoginButtonEnabled(state)
                            ? _onFormSubmitted
                            : null,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 16)),
                      RoundedButton(
                        textKey: 'sign_up',
                        outlined: true,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => BlocProvider(
                              builder: (context) => SignUpBloc(),
                              child: SignUpScreen1(),
                            ),
                          ),
                        ),
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
    super.dispose();
  }

  void _onEmailChanged() {
    _signInBloc.dispatch(
      NationalIdChanged(nationalId: _nationalIdController.text),
    );
  }

  void _onPasswordChanged() {
    _signInBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _signInBloc.dispatch(
      SignInPressed(
        nationalId: _nationalIdController.text,
        password: _passwordController.text,
      ),
    );
  }
}
