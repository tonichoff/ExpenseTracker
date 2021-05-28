import 'package:flutter/material.dart';

import 'package:expense_tracker/Expense.dart';

class UpdateExpenseDialog extends StatefulWidget {
  Expense _expense;

  UpdateExpenseDialog(this._expense);

  @override
  State<StatefulWidget> createState() => UpdateExpenseDialogState(this._expense);
}

class UpdateExpenseDialogState extends State<UpdateExpenseDialog> {
  Expense _expense;

  UpdateExpenseDialogState(this._expense);

  @override
  Widget build(BuildContext context) {
    return Text("Update expense dialog");
  }
}