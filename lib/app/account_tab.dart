import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../models/user.dart';
import '../widgets/rounded_button.dart';

class AccountTab extends StatefulWidget {
  final User _user;

  AccountTab(this._user);

  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: RoundedButton(
                    textKey: 'sign_out',
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .dispatch(SignedOut());
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
