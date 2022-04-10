import 'package:flutter/material.dart';
import 'package:umnofto/widgets/drawer.dart';
import 'package:umnofto/widgets/shopping_list.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Shopping',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ShoppingList(),
    );
  }
}
