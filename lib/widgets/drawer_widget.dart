import 'package:flutter/material.dart';

Drawer drawerWidget(BuildContext context) {
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
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/home');
          },
          child: ListTile(
            title: Text(
              'Home',
              style: TextStyle(fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/income');
          },
          child: ListTile(
            title: Text(
              'Income',
              style: TextStyle(fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/budget');
          },
          child: ListTile(
            title: Text(
              'Budget',
              style: TextStyle(fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/grocer');
          },
          child: ListTile(
            title: Text(
              'Grocer',
              style: TextStyle(fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/shopping');
          },
          child: ListTile(
            title: Text(
              'Shopping',
              style: TextStyle(fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: AboutListTile(
              child: Text(
                'About',
                style: TextStyle(fontSize: 16),
              ),
              icon: Icon(Icons.info),
              applicationName: 'Umnotfo',
              applicationIcon: Container(
                height: 50,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/umnofto.png'))),
              ),
              applicationVersion: '1.0.2',
              aboutBoxChildren: [
                Text(
                  'The budget application that tracks every price, and balances of your daily weekly and monthly spending. Made for individuals, small, medium and large business needs. Know how much you need and how much you spend everyday.',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'LEARN TO SAVE MORE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )
              ]),
        )
      ],
    ),
  );
}
