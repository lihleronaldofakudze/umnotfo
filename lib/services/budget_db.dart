//add Expenses
import 'package:umnofto/models/budget.dart';
import 'package:umnofto/services/database.dart';

Future<Budget> addBudget(Budget budgets) async {
  final db = await UmnotfoDatabase.instance.database;
  final id = await db.insert(tableBudget, budgets.toJson());
  return budgets.copy(id: id);
}

//read Expense
Future<Budget> getBudget(int id) async {
  final db = await UmnotfoDatabase.instance.database;
  final maps = await db.query(tableBudget,
      columns: BudgetFields.values,
      where: '${BudgetFields.id} = ?',
      whereArgs: [id]);

  if (maps.isNotEmpty) {
    return Budget.fromJson(maps.first);
  } else {
    throw Exception('ID $id is not available');
  }
}

//read All Expenses
Future<List<Budget>> getBudgets() async {
  final db = await UmnotfoDatabase.instance.database;
  final result = await db.query(tableBudget);
  return result.map((json) => Budget.fromJson(json)).toList();
}

//update Expense
Future<int> updateBudget(Budget budgets) async {
  final db = await UmnotfoDatabase.instance.database;

  return db.update(tableBudget, budgets.toJson(),
      where: '${BudgetFields.id} = ?', whereArgs: [budgets.id]);
}

//delete Expenses
Future<int> deleteBudget(int id) async {
  final db = await UmnotfoDatabase.instance.database;
  return await db
      .delete(tableBudget, where: '${BudgetFields.id} = ?', whereArgs: [id]);
}
