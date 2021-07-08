import 'package:flutter/material.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> grosa = ['Beans', 'Rice', 'Soup', 'Soap', 'Vaseline'];
    return ListView.builder(
      itemCount: grosa.length,
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
            title: Text(grosa[index]),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }
}
