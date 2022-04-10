import 'package:flutter/material.dart';
import 'package:umnofto/models/budget.dart';
import 'package:umnofto/services/budget_db.dart';

import 'loading.dart';

class BudgetList extends StatefulWidget {
  const BudgetList({Key? key}) : super(key: key);

  @override
  _BudgetListState createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {
  bool _loading = false;
  late List<Budget> _budgets;
  double _total = 0;

  _refreshData() async {
    setState(() {
      _loading = true;
    });

    _budgets = await getBudgets();
    _budgets.map((budget) {
      setState(() {
        _total += budget.price;
      });
    });
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
            onRefresh: () async => await _refreshData(),
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text('Total : E ${_total.toString()}'),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _budgets.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(_budgets[index].description),
                          subtitle:
                              Text('E ${_budgets[index].price.toString()}'),
                          trailing: IconButton(
                            onPressed: () async {
                              await deleteBudget(_budgets[index].id!)
                                  .then((value) async => await _refreshData());
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
                ),
              ],
            ),
          );
  }
}
