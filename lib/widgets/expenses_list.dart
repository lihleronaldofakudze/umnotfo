import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:umnofto/models/expenses.dart';
import 'package:umnofto/services/database.dart';
import 'package:umnofto/widgets/category_color.dart';
import 'package:umnofto/widgets/expenses_chart.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({Key? key}) : super(key: key);

  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    List<Expenses> expenses = [];

    void asyncMethod() async {
      setState(() async {
        expenses = await UmnotfoDatabase.instance.getExpenses();
      });
    }

    @override
    initState() {
      super.initState();
      asyncMethod();
    }

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        if (index == 0) return ExpensesChart(expenses: expenses);
        return Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(
                  color: getCategoryColor(expenses[index].category),
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
            title: Text(expenses[index].title),
            subtitle: Text(
                '${expenses[index].category} - ${DateFormat.yMd().format(expenses[index].createdAt)}'),
            trailing: Text('-E${expenses[index].price.toDouble().toString()}'),
          ),
        );
      },
    );
  }
}
