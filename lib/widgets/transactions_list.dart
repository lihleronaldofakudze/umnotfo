import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:umnofto/models/expenses.dart';
import 'package:umnofto/widgets/category_color.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactions = [
      Expenses(
          title: 'Title Space',
          category: 'Entertainment',
          createdAt: DateTime.now(),
          price: 11.00),
      Expenses(
          title: 'Title Space',
          category: 'Personal',
          createdAt: DateTime.now(),
          price: 11.00),
      Expenses(
          title: 'Title Space',
          category: 'Food',
          createdAt: DateTime.now(),
          price: 11.00),
      Expenses(
          title: 'Title Space',
          category: 'Transportation',
          createdAt: DateTime.now(),
          price: 11.00),
      Expenses(
          title: 'Title Space',
          category: 'Any',
          createdAt: DateTime.now(),
          price: 11.00),
      Expenses(
          title: 'Title Space',
          category: 'Entertainment',
          createdAt: DateTime.now(),
          price: 11.00),
    ];

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(
                  color: getCategoryColor(transactions[index].category),
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
            title: Text(transactions[index].title),
            subtitle: Text(
                '${transactions[index].category} - ${DateFormat.yMd().format(transactions[index].createdAt)}'),
            trailing:
                Text('-E${transactions[index].price.toDouble().toString()}'),
          ),
        );
      },
    );
  }
}
