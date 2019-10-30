import 'package:flutter/material.dart';
import 'package:tazkrtak/util/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/logo_white.png',
              alignment: Alignment.center,
              height: 128,
              width: 128,
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              AppLocalizations.of(context).translate('app_name'),
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
