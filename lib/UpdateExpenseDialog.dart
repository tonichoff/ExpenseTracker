import 'package:flutter/material.dart';

import 'package:expense_tracker/Expense.dart';

import 'ExpenseDataBase.dart';

class UpdateExpenseDialog extends StatefulWidget {
  Expense _expense;

  UpdateExpenseDialog(this._expense);

  @override
  State<StatefulWidget> createState() => UpdateExpenseDialogState(this._expense);
}

class UpdateExpenseDialogState extends State<UpdateExpenseDialog> {
  Expense _expense;
  final _formKey = GlobalKey<FormState>();

  String _description;
  double _price;

  UpdateExpenseDialogState(this._expense);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Редактирование"),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _expense.description,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'На что потратили?'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите что-нибудь :c';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value;
                  },
                ),
                TextFormField(
                  initialValue: _expense.price.toString(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Сколько потратили?'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите что-нибудь :c';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Введите число';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = double.tryParse(value);
                  },
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      var db = ExpenseDataBase();
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        db.updateExpense(new Expense(_expense.id, _description, _price, _expense.date)).then(
                                (value) => Navigator.pop(context)
                        );
                      }
                    },
                    child: Text('Изменить'),
                  ),
                )]
          ),
        ),
      ),
    );
  }
}