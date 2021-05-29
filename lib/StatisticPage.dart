import 'package:flutter/material.dart';

import 'ExpenseDataBase.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key key}) : super(key: key);

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  ExpenseDataBase _db = ExpenseDataBase();

  _StatisticPageState() {
    _db.updateDB().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    double monthAmount = _db.expensesAmountInCurrentMonth();
    int monthCount = _db.expensesCountInCurrentMonth();
    return Center(
      child: Column(
        children: [
          Text("Количество покупок в этом месяце: $monthCount"),
          Text("Сумма затрат в этом месяце: $monthAmount")
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      )
    );
  }
}
