import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'signing/sign_in_screen.dart';
import 'util/app_localizations.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tazkrtak',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: SignInScreen(),
      debugShowCheckedModeBanner: false,
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
