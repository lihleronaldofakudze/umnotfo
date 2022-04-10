import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:umnofto/models/expenses.dart';
import 'package:umnofto/screens/add_expenses_screen.dart';
import 'package:umnofto/services/expenses_db.dart';
import 'package:umnofto/widgets/loading.dart';

import 'category_color.dart';
import 'expenses_chart.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({Key? key}) : super(key: key);

  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  late List<Expenses> _expenses;
  bool _loading = false;

  void _refreshData() async {
    setState(() {
      _loading = true;
    });
    _expenses = await getExpenses();

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : _expenses.length == 0
            ? Center(
                child: ElevatedButton(
                  onPressed: () => _refreshData(),
                  child: Text('Refresh List'),
                ),
              )
            : RefreshIndicator(
                onRefresh: () async => _refreshData(),
                child: Column(
                  children: [
                    ExpensesChart(expenses: _expenses),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _expenses.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text('Edit Expenses'),
                                        content: ListTile(
                                          title: Text(_expenses[index].title),
                                          subtitle: Text(
                                              '${_expenses[index].category} - ${DateFormat.yMd().format(_expenses[index].createdAt)}'),
                                          trailing: Text(
                                              '-E${_expenses[index].price.toDouble().toString()}'),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              )),
                                          TextButton(
                                              onPressed: () async {
                                                await deleteExpense(
                                                        _expenses[index].id!)
                                                    .then((value) {
                                                  Navigator.pop(context);
                                                  _refreshData();
                                                });
                                              },
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddExpensesScreen(
                                                            expenseId:
                                                                _expenses[index]
                                                                    .id,
                                                          )),
                                                );
                                              },
                                              child: Text(
                                                'Change',
                                                style: TextStyle(
                                                    color: Colors.orange),
                                              ))
                                        ],
                                      ));
                            },
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: getCategoryColor(
                                          _expenses[index].category),
                                      width: 2.0),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0)
                                  ]),
                              child: ListTile(
                                title: Text(_expenses[index].title),
                                subtitle: Text(
                                    '${_expenses[index].category} - ${DateFormat.yMd().format(_expenses[index].createdAt)}'),
                                trailing: Text(
                                    '-E${_expenses[index].price.toDouble().toString()}'),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
  }
}
