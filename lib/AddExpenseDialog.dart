import 'package:flutter/material.dart';

import 'package:expense_tracker/Expense.dart';
import 'package:expense_tracker/ExpenseDataBase.dart';
import 'package:expense_tracker/ManipulationExpenseDialogState.dart';

class AddExpenseDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ManipulationExpenseDialogState(
    'Новые расходы',
    null,
    (String description, double price, Expense expense, BuildContext context) {
      var db = ExpenseDataBase();
      var dateTime = DateTime.now();
      db.addExpense(new Expense.withoutId(description, price, dateTime)).then(
        (value) => Navigator.pop(context)
      );
    },
    'Добавить'
  );
}
