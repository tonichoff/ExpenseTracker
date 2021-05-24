import 'package:expense_tracker/Expense.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ExpenseDataBase {
  static ExpenseDataBase _instance;
  Database _dataBase;
  List<Expense> _expenses = new List<Expense>();

  int get expensesCount => _expenses.length;

  static Future<ExpenseDataBase> get instance async {
    if (_instance == null) {
      _instance = new ExpenseDataBase();
    }
    return _instance;
  }

  ExpenseDataBase() {
    _dataBase = initializeDataBase();
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
    List<Map> query = await _dataBase.rawQuery("SELECT * FROM Expenses ORDER BY date DESC");
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
    await _dataBase.rawInsert(
        "INSERT INTO Expenses (description, price, date) VALUES (\"${expense.description}\", \"$dateAsString\", ${expense.price})"
    );
    await updateDB();
  }

  Expense get(int index) {
    return _expenses[index];
  }

  Future updateDB() async {
    _expenses = await getAllExpenses();
  }

  void removeAt(int index) async {
    await _dataBase.rawDelete(
        "DELETE FROM Expenses WHERE id = \"$index\""
    );
    await updateDB();
  }

  void updateExpense(Expense expense) async {
    var dateAsString = expense.date.toString();
    await _dataBase.rawUpdate(
        "UPDATE Expenses SET description = \"${expense.description}\", price = \"${expense.price}\", date = \"$dateAsString\""
    );
    await updateDB();
  }
}