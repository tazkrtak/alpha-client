import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'blocs/authentication_bloc/bloc.dart';
import 'blocs/language_bloc/bloc.dart';
import 'blocs/sign_in_bloc/bloc.dart';
import 'blocs/theme_bloc/bloc.dart';
import 'screens/home_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/splash_screen.dart';
import 'util/app_bloc_delegate.dart';
import 'util/app_localizations.dart';

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          builder: (context) => ThemeBloc(),
        ),
        BlocProvider<LanguageBloc>(
          builder: (context) => LanguageBloc(),
        ),
        BlocProvider<AuthenticationBloc>(
          builder: (context) => AuthenticationBloc()..dispatch(AppStarted()),
        ),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, languageState) {
        return MaterialApp(
          title: 'Tazkrtak',
          debugShowCheckedModeBanner: false,
          theme: themeState.themeData,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is Unauthenticated) {
                return BlocProvider<SignInBloc>(
                  builder: (context) => SignInBloc(),
                  child: SignInScreen(),
                );
              } else if (state is Authenticated) {
                return HomeScreen(state.user);
              } else {
                return SplashScreen();
              }
            },
          ),
          locale: languageState.locale,
          supportedLocales: [Locale('en'), Locale('ar', 'EG')],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        );
      });
    });
  }
}
