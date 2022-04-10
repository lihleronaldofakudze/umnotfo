import 'package:flutter/material.dart';
import 'package:umnofto/widgets/drawer.dart';
import 'package:umnofto/widgets/expenses_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Umnotfo Expenses',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_transaction');
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     // Navigator.pushNamed(context, '/add_transaction');
          //   },
          //   icon: Icon(
          //     Icons.settings,
          //     color: Colors.black,
          //   ),
          // )
        ],
      ),
      body: ExpensesList(),
    );
  }
}
