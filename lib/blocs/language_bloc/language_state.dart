import 'dart:ui';

import 'package:equatable/equatable.dart';

class LanguageState extends Equatable {
  final Locale locale;

  LanguageState(this.locale) : super([locale]);

  @override
  String toString() {
    return 'LanguageState { Locale: $locale }';
  }
}
