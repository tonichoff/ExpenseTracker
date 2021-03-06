import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:expense_tracker/ExpenseDataBase.dart';
import 'package:expense_tracker/ExpenseWidget.dart';

class ExpenseListWidget extends StatefulWidget {
  ExpenseListWidget({Key key}) : super(key: key);

  _ExpenseListWidgetState state;

  @override
  _ExpenseListWidgetState createState() {
    state = _ExpenseListWidgetState();
    return state;
  }

  void update() {
    state.update();
  }
}

class _ExpenseListWidgetState extends State<ExpenseListWidget> {
  ExpenseDataBase _db = new ExpenseDataBase();

  _ExpenseListWidgetState() {
    _db.updateDB().then((value) => setState(() {}));
  }

  void update() {
    _db.updateDB().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if (_db.expensesCount != 0) {
      return Center(
          child: Scaffold(
            body: ListView.separated(
                itemBuilder: (context, index) {
                  var expense = _db.get(index);
                  return ExpenseWidget(expense, update);
                  },
                separatorBuilder: (context, index) => Divider(thickness: 0),
                itemCount: _db.expensesCount,
                padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 56)
            ),
          )
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