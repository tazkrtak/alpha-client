import 'package:flutter/material.dart';

class AccountTab extends StatefulWidget {
  @override
  _MyAccountPage createState() => _MyAccountPage();
}

class _MyAccountPage extends State<AccountTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Account Info Here!')),
    );
  }
}
