import 'package:expense_tracker/Expense.dart';
import 'package:expense_tracker/UpdateExpenseDialog.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseWidget extends StatelessWidget {
  Expense _expense;
  Function _parentCallback;

  ExpenseWidget(this._expense, this._parentCallback);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text(_expense.description),
              subtitle: Text(DateFormat("dd-MM-yyyy HH:mm").format(_expense.date)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                    child: const Text('Изменить'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return UpdateExpenseDialog(_expense);
                          })
                      ).then((value) {
                        _parentCallback();
                        debugPrint("call callback Expense Widget");
                      });
                    }
                ),
                TextButton(
                  child: const Text('Удалить'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        )
    );
  }
}