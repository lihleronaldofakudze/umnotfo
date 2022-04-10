import 'package:flutter/material.dart';
import 'package:umnofto/models/grocery.dart';
import 'package:umnofto/services/grocery_db.dart';
import 'package:umnofto/widgets/loading.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  late List<Grocery> _grocery;
  bool _loading = false;
  final _priceController = TextEditingController();

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
                    subtitle: Text('E ${_grocery[index].price}'),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title:
                                      Text('Add ${_grocery[index].item} Price'),
                                  content: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()),
                                    controller: _priceController,
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.red),
                                        )),
                                    TextButton(
                                        onPressed: () async {
                                          Grocery grocery = new Grocery(
                                              id: _grocery[index].id,
                                              item: _grocery[index].item,
                                              price: double.parse(
                                                  _priceController.text));
                                          await updateGrocer(
                                                  grocery, _grocery[index].id!)
                                              .then((value) {
                                            _priceController.clear();
                                            _refreshData();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(new SnackBar(
                                              content: Text(
                                                  'Successfully Updated. Drag down to refresh.'),
                                            ));
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Save',
                                          style: TextStyle(color: Colors.green),
                                        ))
                                  ],
                                ));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
