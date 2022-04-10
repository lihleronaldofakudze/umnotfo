import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umnofto/screens/add_expenses_screen.dart';
import 'package:umnofto/screens/budgets_screen.dart';
import 'package:umnofto/screens/grocer_screen.dart';
import 'package:umnofto/screens/home_screen.dart';
import 'package:umnofto/screens/incomes_screen.dart';
import 'package:umnofto/screens/shopping_screen.dart';

void main() {
  runApp(Umnofto());
}

class Umnofto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => AnimatedSplashScreen(
            splash: Container(
              height: 100,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('images/umnofto.png'))),
            ),
            nextScreen: HomeScreen()),
        '/home': (context) => HomeScreen(),
        '/add_transaction': (context) => AddExpensesScreen(),
        '/income': (context) => IncomesScreen(),
        '/budget': (context) => BudgetsScreen(),
        '/grocer': (context) => GrocerScreen(),
        '/shopping': (context) => ShoppingScreen(),
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
