import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../models/user.dart';
import '../util/app_localizations.dart';
import '../widgets/outlined_text_field.dart';
import '../widgets/rounded_button.dart';

class AccountScreen extends StatefulWidget {
  final User _user;

  AccountScreen(this._user);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget._user.email;
    _phoneNumberController.text = widget._user.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: Theme.of(context).appBarTheme.textTheme,
        title: Text(AppLocalizations.of(context).translate('account')),
        backgroundColor: Theme.of(context).appBarTheme.color,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget._user.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget._user.nationalId,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 32.0),
            OutlinedTextField(
              textKey: 'email',
              controller: _emailController,
            ),
            SizedBox(height: 16.0),
            OutlinedTextField(
              textKey: 'mobile_number',
              prefixText: '+2',
              keyboardType: TextInputType.number,
              controller: _phoneNumberController,
            ),
            SizedBox(height: 16.0),
            OutlinedTextField(
              textKey: 'password',
              obscureText: true,
              controller: _passwordController,
            ),
            SizedBox(height: 16.0),
            OutlinedTextField(
              textKey: 'confirm_password',
              obscureText: true,
              controller: _confirmController,
            ),
            SizedBox(height: 32.0),
            RoundedButton(
              textKey: 'update',
              onPressed: () {
                /* TODO: Update Account here */
              },
            ),
            SizedBox(height: 24.0),
            RoundedButton(
              textKey: 'delete_account',
              onPressed: () {
                /* TODO: Delete Account here */
              },
            ),
            SizedBox(height: 24.0),
            RoundedButton(
              textKey: 'sign_out',
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<AuthenticationBloc>(context)
                    .dispatch(SignedOut());
              },
            ),
          ],
        ),
      ),
    );
  }
}
