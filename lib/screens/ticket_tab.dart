import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../blocs/counter_bloc/bloc.dart';
import '../blocs/language_bloc/language_bloc.dart';
import '../blocs/qr_bloc/bloc.dart';
import '../blocs/timer_bloc/bloc.dart';
import '../models/ticket.dart';
import '../models/user.dart';
import '../util/app_localizations.dart';
import '../util/totp.dart';
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
  TimerBloc _timerBloc;
  QuantityBloc _quantityBloc;
  FeesBloc _feesBloc;

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
      child: SingleChildScrollView(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16),
            BlocBuilder<QrBloc, String>(
              builder: (context, state) => QrContainer(
                data: state,
              ),
            ),
            SizedBox(height: 16),
            BlocBuilder<TimerBloc, int>(
              builder: (context, state) => LinearPercentIndicator(
                width: 100,
                lineHeight: 14,
                percent: state * (1 / _timerBloc.resetInterval),
                alignment: MainAxisAlignment.center,
                addAutomaticKeepAlive: false,
                backgroundColor: Theme.of(context).primaryColorLight,
                progressColor: Theme.of(context).primaryColor,
                center: Text(
                  NumberFormat(
                          '##',
                          BlocProvider.of<LanguageBloc>(context)
                              .currentState
                              .locale
                              .toString())
                      .format(state)
                      .toString(),
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 16),
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
                    _quantityBloc.dispatch(CounterEvent.decrement),
              ),
            ),
            SizedBox(height: 16.0),
            BlocBuilder<FeesBloc, double>(
              builder: (context, state) => Counter(
                titleKey: 'fees',
                value: state,
                onIncrement: _isNextTotalValid(
                        nextFees: _feesBloc.currentState + FeesBloc.step)
                    ? () => _feesBloc.dispatch(CounterEvent.increment)
                    : null,
                onDecrement: () => _feesBloc.dispatch(CounterEvent.decrement),
              ),
            ),
            SizedBox(height: 16),
            Text(
              NumberFormat(
                      '##.##',
                      BlocProvider.of<LanguageBloc>(context)
                          .currentState
                          .locale
                          .toString())
                  .format(_total),
              style: TextStyle(
                color: Theme.of(context).textTheme.title.color,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              AppLocalizations.of(context).translate("currency"),
            )
          ],
        ),
      ),
    );
  }

  void _dispatchQrEvent({int quantity, double fees}) {
    _qrBloc.dispatch(
      QrEvent(
        Ticket(
          id: widget._user.nationalId,
          totp: TOTP.generateCode(widget._user.secret),
          quantity: quantity ?? _quantityBloc.currentState,
          fees: fees ?? _feesBloc.currentState,
        ),
      ),
    );
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
