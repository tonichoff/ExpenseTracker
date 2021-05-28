import 'package:expense_tracker/Expense.dart';
import 'package:expense_tracker/UpdateExpenseDialog.dart';
import 'ExpenseDataBase.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseWidget extends StatelessWidget {
  Expense _expense;
  Function _parentCallback;
  ExpenseDataBase _db = new ExpenseDataBase();

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
                      });
                    }
                ),
                TextButton(
                  child: const Text('Удалить'),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Вы уверены?"),
                          content: Row(
                              children: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      _db.removeAt(_expense.id)
                                          .then((value) => Navigator.pop(context))
                                          .then((value) => _parentCallback());
                                    },
                                    child: const Text('Да')
                                ),
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Нет')
                                )
                              ]
                          ),
                        );
                      }
                    );
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        )
    );
  }
}