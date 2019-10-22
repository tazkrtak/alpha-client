import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../util/app_localizations.dart';

class ModalTile extends StatelessWidget {
  final String textKey;
  final IconData icon;
  final VoidCallback onTap;

  const ModalTile({this.textKey, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(
        AppLocalizations.of(context).translate(textKey),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.subtitle.color,
          fontSize: 16.0,
        ),
      ),
      onTap: onTap,
    );
  }
}
