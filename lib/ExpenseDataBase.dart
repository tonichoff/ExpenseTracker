import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:expense_tracker/Expense.dart';

class ExpenseDataBase {
  Database _dataBase;
  List<Expense> _expenses = new List<Expense>();

  int get expensesCount => _expenses.length;

  Future<Database> get dataBase async {
    if (_dataBase == null) {
      _dataBase = await initializeDataBase();
    }
    return _dataBase;
  }

  initializeDataBase() async {
    var folder = await getApplicationDocumentsDirectory();
    var path = join(folder.path, "DataBase.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE Expenses (id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT, price REAL, date TEXT)"
        );
      }
    );
  }

  Future<List<Expense>> getAllExpenses() async {
    Database db = await dataBase;
    List<Map> query = await db.rawQuery("SELECT * FROM Expenses ORDER BY date DESC");
    var result = List<Expense>();
    query.forEach(
            (r) => result.add(
                Expense(
                    r["id"],
                    r["description"],
                    r["price"],
                    DateTime.parse(r["date"]),
                )
            )
    );
    return result;
  }

  Future<void> addExpense(Expense expense) async {
    var dateAsString = expense.date.toString();
    Database db = await dataBase;
    await db.rawInsert(
        "INSERT INTO Expenses (description, price, date) VALUES (\"${expense.description}\", ${expense.price}, \"$dateAsString\")"
    );
    await updateDB();
  }

  Expense get(int index) {
    return _expenses[index];
  }

  Future updateDB() async {
    _expenses = await getAllExpenses();
  }

  Future removeAt(int index) async {
    Database db = await dataBase;
    await db.rawDelete(
        "DELETE FROM Expenses WHERE id = \"$index\""
    );
    await updateDB();
  }

  Future updateExpense(Expense expense) async {
    Database db = await dataBase;
    await db.rawUpdate(
        "UPDATE Expenses SET description = \"${expense.description}\", price = \"${expense.price}\" WHERE id = \"${expense.id}\""
    );
    await updateDB();
  }

  int expensesCountInCurrentMonth() {
    var currentMonth = DateTime.now().month;
    var currentYear = DateTime.now().year;
    int count = 0;
    for (var expense in _expenses) {
      if (expense.date.month == currentMonth && expense.date.year == currentYear) {
        ++count;
      }
    }
    return count;
  }

  double expensesAmountInCurrentMonth() {
    var currentMonth = DateTime.now().month;
    var currentYear = DateTime.now().year;
    double amount = 0;
    for (var expense in _expenses) {
      if (expense.date.month == currentMonth && expense.date.year == currentYear) {
        amount += expense.price;
      }
    }
    return amount;
  }
}