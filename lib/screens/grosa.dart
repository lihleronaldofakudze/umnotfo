import 'package:flutter/material.dart';
import 'package:umnofto/widgets/grocery_list.dart';

class Grocery extends StatelessWidget {
  const Grocery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Grocery List',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(
                        'Add Item',
                        textAlign: TextAlign.center,
                      ),
                      content: TextField(
                        decoration: InputDecoration(
                            hintText: 'Enter Item',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Add'),
                        )
                      ],
                    );
                  });
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: GroceryList(),
    );
  }
}
