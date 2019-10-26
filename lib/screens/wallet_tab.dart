import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/balance_bloc/bloc.dart';
import '../blocs/transactions_bloc/bloc.dart';
import '../models/user.dart';
import '../widgets/balance_chart.dart';
import '../widgets/balance_dialog.dart';
import '../widgets/modal_sheet.dart';
import '../widgets/transaction_card.dart';
import 'account_screen.dart';

class WalletTab extends StatefulWidget {
  final User _user;

  WalletTab(this._user);

  @override
  _WalletTabState createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  BalanceBloc _balanceBloc;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _balanceBloc = BlocProvider.of<BalanceBloc>(context);
  }

  void _updateChart({double withdrawn, double current}) {
    setState(() {
      BalanceChart.chartKey.currentState.updateData(
        BalanceChart.generateData(
          context: context,
          withdrawn: withdrawn,
          current: current,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TransactionsBloc, TransactionsState>(
          listener: (context, state) {
            if (state is TransactionsLoaded) {
              _balanceBloc.dispatch(Update(state.transactions[0]));
            }
          },
        ),
        BlocListener<BalanceBloc, BalanceState>(
          listener: (context, state) {
            widget._user.balance = state.balance;
            widget._user.chargedBalance = state.chargedBalance;
            widget._user.lastTransactionId = state.lastTransactionId;
            _updateChart(
              withdrawn: state.chargedBalance - state.balance,
              current: state.balance,
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 16),
                BalanceChart(
                  current: widget._user.balance,
                  withdrawn: widget._user.chargedBalance,
                ),
                BlocBuilder<TransactionsBloc, TransactionsState>(
                  builder: (context, state) {
                    if (state is TransactionsLoaded) {
                      var transactions = state.transactions;
                      return ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: transactions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TransactionCard(transactions[index]);
                        },
                      );
                    } else if (state is TransactionLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).bottomAppBarColor,
          shape: CircularNotchedRectangle(),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).iconTheme.color,
                    size: 28,
                  ),
                  onPressed: _onModalButtonPressed,
                ),
                IconButton(
                  icon: Icon(
                    Icons.account_circle,
                    color: Theme.of(context).iconTheme.color,
                    size: 28,
                  ),
                  onPressed: _onAccountButtonPressed,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            color: Theme.of(context).primaryIconTheme.color,
            size: 28,
          ),
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return BalanceDialog(
                  amountController: _amountController,
                  onPressed: () {
                    _balanceBloc.dispatch(
                        Recharge(double.parse(_amountController.text)));
                    _amountController.clear();
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onAccountButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AccountScreen(widget._user)),
    );
  }

  void _onModalButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalSheet(),
    );
  }
}
