import 'package:expense_tracker/AddExpenseDialog.dart';
import 'package:expense_tracker/ExpenseListWidget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Трекер расходов',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: 'Главная страница'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var list = ExpenseListWidget();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Главная страница'),
        ),
        body: list,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return AddExpenseDialog();
              })
          ).then((value) => setState(() {})).then((value) => list.update());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
