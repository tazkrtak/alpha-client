import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => PrimaryTheme();

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    switch (event) {
      case ThemeEvent.Primary:
        yield PrimaryTheme();
        break;
      case ThemeEvent.Black:
        yield BlackTheme();
        break;
    }
  }
}
