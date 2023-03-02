import 'package:first/models/transactions_model.dart';
import 'package:first/screens/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.trList});
  final List<Transactionsmodel> trList;
  List<Map<String, Object>> get calculateDay {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i = 0; i < trList.length; i++) {
        var calc = trList[i];
        if (calc.dateTime.day == weekDay.day &&
            calc.dateTime.month == weekDay.month &&
            calc.dateTime.year == weekDay.year) {
          totalSum += calc.amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1).toString(),
        "amount": totalSum.toStringAsFixed(2)
      };
    });
  }

  double get totalSpending {
    return calculateDay.fold(0.0, (sum, item) {
      return sum + double.parse(item['amount'] as String);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(calculateDay);
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: calculateDay.map((data) {
        return ChartBar(
          label: "${data['day']}",
          spendingAmount: double.parse(data["amount"] as String),
          spendingPctOfTotal: totalSpending == 0.0
              ? 0.0
              : double.parse(data["amount"] as String) / totalSpending,
        );
      }).toList(),
    ));
  }
}
