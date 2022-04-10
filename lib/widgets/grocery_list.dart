import 'package:flutter/material.dart';
import 'package:umnofto/models/grocery.dart';
import 'package:umnofto/services/grocery_db.dart';
import 'package:umnofto/widgets/loading.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  _GroceryListState createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
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
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : RefreshIndicator(
            onRefresh: () async => _refreshData(),
            child: ListView.builder(
              itemCount: _grocery.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0)
                      ],
                      border: Border.all(color: Colors.black)),
                  child: ListTile(
                    title: Text(_grocery[index].item),
                    trailing: IconButton(
                      onPressed: () async {
                        await deleteGrocer(_grocery[index].id!).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                              content: Text(
                                  'Deleted Successfully. Drag down to refresh.')));
                          _refreshData();
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
