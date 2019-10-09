import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/app_localizations.dart';

class Counter extends StatefulWidget {
  final String titleKey;
  final int initialValue;

  Counter({
    this.titleKey,
    this.initialValue,
  });

  @override
  State<StatefulWidget> createState() {
    return _Counter();
  }
}

class _Counter extends State<Counter> {
  int _value;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  void _increment() {
    setState(() {
      _value++;
    });
  }

  void _decrement() {
    setState(() {
      if (_value > 1) {
        _value--;
      }
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate(widget.titleKey),
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              child: RawMaterialButton(
                fillColor: Colors.red,
                shape: CircleBorder(),
                elevation: 4,
                onPressed: _decrement,
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 32)),
            Text(
              _value.toString(),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 32),
            ),
            Container(
              width: 40,
              height: 40,
              child: RawMaterialButton(
                fillColor: Colors.green,
                shape: CircleBorder(),
                elevation: 4,
                onPressed: _increment,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
