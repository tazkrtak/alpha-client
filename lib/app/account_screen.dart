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
        title: Text(AppLocalizations.of(context).translate('account')),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(bottom: 32)),
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
                Padding(padding: EdgeInsets.only(bottom: 32)),
                OutlinedTextField(
                  textKey: 'email',
                  controller: _emailController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                OutlinedTextField(
                  textKey: 'mobile_number',
                  prefixText: '+2',
                  keyboardType: TextInputType.number,
                  controller: _phoneNumberController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                OutlinedTextField(
                  textKey: 'password',
                  obscureText: true,
                  controller: _passwordController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                OutlinedTextField(
                  textKey: 'password_confirm',
                  obscureText: true,
                  controller: _confirmController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 32)),
                RoundedButton(
                  textKey: 'update',
                  onPressed: () {
                    /* TODO: Update Account here */
                  },
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                RoundedButton(
                  textKey: 'delete_account',
                  onPressed: () {
                    /* TODO: Delete Account here */
                  },
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
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
        ),
      ),
    );
  }
}
