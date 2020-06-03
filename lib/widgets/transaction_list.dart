import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text('No transactions yet.'),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/waiting.png',
                  height: 200,
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                final tx = transactions[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${tx.amount}'),
                      ),
                    ),
                  ),
                  title: Text('${tx.title}'),
                  subtitle: Text('${DateFormat.yMMMd().format(tx.created)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.purple,
                      onPressed: () {},
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
