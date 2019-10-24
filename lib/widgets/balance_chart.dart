import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:intl/intl.dart';

import '../blocs/language_bloc/bloc.dart';

class BalanceChart extends StatelessWidget {
  static const double _SIZE = 240;

  final double current;
  final double withdrawn;

  BalanceChart({this.current, this.withdrawn});

  @override
  Widget build(BuildContext context) {
    return AnimatedCircularChart(
        size: Size(_SIZE, _SIZE),
        initialChartData: <CircularStackEntry>[
          CircularStackEntry(
            <CircularSegmentEntry>[
              CircularSegmentEntry(
                withdrawn * (1 / current + withdrawn),
                Theme.of(context).errorColor,
                rankKey: 'withdrawn',
              ),
              CircularSegmentEntry(
                current * (1 / current + withdrawn),
                Theme.of(context).accentColor,
                rankKey: 'current',
              ),
            ],
            rankKey: 'balance',
          ),
        ],
        chartType: CircularChartType.Radial,
        holeLabel: NumberFormat(
                '######.##',
                BlocProvider.of<LanguageBloc>(context)
                    .currentState
                    .locale
                    .toString())
            .format(current)
            .toString(),
        labelStyle: Theme.of(context).textTheme.display1);
  }
}
