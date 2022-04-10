import 'package:flutter/material.dart';
import 'package:umnofto/models/budget.dart';
import 'package:umnofto/services/budget_db.dart';
import 'package:umnofto/widgets/budget_list.dart';
import 'package:umnofto/widgets/drawer_widget.dart';
import 'package:umnofto/widgets/loading.dart';

class BudgetsScreen extends StatefulWidget {
  const BudgetsScreen({Key? key}) : super(key: key);

  @override
  _BudgetsScreenState createState() => _BudgetsScreenState();
}

class _BudgetsScreenState extends State<BudgetsScreen> {
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  bool _loading = false;
  late List<Budget> _budgets;

  _refreshData() async {
    setState(() {
      _loading = true;
    });

    _budgets = await getBudgets();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Budget',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text('Add Budget'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                    labelText: 'Description',
                                    border: OutlineInputBorder()),
                                controller: _descriptionController,
                                maxLength: 20,
                                keyboardType: TextInputType.text,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    labelText: 'Price',
                                    border: OutlineInputBorder()),
                                controller: _priceController,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                              )
                            ],
                          ),
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
                                if (_descriptionController.text.isEmpty &&
                                    _priceController.text.isEmpty) {
                                } else {
                                  Budget budget = new Budget(
                                    price: double.parse(_priceController.text),
                                    description: _descriptionController.text,
                                  );
                                  await addBudget(budget).then((value) {
                                    setState(() {
                                      _priceController.clear();
                                      _descriptionController.clear();
                                    });
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        new SnackBar(
                                            content: Text(
                                                'Successfully Added. Drag down to refresh')));
                                    _refreshData();
                                  }).catchError((onError) {
                                    Navigator.pop(context);
                                    print(onError);
                                  });
                                }
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.blue),
                              )),
                        ],
                      ));
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: _loading ? Loading() : BudgetList(),
    );
  }
}
