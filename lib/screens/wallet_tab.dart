import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/transactions_bloc/bloc.dart';
import '../models/user.dart';
import '../widgets/balance_chart.dart';
import '../widgets/modal_sheet.dart';
import '../widgets/transaction_card.dart';
import '../widgets/balance_dialog.dart';
import 'account_screen.dart';

class WalletTab extends StatefulWidget {
  final User _user;

  WalletTab(this._user);

  @override
  _WalletTabState createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 8),
                BalanceChart(current: 40, withdrawn: 10),
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
      ),
      bottomNavigationBar: BottomAppBar(
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
                  color: Colors.blueGrey,
                  size: 28,
                ),
                onPressed: _onModalButtonPressed,
              ),
              IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.blueGrey,
                  size: 28,
                ),
                onPressed: _onAccountButtonPressed,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
        onPressed: () {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return BalanceDialog(
                  onPressed: () => Navigator.of(context).pop(),
                );
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
