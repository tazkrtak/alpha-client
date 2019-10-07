import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPage createState() => _MyAccountPage();
}


class _MyAccountPage extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(),
      floatingActionButton: new FloatingActionButton(
        //onPressed: ,
        tooltip: 'Increment',
        backgroundColor: Colors.green,
        child: new Icon(Icons.add),
      ),
    );
  }
}
