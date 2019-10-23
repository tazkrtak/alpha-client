import 'package:flutter/material.dart';
import 'package:tazkrtak/widgets/rounded_button.dart';

import '../util/app_localizations.dart';
import 'outlined_text_field.dart';

class BalanceDialog extends StatelessWidget {
  final VoidCallback onPressed;
  final BuildContext context;

  BalanceDialog({this.context, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
     contentPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        AppLocalizations.of(context).translate('recharge'),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            SizedBox(height: 8),
            OutlinedTextField(
              textKey: 'cardNumber',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8),
            OutlinedTextField(
              textKey: 'securityCode',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8),
            OutlinedTextField(
              suffixText: AppLocalizations.of(context).translate("currency"),
              textKey: 'paymentAmount',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            RoundedButton(textKey: 'done', onPressed: onPressed),
          ],
        ),
      ),
    );
  }
}
