final String tableGrocery = 'grocery';

class GroceryFields {
  static final String id = '_id';
  static final String item = 'item';
  static final String price = 'price';
}

class Grocery {
  final int? id;
  final String item;
  final double price;

  Grocery({this.id, required this.item, required this.price});

  Map<String, Object?> toJson() => {
        GroceryFields.id: price,
        GroceryFields.item: item,
        GroceryFields.price: price
      };
}
