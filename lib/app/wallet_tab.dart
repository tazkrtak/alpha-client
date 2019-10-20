import 'package:flutter/material.dart';

import '../models/user.dart';
import '../widgets/animated_chart.dart';
import '../widgets/list_title_modal_bottom.dart';
import 'account_screen.dart';

class WalletTab extends StatefulWidget {
  final User _user;

  WalletTab(this._user);

  @override
  _WalletTabState createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
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
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.blueGrey,
                  size: 28,
                ),
                onPressed: _onModalButtonPressed,
              ),
              IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.blueGrey,
                  size: 28,
                ),
                onPressed: _onAccountButtonPressed,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onAccountButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AccountScreen(widget._user)),
    );
  }

  void _onModalButtonPressed() {
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
                  textKey: 'help',
                  icon: Icons.help_outline,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              ListTitle(
                  textKey: 'send_feedback',
                  icon: Icons.feedback,
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        );
      },
    );
  }
}
