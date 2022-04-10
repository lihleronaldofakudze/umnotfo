import 'package:flutter/material.dart';
import 'package:umnofto/models/expenses.dart';
import 'package:umnofto/services/expenses_db.dart';

class AddExpensesScreen extends StatefulWidget {
  final expenseId;
  const AddExpensesScreen({Key? key, this.expenseId}) : super(key: key);

  @override
  _AddExpensesScreenState createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  String category = 'Personal';
  bool _loading = false;
  late Expenses _expenses;
  int id = 0;
  final List<String> categories = [
    'Entertainment',
    'Personal',
    'Food',
    'Transportation',
    'Business',
    'Any'
  ];
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();

  _getData() async {
    setState(() {
      _loading = true;
    });

    if (widget.expenseId != null) {
      _expenses = await getExpense(widget.expenseId);
      _titleController.text = _expenses.title;
      _priceController.text = _expenses.price.toString();
      category = _expenses.category;
    }

    setState(() {
      _loading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.expenseId == null ? 'Add Transaction' : 'Edit Transaction',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Please enter all details',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        labelText: 'Enter title',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => category = val.toString());
                    },
                    value: category,
                    isExpanded: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        labelText: 'Select Category',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(
                        labelText: 'Enter price',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    keyboardType: TextInputType.number,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            widget.expenseId == null
                ? SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Expenses newExpenses = new Expenses(
                              title: _titleController.text,
                              category: category,
                              createdAt: new DateTime.now(),
                              price: double.parse(_priceController.text));
                          await addExpenses(newExpenses).then((value) {
                            setState(() {
                              _titleController.clear();
                              _priceController.clear();
                            });
                            Navigator.pushNamed(context, '/home');
                            ScaffoldMessenger.of(context).showSnackBar(
                                new SnackBar(
                                    content: Text(
                                        'New Expenses Added Successfully')));
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                new SnackBar(content: Text(error.toString())));
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              new SnackBar(content: Text('Form Not Valid')));
                        }
                      },
                      child: Text('Add Transaction'),
                    ),
                  )
                : SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.orange),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Expenses newExpenses = new Expenses(
                              id: widget.expenseId,
                              title: _titleController.text,
                              category: category,
                              createdAt: new DateTime.now(),
                              price: double.parse(_priceController.text));
                          await updateExpense(newExpenses, id).then((value) {
                            setState(() {
                              _titleController.clear();
                              _priceController.clear();
                            });
                            Navigator.pushNamed(context, '/home');
                            ScaffoldMessenger.of(context).showSnackBar(
                                new SnackBar(
                                    content: Text(
                                        'New Expenses Added Successfully')));
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                new SnackBar(content: Text(error.toString())));
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              new SnackBar(content: Text('Form Not Valid')));
                        }
                      },
                      child: Text('Update Transaction'),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
