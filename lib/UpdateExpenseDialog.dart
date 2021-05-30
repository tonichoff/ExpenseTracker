import 'package:flutter/material.dart';

import 'package:expense_tracker/Expense.dart';
import 'package:expense_tracker/ExpenseDataBase.dart';
import 'package:expense_tracker/ManipulationExpenseDialogState.dart';

class UpdateExpenseDialog extends StatefulWidget {
  Expense _expense;

  UpdateExpenseDialog(this._expense);

  @override
  State<StatefulWidget> createState() => ManipulationExpenseDialogState(
    'Изменить расход',
    this._expense,
    (String description, double price, Expense expense, BuildContext context) {
      var db = ExpenseDataBase();
      db.updateExpense(new Expense(expense.id, description, price, expense.date)).then(
        (value) => Navigator.pop(context)
      );
    },
    'Изменить'
  );
}
