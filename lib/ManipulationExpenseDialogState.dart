import 'package:flutter/material.dart';

import 'package:expense_tracker/Expense.dart';

class ManipulationExpenseDialogState extends State {
  final _formKey = GlobalKey<FormState>();

  String _title;
  Expense _expense;
  Function(String, double, Expense, BuildContext) _onChange;
  String _buttonLabel;

  String _description;
  double _price;

  ManipulationExpenseDialogState(this._title, this._expense, this._onChange, this._buttonLabel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _expense == null ? '' : _expense.description,
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
                  initialValue: _expense == null ? '' : _expense.price.toString(),
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
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        _onChange(_description, _price, _expense, context);
                      }
                    },
                    child: Text(_buttonLabel),
                  ),
                )]
          ),
        ),
      ),
    );
  }
}
