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
  @override
  Widget build(BuildContext context) {
    var db = new ExpenseDataBase();
    if (db.expensesCount != 0) {
      return new Scaffold(
        body: ListView.separated(
          itemBuilder: (context, index) {
            return ExpenseWidget(db.get(index));
          },
          separatorBuilder: (context, index) => Divider(thickness: 10),
          itemCount: db.expensesCount,
        ),
      );
    } else {
      return Center(
          child: Column(
            children: [
              Text("Здесь пока пусто."),
              Text("Добавьте свои расходы в меню справа.")
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
      ); Text("Здесь пока пусто.");
    }
  }
}