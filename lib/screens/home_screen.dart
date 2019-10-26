import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/counter_bloc/bloc.dart';
import '../blocs/qr_bloc/bloc.dart';
import '../blocs/timer_bloc/bloc.dart';
import '../blocs/transactions_bloc/bloc.dart';
import '../blocs/balance_bloc/bloc.dart';
import '../models/user.dart';
import '../util/totp.dart';
import 'ticket_tab.dart';
import 'wallet_tab.dart';

class HomeScreen extends StatefulWidget {
  final User _user;

  HomeScreen(this._user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          textTheme: Theme.of(context).appBarTheme.textTheme,
          backgroundColor: Theme.of(context).appBarTheme.color,
          flexibleSpace: SafeArea(
            child: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.confirmation_number,
                    color: Theme.of(context).appBarTheme.iconTheme.color,
                    size: 32,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.account_balance_wallet,
                    color: Theme.of(context).appBarTheme.iconTheme.color,
                    size: 32,
                  ),
                )
              ],
            ),
          ),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<QrBloc>(
              builder: (BuildContext context) => QrBloc(),
            ),
            BlocProvider<TimerBloc>(
              builder: (BuildContext context) =>
                  TimerBloc(TOTP.INTERVAL)..dispatch(Start(TOTP.expiresIn)),
            ),
            BlocProvider<QuantityBloc>(
              builder: (BuildContext context) => QuantityBloc(),
            ),
            BlocProvider<FeesBloc>(
              builder: (BuildContext context) => FeesBloc(),
            ),
            BlocProvider<TransactionsBloc>(
              builder: (BuildContext context) =>
                  TransactionsBloc(widget._user)..dispatch(LoadTransactions()),
            ),
            BlocProvider<BalanceBloc>(
                builder: (BuildContext context) => BalanceBloc(widget._user)),
          ],
          child: TabBarView(
            children: <Widget>[
              TicketTab(widget._user),
              WalletTab(widget._user),
            ],
          ),
        ),
      ),
    );
  }
}
