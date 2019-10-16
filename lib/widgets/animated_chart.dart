import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class AnimatedChart extends StatelessWidget {
  final double balance;
  final String withDraw;
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
  AnimatedChart({this.balance, this.withDraw});

  List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(10.0, Colors.red, rankKey: 'Q1'),
        new CircularSegmentEntry(90.0, Colors.yellowAccent, rankKey: 'Q2'),
      ],
      rankKey: 'User Balance',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedCircularChart(
      key: _chartKey,
      size: const Size(250.0, 250.0),
      initialChartData: data,
      chartType: CircularChartType.Radial,
      holeLabel: balance.toString() ,

      labelStyle:
          TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 48),
    );
  }
}
