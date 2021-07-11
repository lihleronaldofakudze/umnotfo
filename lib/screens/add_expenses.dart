import 'package:flutter/material.dart';
import 'package:umnofto/models/expenses.dart';
import 'package:umnofto/services/database.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({Key? key}) : super(key: key);

  @override
  _AddExpensesState createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Entertainment',
      'Personal',
      'Food',
      'Transportation',
      'Any'
    ];
    final _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController();
    final _priceController = TextEditingController();
    String _category = 'Personal';
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Add Transaction',
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
                    value: _category,
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _category = val.toString()),
                    decoration: InputDecoration(
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Expenses newExpenses = new Expenses(
                      title: _titleController.text,
                      category: _category,
                      createdAt: new DateTime.now(),
                      price: double.parse(_priceController.text));
                  UmnotfoDatabase.instance
                      .addExpenses(newExpenses)
                      .then((value) {
                    setState(() {
                      _titleController.clear();
                      _priceController.clear();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        content: Text('New Expenses Added Successfully')));
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        new SnackBar(content: Text(error.toString())));
                  });
                }
              },
              child: Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}
