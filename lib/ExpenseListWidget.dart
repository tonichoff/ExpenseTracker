import 'package:flutter/material.dart';

class ExpenseListWidget extends StatefulWidget {
  ExpenseListWidget({Key key}) : super(key: key);

  @override
  _ExpenseListWidgetState createState() => _ExpenseListWidgetState();
}

class _ExpenseListWidgetState extends State<ExpenseListWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Text("$index");
        },
        separatorBuilder: (context, index) => Divider(thickness: 10),
        itemCount: 10,
      ),
    );
  }
}