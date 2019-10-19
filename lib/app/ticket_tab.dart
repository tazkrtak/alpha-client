import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../blocs/counter_bloc/bloc.dart';
import '../blocs/qr_bloc/bloc.dart';
import '../blocs/timer_bloc/bloc.dart';
import '../models/user.dart';
import '../util/app_localizations.dart';
import '../widgets/counter.dart';
import '../widgets/qr_container.dart';

class TicketTab extends StatefulWidget {
  final User _user;

  TicketTab(this._user);

  @override
  _TicketTabState createState() => _TicketTabState();
}

class _TicketTabState extends State<TicketTab> {
  double _total;
  QrBloc _qrBloc;
  QuantityBloc _quantityBloc;
  FeesBloc _feesBloc;
  TimerBloc _timerBloc;

  @override
  void initState() {
    super.initState();
    _qrBloc = BlocProvider.of<QrBloc>(context);
    _timerBloc = BlocProvider.of<TimerBloc>(context);
    _quantityBloc = BlocProvider.of<QuantityBloc>(context);
    _feesBloc = BlocProvider.of<FeesBloc>(context);
    _dispatchQrEvent();
    _updateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TimerBloc, int>(
          listener: (context, state) {
            if (state == 0) {
              _timerBloc.dispatch(TimerEvent.Reset);
              _dispatchQrEvent();
            }
          },
        ),
        BlocListener<QuantityBloc, int>(
          listener: (context, state) {
            _dispatchQrEvent(quantity: state);
            _updateTotal();
          },
        ),
        BlocListener<FeesBloc, double>(
          listener: (context, state) {
            _dispatchQrEvent(fees: state);
            _updateTotal();
          },
        ),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          BlocBuilder<QrBloc, String>(
            builder: (context, state) => QrContainer(
              data: state,
            ),
          ),
          BlocBuilder<TimerBloc, int>(
            builder: (context, state) => LinearPercentIndicator(
              width: 100,
              lineHeight: 10,
              percent: state * (1 / _timerBloc.resetDuration),
              alignment: MainAxisAlignment.center,
              addAutomaticKeepAlive: false,
              backgroundColor: Colors.greenAccent,
              progressColor: Colors.green,
              center: Text(
                '$state',
                style: TextStyle(fontSize: 8),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          BlocBuilder<QuantityBloc, int>(
            builder: (context, state) => Counter(
                titleKey: 'quantity',
                value: state,
                onIncrement: _isNextTotalValid(
                        nextQuantity:
                            _quantityBloc.currentState + QuantityBloc.step)
                    ? () => _quantityBloc.dispatch(CounterEvent.increment)
                    : null,
                onDecrement: () =>
                    _quantityBloc.dispatch(CounterEvent.decrement)),
          ),
          SizedBox(
            height: 8,
          ),
          BlocBuilder<FeesBloc, double>(
            builder: (context, state) => Counter(
                titleKey: 'fees',
                value: state,
                onIncrement: _isNextTotalValid(
                        nextFees: _feesBloc.currentState + FeesBloc.step)
                    ? () => _feesBloc.dispatch(CounterEvent.increment)
                    : null,
                onDecrement: () => _feesBloc.dispatch(CounterEvent.decrement)),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            '$_total',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(AppLocalizations.of(context).translate("currency"))
        ],
      ),
    );
  }

  void _dispatchQrEvent({int quantity, double fees}) {
    _qrBloc.dispatch(QrEvent(
      id: widget._user.nationalId,
      secret: widget._user.secret,
      quantity: quantity ?? _quantityBloc.currentState,
      fees: fees ?? _feesBloc.currentState,
    ));
  }

  void _updateTotal() {
    setState(() {
      _total = _quantityBloc.currentState * _feesBloc.currentState;
    });
  }

  bool _isNextTotalValid({int nextQuantity, double nextFees}) {
    double nextTotal = (nextQuantity ?? _quantityBloc.currentState) *
        (nextFees ?? _feesBloc.currentState);
    return nextTotal <= widget._user.balance;
  }
}
