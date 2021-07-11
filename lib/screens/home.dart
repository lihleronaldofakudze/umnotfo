import 'package:flutter/material.dart';
import 'package:umnofto/widgets/drawer.dart';
import 'package:umnofto/widgets/expenses_list.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Umnofto',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_transaction');
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: ExpensesList(),
    );
  }
}
