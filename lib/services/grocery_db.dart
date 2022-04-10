import 'package:umnofto/models/grocery.dart';
import 'package:umnofto/services/database.dart';

//add Expenses
Future<Grocery> addGrocer(Grocery groceries) async {
  final db = await UmnotfoDatabase.instance.database;
  final id = await db.insert(tableGrocery, groceries.toJson());
  return groceries.copy(id: id);
}

//read Expense
Future<Grocery> getGrocery(int id) async {
  final db = await UmnotfoDatabase.instance.database;
  final maps = await db.query(tableGrocery,
      columns: GroceryFields.values,
      where: '${GroceryFields.id} = ?',
      whereArgs: [id]);

  if (maps.isNotEmpty) {
    return Grocery.fromJson(maps.first);
  } else {
    throw Exception('ID $id is not available');
  }
}

//read All Expenses
Future<List<Grocery>> getGroceries() async {
  final db = await UmnotfoDatabase.instance.database;
  final result = await db.query(tableGrocery);
  return result.map((json) => Grocery.fromJson(json)).toList();
}

//update Expense
Future<int> updateGrocer(Grocery grocery, int id) async {
  final db = await UmnotfoDatabase.instance.database;

  return db.update(tableGrocery, grocery.toJson(),
      where: '${GroceryFields.id} = ?', whereArgs: [grocery.id]);
}

//delete Expenses
Future<int> deleteGrocer(int id) async {
  final db = await UmnotfoDatabase.instance.database;
  return await db
      .delete(tableGrocery, where: '${GroceryFields.id} = ?', whereArgs: [id]);
}
