import 'package:flutter/material.dart';

enum AppTheme { GreenLight, AmoledBlack }

final appThemeData = {
  AppTheme.GreenLight: ThemeData(
      backgroundColor: Colors.white,
      splashColor: Color(0XFF6DEDAB),
      errorColor: Color(0XFFDC3545),
      primaryColor: Color(0XFF32BA7C),
      primaryColorDark: Color(0XFF00894f),
      primaryColorLight: Color(0XFF6DEDAB),
      accentColor: Color(0XFFfdd835),
      highlightColor: Colors.blueGrey,
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        color: Color(0XFF32BA7C),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
            fontFamily: 'Almarai',
            fontSize: 24.0,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[900],
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      bottomAppBarColor: Colors.white,
      textTheme: TextTheme(
        body1: TextStyle(
          color: Colors.black,
        ),
        body2: TextStyle(
          color: Colors.black87.withOpacity(.64),
        ),
        title: TextStyle(
          color: Colors.black87,
        ),
        subtitle: TextStyle(
          color: Colors.blueGrey,
        ),
        headline: TextStyle(
          color: Colors.black,
        ),
        subhead: TextStyle(
          color: Colors.blueGrey.withOpacity(.64),
        ),
        // Outined Button only, Filled button takes white color.
        button: TextStyle(
          color: Color(0XFF32BA7C),
        ),
        display1: TextStyle(
          color: Colors.black87,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.bold,
          fontSize: 48,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.blueGrey),
      primaryIconTheme: IconThemeData(color: Colors.white),
      cardColor: Colors.white,
      fontFamily: 'Almarai'),
  AppTheme.AmoledBlack: ThemeData(
      backgroundColor: Colors.black,
      splashColor: Colors.grey[900],
      errorColor: Color(0XFFDC3545),
      primaryColor: Colors.grey[900],
      primaryColorDark: Colors.white,
      accentColor: Color(0XFF32BA7C),
      highlightColor: Colors.grey[700],
      appBarTheme: AppBarTheme(
        color: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
            fontFamily: 'Almarai',
            fontSize: 24.0,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[900],
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      bottomAppBarColor: Colors.grey[900],
      textTheme: TextTheme(
        body1: TextStyle(
          color: Colors.white70,
        ),
        body2: TextStyle(
          color: Colors.white70.withOpacity(.64),
        ),
        title: TextStyle(
          color: Colors.white,
        ),
        headline: TextStyle(
          color: Colors.white,
        ),
        subhead: TextStyle(
          color: Colors.white60,
        ),
        subtitle: TextStyle(
          color: Colors.white60,
        ),
        // Outined Button only, Filled button takes white color.
        button: TextStyle(
          color: Colors.grey[600],
        ),
        display1: TextStyle(
          color: Colors.white,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.bold,
          fontSize: 48,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      primaryIconTheme: IconThemeData(
        color: Colors.white,
      ),
      cardColor: Colors.grey[900],
      fontFamily: 'Almarai')
};
