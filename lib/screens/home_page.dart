import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    Transaction("t1", "New Shoes", 3000, DateTime.now()),
    Transaction("t2", "Weekly Groceries", 500, DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return transactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(Duration(days: DateTime.now().day)),
      );
    }).toList();
  }

  double get totalSpending {
    return _recentTransactions.fold(0, (sum, item) {
      return sum + (item.amount);
    });
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    setState(() {
      transactions.add(Transaction("1", txTitle, txAmount, chosenDate));
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              child: NewTransaction(addTransaction: _addNewTransaction),
              onTap: () {},
              behavior: HitTestBehavior.opaque);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Home",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.notifications_outlined,
                      size: 32,
                    )
                  ],
                ),
              ),

              SizedBox(
                height: isLandscape ? 0 : 20,
              ),
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "This month spending",
                  style: TextStyle(fontSize: 14, color: Color(0xfffA4A5A7)),
                ),
              )),
              Center(
                  child: Text(
                "Rs " + totalSpending.toStringAsFixed(0),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              )),

              SizedBox(
                height: isLandscape ? 0 : 20,
              ),
              Container(
                  height: isLandscape
                      ? MediaQuery.of(context).size.height * 0.5
                      : MediaQuery.of(context).size.height * 0.25,
                  child: Chart(recentTransactions: _recentTransactions)),

              const SizedBox(
                height: 20,
              ),

              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "This Week Transaction",
                  style: TextStyle(color: Color(0xfffA4A5A7)),
                ),
              ),
              // Column(
              //   children: transactions.map((transaction) {
              //     return Card(child: Text(transaction.item));
              //   }).toList(),
              // ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: TransactionList(transactionList: transactions))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
