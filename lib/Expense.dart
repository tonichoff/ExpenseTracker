class Expense {
  int _id;
  String _description;
  double _price;
  DateTime _dateTime;

  int get id => _id;
  String get description => _description;
  double get price => _price;
  DateTime get date => _dateTime;

  Expense(this._id, this._description, this._price, this._dateTime);
}