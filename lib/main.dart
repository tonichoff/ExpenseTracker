import 'package:flutter/material.dart';

import 'package:expense_tracker/AddExpenseDialog.dart';
import 'package:expense_tracker/ExpenseListWidget.dart';
import 'package:expense_tracker/StatisticPage.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
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

  ExpenseListWidget list = ExpenseListWidget();

  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(length: 2, child: Scaffold(
        appBar: AppBar(
          title: const Text('Главная страница'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.list),
              ),
              Tab(
                icon: Icon(Icons.analytics),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: list,
            ),
            Center(
              child: StatisticPage()
            ),
          ],
        ),
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
    )
      );
  }
}
