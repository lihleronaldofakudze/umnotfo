//add Expenses
import 'package:umnofto/models/expenses.dart';
import 'package:umnofto/services/database.dart';

Future<Expenses> addExpenses(Expenses expenses) async {
  final db = await UmnotfoDatabase.instance.database;
  final id = await db.insert(tableExpenses, expenses.toJson());
  return expenses.copy(id: id);
}

//read Expense
Future<Expenses> getExpense(int id) async {
  final db = await UmnotfoDatabase.instance.database;
  final maps = await db.query(tableExpenses,
      columns: ExpensesFields.values,
      where: '${ExpensesFields.id} = ?',
      whereArgs: [id]);

  if (maps.isNotEmpty) {
    return Expenses.fromJson(maps.first);
  } else {
    throw Exception('ID $id is not available');
  }
}

//read All Expenses
Future<List<Expenses>> getExpenses() async {
  final db = await UmnotfoDatabase.instance.database;
  final result = await db.query(tableExpenses);
  return result.map((json) => Expenses.fromJson(json)).toList();
}

//update Expense
Future<int> updateExpense(Expenses expenses, id) async {
  final db = await UmnotfoDatabase.instance.database;

  return db.update(tableExpenses, expenses.toJson(),
      where: '${ExpensesFields.id} = ?', whereArgs: [expenses.id]);
}

//delete Expenses
Future<int> deleteExpense(int id) async {
  final db = await UmnotfoDatabase.instance.database;
  return await db.delete(tableExpenses,
      where: '${ExpensesFields.id} = ?', whereArgs: [id]);
}
