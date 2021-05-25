import 'package:expense_tracker/Expense.dart';
import 'package:expense_tracker/ExpenseDataBase.dart';
import 'package:flutter/material.dart';

class AddExpenseDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddExpenseDialogState();
}

class AddExpenseDialogState extends State<AddExpenseDialog> {
  final _formKey = GlobalKey<FormState>();

  String _description;
  double _price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Новые расходы"),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: <Widget>[
                TextFormField(
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
                        var dateTime = DateTime.now();
                        db.addExpense(new Expense.withoutId(_description, _price, dateTime)).then(
                                (value) => Navigator.pop(context)
                        );
                      }
                    },
                    child: Text('Добавить'),
                  ),
                )]
            ),
            ),
          ),
    );
  }
}