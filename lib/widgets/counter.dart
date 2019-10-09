import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../blocs/counter_bloc/bloc.dart';
import '../util/app_localizations.dart';

class Counter extends StatelessWidget {
  final String titleKey;
  final int value;
  final CounterBloc bloc;

  Counter({
    this.titleKey,
    this.value,
    this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate(titleKey),
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
                onPressed: () => bloc.dispatch(CounterEvent.decrement),
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 32)),
            Text(
              '$value',
              style: TextStyle(color: Colors.black87, fontSize: 24),
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
                onPressed: () => bloc.dispatch(CounterEvent.increment),
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
