import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quiver/async.dart';

import '../blocs/counter_bloc/bloc.dart';
import '../models/user.dart';
import '../util/totp.dart';
import '../widgets/counter.dart';

class TicketTab extends StatefulWidget {
  final User _user;

  TicketTab(this._user);

  @override
  _TicketTabState createState() => _TicketTabState();
}

class _TicketTabState extends State<TicketTab> {
  String secret = 'lorem-ipsum';
  int _totp;
  int _counterStart = 30;
  int _counterCurrent = 30;

  void startTimer() {
    CountdownTimer countDownTimer = CountdownTimer(
      Duration(seconds: _counterStart),
      Duration(seconds: 1),
    );

    var countDownListener = countDownTimer.listen(null);

    countDownListener.onData((duration) {
      setState(() {
        _counterCurrent = _counterStart - duration.elapsed.inSeconds;
      });
    });

    countDownListener.onDone(() {
      setState(() {
        _totp = TOTP.generateTOTPCode(
            secret, DateTime.now().toUtc().millisecondsSinceEpoch);
      });
      startTimer();
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final QuantityBloc quantityBloc = BlocProvider.of<QuantityBloc>(context);
    final FeesBloc priceBloc = BlocProvider.of<FeesBloc>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 5.0,
              percent: _counterCurrent * (1 / 30),
              center: Icon(
                Icons.directions_bus,
                size: 30.0,
                color: Colors.green,
              ),
              backgroundColor: Colors.white,
              progressColor: Colors.yellow,
            ),
            QrImage(
              data: '$_totp',
              version: QrVersions.auto,
              size: 240,
              gapless: true,
              foregroundColor: Colors.green[700],
            ),
            BlocBuilder<QuantityBloc, int>(
              builder: (context, state) => Counter(
                titleKey: 'quantity',
                value: state,
                bloc: quantityBloc,
              ),
            ),
            BlocBuilder<FeesBloc, int>(
              builder: (context, state) => Counter(
                titleKey: 'fees',
                value: state,
                bloc: priceBloc,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
