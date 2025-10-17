class Transaction {
  String type;
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
