import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import './bloc.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  @override
  LanguageState get initialState => LanguageState(Locale("en", ""));

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    yield LanguageState(event.locale);
  }
}
