import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;

  ThemeState(this.themeData) : super([themeData]);

  @override
  String toString() {
    return 'ThemeState { themeData: $themeData }';
  }
}
