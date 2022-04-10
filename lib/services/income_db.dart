//add Expenses
import 'package:umnofto/models/income.dart';
import 'package:umnofto/services/database.dart';

Future<Income> addIncome(Income incomes) async {
  final db = await UmnotfoDatabase.instance.database;
  final id = await db.insert(tableIncome, incomes.toJson());
  return incomes.copy(id: id);
}

//read Expense
Future<Income> getIncome(int id) async {
  final db = await UmnotfoDatabase.instance.database;
  final maps = await db.query(tableIncome,
      columns: IncomeFields.values,
      where: '${IncomeFields.id} = ?',
      whereArgs: [id],
      orderBy: IncomeFields.createdAt);

  if (maps.isNotEmpty) {
    return Income.fromJson(maps.first);
  } else {
    throw Exception('ID $id is not available');
  }
}

//read All Expenses
Future<List<Income>> getIncomes() async {
  final db = await UmnotfoDatabase.instance.database;
  final result = await db.query(tableIncome);
  return result.map((json) => Income.fromJson(json)).toList();
}

//update Expense
Future<int> updateIncome(Income incomes) async {
  final db = await UmnotfoDatabase.instance.database;

  return db.update(tableIncome, incomes.toJson(),
      where: '${IncomeFields.id} = ?', whereArgs: [incomes.id]);
}

//delete Expenses
Future<int> deleteIncome(int id) async {
  final db = await UmnotfoDatabase.instance.database;
  return await db
      .delete(tableIncome, where: '${IncomeFields.id} = ?', whereArgs: [id]);
}
