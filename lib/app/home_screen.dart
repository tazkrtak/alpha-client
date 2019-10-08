import 'package:flutter/material.dart';

import 'account_tab.dart';
import 'ticket_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _Main createState() => new _Main();
}

class _Main extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          flexibleSpace: SafeArea(
            child: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 32,
                  ),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TicketTab(),
            AccountTab(),
          ],
        ),
      ),
    );
  }
}
