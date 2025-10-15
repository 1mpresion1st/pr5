import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback onDelete;

  const TransactionItem({
    required this.transaction,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(
          transaction.type == 'Доход' ? Icons.arrow_upward : Icons.arrow_downward,
          color: transaction.type == 'Доход' ? Colors.green : Colors.red,
        ),
        title: Text('${transaction.category}: ${transaction.amount} ₽'),
        subtitle: Text(transaction.comment.isEmpty
            ? transaction.date.toString()
            : '${transaction.comment} (${transaction.date.toLocal().toString().split(' ')[0]})'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
