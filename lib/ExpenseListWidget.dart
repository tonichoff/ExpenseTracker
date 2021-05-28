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

  @override
  Widget build(BuildContext context) {
    if (_db.expensesCount != 0) {
      return Scaffold(
        body: ListView.separated(
          itemBuilder: (context, index) {
            return ExpenseWidget(_db.get(index));
          },
          separatorBuilder: (context, index) => Divider(thickness: 0),
          itemCount: _db.expensesCount,
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
      ); Text("Здесь пока пусто.");
    }
  }
}