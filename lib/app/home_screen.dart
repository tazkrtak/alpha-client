import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/counter_bloc/bloc.dart';
import '../blocs/qr_bloc/bloc.dart';
import '../blocs/timer_bloc/bloc.dart';
import '../models/user.dart';
import '../util/ticker.dart';
import '../util/totp.dart';
import 'account_tab.dart';
import 'ticket_tab.dart';

class HomeScreen extends StatefulWidget {
  final User _user;

  HomeScreen(this._user);

  @override
  _Main createState() => _Main();
}

class _Main extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          flexibleSpace: SafeArea(
            child: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.white,
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
                  TimerBloc(Ticker(), TOTP.VALID_DURATION)
                    ..dispatch(StartEvent(TOTP.expiresIn)),
            ),
            BlocProvider<QuantityBloc>(
              builder: (BuildContext context) => QuantityBloc(),
            ),
            BlocProvider<FeesBloc>(
              builder: (BuildContext context) => FeesBloc(),
            ),
          ],
          child: TabBarView(
            children: <Widget>[
              TicketTab(widget._user),
              AccountTab(widget._user),
            ],
          ),
        ),
      ),
    );
  }
}
