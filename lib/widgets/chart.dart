import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double sum = recentTransactions.fold(0, (value, element) {
        if (element.created.day == weekDay.day &&
            element.created.month == weekDay.month &&
            element.created.year == weekDay.year) {
          return value += element.amount;
        }
        return 0;
      });
      return {'day': DateFormat.E().format(weekDay), 'amount': sum};
    });
  }

  Chart(this.recentTransactions);

  double get maxSpending {
    return groupedTransactions.fold(0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions
              .map(
                (e) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    e['day'],
                    e['amount'],
                    maxSpending == 0
                        ? 0.0
                        : ((e['amount'] as double) / maxSpending),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
