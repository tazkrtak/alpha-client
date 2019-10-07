import 'package:Tazkrtak/accountPage.dart';
import 'package:Tazkrtak/homePage.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  @override
  _Main createState() => new _Main();
}

class _Main extends State<Main>{
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          bottom: TabBar(
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
              ))
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MyHomePage(),
            MyAccountPage(),
          ],
        ),
      ),
    );;
  }


}