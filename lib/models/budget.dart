final String tableBudget = 'budget';

class BudgetFields {
  static final List<String> values = [id, description, price];

  static final String id = '_id';
  static final String description = 'description';
  static final String price = 'price';
}

class Budget {
  final int? id;
  final String description;
  final double price;

  Budget({this.id, required this.description, required this.price});

  Budget copy({int? id, String? title, DateTime? createdAt, double? price}) =>
      Budget(
          id: id ?? this.id,
          description: title ?? this.description,
          price: price ?? this.price);

  static Budget fromJson(Map<String, Object?> json) => Budget(
      id: json[BudgetFields.id] as int?,
      description: json[BudgetFields.description] as String,
      price: json[BudgetFields.price] as double);

  Map<String, Object?> toJson() => {
        BudgetFields.id: id,
        BudgetFields.description: description,
        BudgetFields.price: price
      };
}
