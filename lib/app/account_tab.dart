import 'package:flutter/material.dart';

import '../models/user.dart';

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
      body: Center(child: Text(widget._user.name)),
    );
  }
}
