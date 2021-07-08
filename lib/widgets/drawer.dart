import 'package:flutter/material.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        DrawerHeader(
          child: Container(
            height: 137,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/umnofto.png'),
            )),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/grocery');
          },
          child: Container(
            child: ListTile(
              title: Text(
                'Grosa List',
                style: TextStyle(fontSize: 16),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
