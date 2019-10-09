import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/home_screen.dart';
import 'blocs/authentication_bloc/bloc.dart';
import 'blocs/sign_in_bloc/bloc.dart';
import 'signing/sign_in_screen.dart';
import 'signing/splash_screen.dart';
import 'util/app_bloc_delegate.dart';
import 'util/app_localizations.dart';

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  runApp(
    BlocProvider(
      builder: (context) => AuthenticationBloc()..dispatch(AppStarted()),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tazkrtak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          } else if (state is Unauthenticated) {
            return BlocProvider<SignInBloc>(
              builder: (context) => SignInBloc(),
              child: SignInScreen(),
            );
          } else {
            return HomeScreen();
          }
        },
      ),
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
  }
}
