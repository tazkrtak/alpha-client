import 'package:Tazkrtak/signIn.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tazkrtak',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: SignIn(),
      debugShowCheckedModeBanner: false,
    );
  }
}

