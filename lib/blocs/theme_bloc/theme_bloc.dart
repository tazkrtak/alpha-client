import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';
import '../../util/app_themes.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState(appThemeData[AppTheme.GreenLight]);

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    yield ThemeState(appThemeData[event.theme]);
  }
}
