final String tableIncome = "income";

class IncomeFields {
  static final List<String> values = [id, title, createdAt, price];

  static final String id = '_id';
  static final String title = 'title';
  static final String createdAt = 'createdAt';
  static final String price = 'price';
}

class Income {
  final int? id;
  final String title;
  final DateTime createdAt;
  final double price;

  Income(
      {this.id,
      required this.title,
      required this.createdAt,
      required this.price});

  Income copy({int? id, String? title, DateTime? createdAt, double? price}) =>
      Income(
          id: id ?? this.id,
          title: title ?? this.title,
          createdAt: createdAt ?? this.createdAt,
          price: price ?? this.price);

  static Income fromJson(Map<String, Object?> json) => Income(
      id: json[IncomeFields.id] as int?,
      title: json[IncomeFields.title] as String,
      createdAt: DateTime.parse(json[IncomeFields.createdAt] as String),
      price: json[IncomeFields.price] as double);

  Map<String, Object?> toJson() => {
        IncomeFields.id: id,
        IncomeFields.title: title,
        IncomeFields.createdAt: createdAt.toIso8601String(),
        IncomeFields.price: price
      };
}
