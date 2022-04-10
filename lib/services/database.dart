import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:umnofto/models/budget.dart';
import 'package:umnofto/models/expenses.dart';
import 'package:umnofto/models/grocery.dart';
import 'package:umnofto/models/income.dart';

class UmnotfoDatabase {
  //create an instance
  static final UmnotfoDatabase instance = UmnotfoDatabase._init();

  static Database? _database;

  UmnotfoDatabase._init();

  //initialize a database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('umnofto.db');
    return _database!;
  }

  //save database to database paths
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //create database
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final doubleType = 'DOUBLE NOT NULL';

    //create table Transaction
    await db.execute('CREATE TABLE $tableExpenses ('
        '${ExpensesFields.id} $idType,'
        '${ExpensesFields.title} $textType,'
        '${ExpensesFields.category} $textType,'
        '${ExpensesFields.createdAt} $textType,'
        '${ExpensesFields.price} $doubleType'
        ')');

    await db.execute('CREATE TABLE $tableIncome ('
        '${IncomeFields.id} $idType,'
        '${IncomeFields.title} $textType,'
        '${IncomeFields.createdAt} $textType,'
        '${IncomeFields.price} $doubleType'
        ')');

    //create table Grocery
    await db.execute('CREATE TABLE $tableGrocery ('
        '${GroceryFields.id} $idType,'
        '${GroceryFields.item} $textType,'
        '${GroceryFields.price} $doubleType'
        ')');

    //create table Budget
    await db.execute('CREATE TABLE $tableBudget ('
        '${BudgetFields.id} $idType,'
        '${BudgetFields.description} $textType,'
        '${BudgetFields.price} $doubleType'
        ')');
  }

  //close database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
