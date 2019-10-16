import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../models/user.dart';
import '../widgets/animated_chart.dart';
import '../widgets/list_title_modal_bottom.dart';

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
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 8),
                AnimatedChart(balance: 50),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu, color: Colors.blueGrey),
                onPressed: _onSettingButtonTapped,
              ),
              IconButton(
                icon: Icon(Icons.history, color: Colors.blueGrey),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onSettingButtonTapped() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTitle(
                    textKey: 'switch_language',
                    icon: Icons.language,
                    onTap: () {
                      Navigator.pop(context);
                    }),
                ListTitle(
                    textKey: 'switch_theme',
                    icon: Icons.invert_colors,
                    onTap: () {
                      Navigator.pop(context);
                    }),
                ListTitle(
                    textKey: 'delete_account',
                    icon: Icons.delete_outline,
                    onTap: () {
                      Navigator.pop(context);
                    }),
                ListTitle(
                    textKey: 'sign_out',
                    icon: Icons.exit_to_app,
                    onTap: () {
                      Navigator.pop(context);
                      BlocProvider.of<AuthenticationBloc>(context)
                          .dispatch(SignedOut());
                    }),
                ListTitle(
                    textKey: 'help',
                    icon: Icons.help_outline,
                    onTap: () {
                      Navigator.pop(context);
                    }),
                ListTitle(
                    textKey: 'send_feedback',
                    icon: Icons.help_outline,
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }
}
