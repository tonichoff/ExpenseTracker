import 'package:expense_tracker/Expense.dart';
import 'package:expense_tracker/UpdateExpenseDialog.dart';

import 'package:flutter/material.dart';

class ExpenseWidget extends StatefulWidget {
  Expense _expense;

  ExpenseWidget(this._expense);

  @override
  State<StatefulWidget> createState() => _ExpenseWidgetState(this._expense);
}

class _ExpenseWidgetState extends State<ExpenseWidget> {
  Expense _expense;

  _ExpenseWidgetState(this._expense);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Row(
          children: [
            ListTile(
              title: Text("${_expense.description}"),
              leading: Icon(
                Icons.attach_money,
                color: Colors.blue[500],
              ),
            ),
            Divider(),
            ListTile(
              title: Text("${_expense.price}"),
              subtitle: Text("${_expense.date.toString()}"),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return UpdateExpenseDialog();
            })
        ).then((value) => setState(() {}));
      },
    );
  }
}