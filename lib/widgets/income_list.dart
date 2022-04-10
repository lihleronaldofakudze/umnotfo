import 'package:flutter/material.dart';
import 'package:umnofto/models/income.dart';
import 'package:umnofto/services/income_db.dart';

import 'loading.dart';

class IncomeList extends StatefulWidget {
  const IncomeList({Key? key}) : super(key: key);

  @override
  _IncomeListState createState() => _IncomeListState();
}

class _IncomeListState extends State<IncomeList> {
  bool _loading = false;
  late List<Income> _incomes;
  double _total = 0;

  _findTotal() async {
    _total = 0;
    _incomes = await getIncomes();
    for (var income in _incomes) {
      _total += income.price;
    }
  }

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
    _findTotal();
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
                    itemCount: _incomes.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(_incomes[index].title),
                          subtitle:
                              Text('E ${_incomes[index].price.toString()}'),
                          trailing: IconButton(
                            onPressed: () async {
                              await deleteIncome(_incomes[index].id!)
                                  .then((value) async => _refreshData());
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
