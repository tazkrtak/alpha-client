import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class LocaleState extends Equatable {
  final Locale locale;

  LocaleState(this.locale) : super([locale]);

  @override
  String toString() {
    return 'LocaleState { Locale: $locale }';
  }
}

class EnglishLocale extends LocaleState {
  static const Locale LOCALE = Locale("en");
  EnglishLocale() : super(LOCALE);
}

class ArabicLocale extends LocaleState {
  static const Locale LOCALE = Locale("ar", "EG");
  ArabicLocale() : super(LOCALE);
}
