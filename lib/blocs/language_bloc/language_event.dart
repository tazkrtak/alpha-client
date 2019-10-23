import 'dart:ui';

import 'package:equatable/equatable.dart';

class LanguageEvent extends Equatable {
  final Locale locale;

  LanguageEvent(this.locale) : super();

  @override
  String toString() {
    return 'LanguageChanged { Language: $locale }';
  }
}
