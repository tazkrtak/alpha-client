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
              color: Theme.of(context).textTheme.body2.color,
              fontSize: 18,
              fontWeight: FontWeight.w600),
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
                  fillColor: Theme.of(context).errorColor,
                  shape: CircleBorder(),
                  elevation: 2,
                  onPressed: onDecrement,
                  child: Icon(
                    Icons.remove,
                    color: Theme.of(context).primaryIconTheme.color,
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
                      color: Theme.of(context).textTheme.body1.color,
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
                  elevation: 2,
                  onPressed: onIncrement,
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryIconTheme.color,
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
