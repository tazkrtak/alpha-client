import 'package:flutter/material.dart';
import 'package:tazkrtak/util/app_localizations.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
          padding: EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 16.0),
                Image.asset(
                  'assets/logo.png',
                  height: 108,
                  width: 108,
                ),
                SizedBox(height: 24.0),
                Text(
                  AppLocalizations.of(context).translate('app_name'),
                  style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle.color,
                      fontSize: 24),
                ),
                SizedBox(height: 32.0),
                Text(
                  AppLocalizations.of(context).translate('help_message'),
                  style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle.color,
                      fontSize: 16),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 24),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    AppLocalizations.of(context).translate('more_info'),
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'tazkrtak.web.app',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.title.color,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
