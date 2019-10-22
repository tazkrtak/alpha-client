import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/language_bloc/bloc.dart';
import '../blocs/theme_bloc/bloc.dart';
import '../util/app_themes.dart';
import '../widgets/modal_tile.dart';

class ModalSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ModalTile(
              textKey: 'switch_language',
              icon: Icons.language,
              onTap: () {
                if (BlocProvider.of<LanguageBloc>(context)
                        .currentState
                        .locale
                        .languageCode ==
                    'en') {
                  BlocProvider.of<LanguageBloc>(context)
                      .dispatch(LanguageEvent(Locale('ar', 'EG')));
                } else {
                  BlocProvider.of<LanguageBloc>(context)
                      .dispatch(LanguageEvent(Locale('en', '')));
                }
                Navigator.pop(context);
              },
            ),
            ModalTile(
              textKey: 'switch_theme',
              icon: Icons.invert_colors,
              onTap: () {
                if (BlocProvider.of<ThemeBloc>(context)
                        .currentState
                        .themeData ==
                    appThemeData[AppTheme.GreenLight]) {
                  BlocProvider.of<ThemeBloc>(context)
                      .dispatch(ThemeEvent(AppTheme.AmoledBlack));
                } else if (BlocProvider.of<ThemeBloc>(context)
                        .currentState
                        .themeData ==
                    appThemeData[AppTheme.AmoledBlack]) {
                  BlocProvider.of<ThemeBloc>(context)
                      .dispatch(ThemeEvent(AppTheme.GreenLight));
                }
                Navigator.pop(context);
              },
            ),
            ModalTile(
              textKey: 'help',
              icon: Icons.help_outline,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ModalTile(
              textKey: 'send_feedback',
              icon: Icons.feedback,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
