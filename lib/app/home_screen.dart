import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/counter_bloc/bloc.dart';
import 'account_tab.dart';
import 'ticket_tab.dart';

class HomeScreen extends StatefulWidget {
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
            BlocProvider<QuantityBloc>(
              builder: (BuildContext context) => QuantityBloc(),
            ),
            BlocProvider<FeesBloc>(
              builder: (BuildContext context) => FeesBloc(),
            ),
          ],
          child: TabBarView(
            children: <Widget>[
              TicketTab(),
              AccountTab(),
            ],
          ),
        ),
      ),
    );
  }
}
