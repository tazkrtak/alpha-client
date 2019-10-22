import 'package:equatable/equatable.dart';

import '../../util/app_themes.dart';

class ThemeEvent extends Equatable {
  final AppTheme theme;

  ThemeEvent(this.theme) : super([theme]);
  @override
  String toString() {
    return 'ThemeChanged { AppTheme: $theme }';
  }
}
