final String tableExpenses = "expenses";

class ExpensesFields {
  static final List<String> values = [id, title, category, createdAt, price];

  static final String id = '_id';
  static final String title = 'title';
  static final String category = 'category';
  static final String createdAt = 'createdAt';
  static final String price = 'price';
}

class Expenses {
  final int? id;
  final String title;
  final String category;
  final DateTime createdAt;
  final double price;

  Expenses(
      {this.id,
      required this.title,
      required this.category,
      required this.createdAt,
      required this.price});

  Expenses copy(
          {int? id,
          String? title,
          String? category,
          DateTime? createdAt,
          double? price}) =>
      Expenses(
          id: id ?? this.id,
          title: title ?? this.title,
          category: category ?? this.category,
          createdAt: createdAt ?? this.createdAt,
          price: price ?? this.price);

  static Expenses fromJson(Map<String, Object?> json) => Expenses(
      id: json[ExpensesFields.id] as int?,
      title: json[ExpensesFields.title] as String,
      category: json[ExpensesFields.category] as String,
      createdAt: DateTime.parse(json[ExpensesFields.createdAt] as String),
      price: json[ExpensesFields.price] as double);

  Map<String, Object?> toJson() => {
        ExpensesFields.id: id,
        ExpensesFields.title: title,
        ExpensesFields.category: category,
        ExpensesFields.createdAt: createdAt.toIso8601String(),
        ExpensesFields.price: price
      };
}
