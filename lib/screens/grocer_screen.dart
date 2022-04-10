import 'package:flutter/material.dart';
import 'package:umnofto/models/grocery.dart';
import 'package:umnofto/services/grocery_db.dart';
import 'package:umnofto/widgets/drawer_widget.dart';
import 'package:umnofto/widgets/grocery_list.dart';
import 'package:umnofto/widgets/loading.dart';

class GrocerScreen extends StatefulWidget {
  const GrocerScreen({Key? key}) : super(key: key);

  @override
  _GrocerScreenState createState() => _GrocerScreenState();
}

class _GrocerScreenState extends State<GrocerScreen> {
  final _itemController = TextEditingController();
  late List<Grocery> _grocery;
  bool _loading = false;
  _refreshData() async {
    setState(() {
      _loading = true;
    });

    _grocery = await getGroceries();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(context),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Grocery List',
          style: TextStyle(color: Colors.black),
        ),
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
                        controller: _itemController,
                        decoration: InputDecoration(
                            hintText: 'Enter Item',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (_itemController.text.isNotEmpty) {
                              Grocery grocery = new Grocery(
                                  item: _itemController.text, price: 0.0);
                              await addGrocer(grocery).then((value) {
                                _itemController.clear();
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    new SnackBar(
                                        content: Text(
                                            'Item added to grocery list. Drag down to refresh.')));
                                _refreshData();
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  new SnackBar(
                                      content: Text('Please enter item.')));
                            }
                          },
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
      body: _loading ? Loading() : GroceryList(),
    );
  }
}
