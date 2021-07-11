import 'package:animated_splash_screen/animated_splash_screen.dart';
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
        '/': (context) => AnimatedSplashScreen(
            splash: Container(
              height: 100,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('images/umnofto.png'))),
            ),
            nextScreen: Home()),
        '/home': (context) => Home(),
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
