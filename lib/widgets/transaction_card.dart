import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/locale_bloc/bloc.dart';
import '../models/transaction.dart';
import '../util/app_localizations.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  TransactionCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    var id = transaction.id;
    var issuer = transaction.issuer;
    var amount = transaction.amount;

    var locale = BlocProvider.of<LocaleBloc>(context).locale;

    var numberFormatter = NumberFormat("###.##", locale);
    var amountRounded = numberFormatter.format(amount);

    var dateTime = transaction.timestamp.toDate();
    var month = DateFormat.MMM(locale).format(dateTime);
    var day = DateFormat.d(locale).format(dateTime);
    var date = DateFormat.yMd(locale).format(dateTime);
    var time = DateFormat.jms(locale).format(dateTime);

    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: id));
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
                AppLocalizations.of(context).translate("transaction_copied")),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(1.2, 2.4),
              color: Colors.black12,
              blurRadius: .64,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FittedBox(
                    alignment: AlignmentDirectional.centerStart,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "$month".toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    "$day",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48,
              width: 48,
              child: Center(
                child: VerticalDivider(
                  thickness: .5,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$issuer",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle.color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "$date",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subhead.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "$time",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subhead.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: LimitedBox(
                  maxHeight: 24,
                  child: Text(
                    amount.isNegative ? "$amountRounded" : "+$amountRounded",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: amount.isNegative
                          ? Theme.of(context).errorColor
                          : Colors.green,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
