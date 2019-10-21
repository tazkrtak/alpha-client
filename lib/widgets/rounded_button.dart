import 'package:flutter/material.dart';

import '../util/app_localizations.dart';

class RoundedButton extends StatelessWidget {
  final String textKey;
  final VoidCallback onPressed;
  final bool outlined;

  RoundedButton({
    this.textKey,
    this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 56,
      splashColor: Colors.greenAccent,
      child: RaisedButton(
        color: outlined ? Colors.white : Colors.green,
        textColor: Colors.white,
        textTheme: ButtonTextTheme.accent,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          side: outlined
              ? BorderSide(color: Colors.green, width: 2.5)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          AppLocalizations.of(context).translate(textKey),
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: outlined ? Colors.green : Colors.white),
        ),
      ),
    );
  }
}
