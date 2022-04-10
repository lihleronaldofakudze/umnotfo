import 'package:flutter/material.dart';
import 'package:umnofto/models/income.dart';
import 'package:umnofto/services/income_db.dart';
import 'package:umnofto/widgets/drawer_widget.dart';
import 'package:umnofto/widgets/income_list.dart';
import 'package:umnofto/widgets/loading.dart';

class IncomesScreen extends StatefulWidget {
  const IncomesScreen({Key? key}) : super(key: key);

  @override
  _IncomesScreenState createState() => _IncomesScreenState();
}

class _IncomesScreenState extends State<IncomesScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  bool _loading = false;
  late List<Income> _incomes;

  _refreshData() async {
    setState(() {
      _loading = true;
    });

    _incomes = await getIncomes();
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
    return Scaffold(
      drawer: drawerWidget(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Income',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text('Add Income'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                    labelText: 'Title',
                                    border: OutlineInputBorder()),
                                controller: _titleController,
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
                                if (_titleController.text.isEmpty &&
                                    _priceController.text.isEmpty) {
                                } else {
                                  Income income = new Income(
                                      price:
                                          double.parse(_priceController.text),
                                      title: _titleController.text,
                                      createdAt: new DateTime.now());
                                  await addIncome(income).then((value) {
                                    setState(() {
                                      _priceController.clear();
                                      _titleController.clear();
                                    });
                                    _refreshData();
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        new SnackBar(
                                            content:
                                                Text('Drag down to refresh')));
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
      body: _loading ? Loading() : IncomeList(),
    );
  }
}
