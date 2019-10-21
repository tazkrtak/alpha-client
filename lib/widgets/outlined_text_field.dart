import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../util/app_localizations.dart';

class OutlinedTextField extends StatelessWidget {
  final String textKey;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String prefixText;
  final FormFieldValidator<String> validator;

  OutlinedTextField({
    this.textKey,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      autovalidate: true,
      autocorrect: false,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          prefixText: prefixText,
          border: OutlineInputBorder(borderSide: BorderSide()),
          labelText: AppLocalizations.of(context).translate(textKey),
          labelStyle: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.green,
              width: 2.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.blueGrey,
              width: 2.5,
            ),
          )),
    );
  }
}
