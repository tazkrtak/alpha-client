import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  TransactionCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    String issuer = transaction.issuer;

    DateTime dateTime = transaction.timestamp.toDate();
    String month = DateFormat("MMM").format(dateTime).toUpperCase();
    String day = DateFormat("dd").format(dateTime);
    String date = DateFormat("dd/MM/yyyy hh:mm a").format(dateTime);

    RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
    double amount = transaction.amount;
    String amountRounded = amount.toString().replaceAll(regex, "");

    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(1.2, 2.4),
            color: Colors.black12,
            blurRadius: 0.64,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "$month",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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
          SizedBox(
            height: 48,
            width: 32,
            child: Center(
              child: VerticalDivider(
                thickness: 0.5,
                color: Colors.blueGrey,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                child: Text(
                  "$issuer",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "$date",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              amount.isNegative ? "$amountRounded" : "+$amountRounded",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: amount.isNegative ? Colors.red : Colors.green,
                fontSize: 24,
              ),
            ),
          )
          /*  child: Text(
                amount.isNegative ? "$amountRounded" : "+$amountRounded",
                textAlign: TextAlign.right,
                style: amount.isNegative
                    ? TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 24)
                    : TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 24),
              ),*/
        ],
      ),
    );
  }
}
