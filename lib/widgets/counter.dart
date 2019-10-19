import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holding_gesture/holding_gesture.dart';

import '../util/app_localizations.dart';

class Counter extends StatelessWidget {
  final String titleKey;
  final num value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  Counter({
    this.titleKey,
    this.value,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate(titleKey),
          style: TextStyle(
            color: Colors.black87.withOpacity(0.64),
            fontSize: 18,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              child: HoldDetector(
                onHold: onDecrement ?? () => {},
                holdTimeout: Duration(milliseconds: 200),
                child: RawMaterialButton(
                  fillColor: Colors.red,
                  shape: CircleBorder(),
                  elevation: 4,
                  onPressed: onDecrement,
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 32)),
            Container(
                width: 48,
                child: Center(
                  child: Text(
                    '$value',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(right: 32),
            ),
            Container(
              width: 32,
              height: 32,
              child: HoldDetector(
                onHold: onIncrement ?? () => {},
                holdTimeout: Duration(milliseconds: 200),
                child: RawMaterialButton(
                  fillColor: Colors.green,
                  shape: CircleBorder(),
                  elevation: 4,
                  onPressed: onIncrement,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
