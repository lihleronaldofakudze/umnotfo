import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umnofto/screens/add_expenses.dart';
import 'package:umnofto/screens/grosa.dart';
import 'package:umnofto/screens/home.dart';

void main() {
  runApp(Umnofto());
}

class Umnofto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Home(),
        '/add_transaction': (context) => AddExpenses(),
        '/grocery': (context) => Grocery()
      },
      title: 'Umnofto',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          )),
    );
  }
}
