final String tableGrocery = 'grocery';

class GroceryFields {
  static final List<String> values = [id, item, price];

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
        GroceryFields.id: id,
        GroceryFields.item: item,
        GroceryFields.price: price
      };

  Grocery copy({int? id, String? item, double? price}) => Grocery(
      id: id ?? this.id, item: item ?? this.item, price: price ?? this.price);

  static Grocery fromJson(Map<String, Object?> json) => Grocery(
      id: json[GroceryFields.id] as int?,
      item: json[GroceryFields.item] as String,
      price: json[GroceryFields.price] as double);
}
