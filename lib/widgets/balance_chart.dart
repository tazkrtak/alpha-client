import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:intl/intl.dart';

import '../blocs/locale_bloc/bloc.dart';

class BalanceChart extends StatelessWidget {
  static const double _SIZE = 240;

  final double current;
  final double withdrawn;
  static final GlobalKey<AnimatedCircularChartState> chartKey =
      GlobalKey<AnimatedCircularChartState>();

  BalanceChart({this.current, this.withdrawn});

  @override
  Widget build(BuildContext context) {
    var locale = BlocProvider.of<LocaleBloc>(context).locale;
    var numberFormatter = NumberFormat("######.##", locale);

    return AnimatedCircularChart(
        size: Size(_SIZE, _SIZE),
        key: chartKey,
        initialChartData: generateData(
          context: context,
          withdrawn: withdrawn,
          current: current,
        ),
        chartType: CircularChartType.Radial,
        holeLabel: numberFormatter.format(current),
        labelStyle: Theme.of(context).textTheme.display1);
  }

  static List<CircularStackEntry> generateData({
    BuildContext context,
    double withdrawn,
    double current,
  }) {
    return <CircularStackEntry>[
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
    ];
  }
}
