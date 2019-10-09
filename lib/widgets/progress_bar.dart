import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  final int progress;

  ProgressBar(this.progress);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      width: MediaQuery.of(context).size.width - 70,
      animation: true,
      lineHeight: 40.0,
      animationDuration: 1500,
      percent: progress / 100,
      center: Text("$progress%", style: TextStyle(color: Colors.white)),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: Colors.green,
    );
  }
}
