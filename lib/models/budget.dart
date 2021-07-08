final String tableBudget = 'budget';

class BudgetFields {
  static final String id = '_id';
  static final String description = 'description';
  static final String category = 'category';
  static final String price = 'price';
}

class Budget {
  final int? id;
  final String description;
  final String category;
  final String price;

  Budget(
      {this.id,
      required this.description,
      required this.category,
      required this.price});

  Map<String, Object?> toJson() => {
        BudgetFields.id: id,
        BudgetFields.description: description,
        BudgetFields.category: category,
        BudgetFields.price: price
      };
}
