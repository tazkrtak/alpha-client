import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

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
              Colors.red,
              rankKey: 'withdrawn',
            ),
            CircularSegmentEntry(
              current * (1 / current + withdrawn),
              Colors.yellowAccent,
              rankKey: 'current',
            ),
          ],
          rankKey: 'balance',
        ),
      ],
      chartType: CircularChartType.Radial,
      holeLabel: current.toString(),
      labelStyle: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
        fontSize: 48,
      ),
    );
  }
}
