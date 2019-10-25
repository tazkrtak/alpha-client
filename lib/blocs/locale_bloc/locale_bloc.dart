import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  @override
  LocaleState get initialState => EnglishLocale();

  String get locale => currentState.locale.toString();

  @override
  Stream<LocaleState> mapEventToState(LocaleEvent event) async* {
    switch (event) {
      case LocaleEvent.English:
        yield EnglishLocale();
        break;
      case LocaleEvent.Arabic:
        yield ArabicLocale();
        break;
    }
  }
}
