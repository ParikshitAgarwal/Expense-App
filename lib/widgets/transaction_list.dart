import 'package:flutter/material.dart';

import 'package:expense_app/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;

  TransactionList({
    Key? key,
    required this.transactionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = transactionList[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              title: Text(
                item.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    transactionList[index].amount.toStringAsFixed(0) + " Rs",
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
              subtitle: Text(DateFormat.yMMMMd().format(item.date),
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
            ),
          ),
        );
      },
      itemCount: transactionList.length,
    );
  }
}
