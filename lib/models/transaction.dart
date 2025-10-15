class Transaction {
  String type; // "Доход" или "Расход"
  String category;
  double amount;
  String comment;
  DateTime date;

  Transaction({
    required this.type,
    required this.category,
    required this.amount,
    required this.comment,
    required this.date,
  });
}
