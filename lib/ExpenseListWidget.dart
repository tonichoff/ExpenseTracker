import 'package:expense_tracker/ExpenseDataBase.dart';
import 'package:expense_tracker/ExpenseWidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpenseListWidget extends StatefulWidget {
  ExpenseListWidget({Key key}) : super(key: key);

  @override
  _ExpenseListWidgetState createState() => _ExpenseListWidgetState();
}

class _ExpenseListWidgetState extends State<ExpenseListWidget> {
  ExpenseDataBase _db = new ExpenseDataBase();

  _ExpenseListWidgetState() {
    _db.updateDB().then((value) => setState(() {}));
  }

  void _update() {
    _db.updateDB().then((value) => setState(() {}));
    debugPrint("List Updated");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Build list");
    if (_db.expensesCount != 0) {
      return Scaffold(
        body: ListView.separated(
          itemBuilder: (context, index) {
            var expense = _db.get(index);
            debugPrint(expense.description);
            return ExpenseWidget(expense, _update);
          },
          separatorBuilder: (context, index) => Divider(thickness: 0),
          itemCount: _db.expensesCount,
            padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 56)
        ),
      );
    } else {
      return Center(
          child: Column(
            children: [
              Text("У вас пока нет расходов."),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
      );
    }
  }
}