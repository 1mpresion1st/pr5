import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/transaction_item.dart';

class TransactionsListScreen extends StatefulWidget {
  final List<Transaction> transactions;
  final Function(Transaction) onDelete;

  const TransactionsListScreen({
    required this.transactions,
    required this.onDelete,
    super.key,
  });

  @override
  State<TransactionsListScreen> createState() => _TransactionsListScreenState();
}

class _TransactionsListScreenState extends State<TransactionsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список операций')),
      body: widget.transactions.isEmpty
          ? const Center(child: Text('Нет операций'))
          : ListView.builder(
        itemCount: widget.transactions.length,
        itemBuilder: (ctx, i) {
          final t = widget.transactions[i];
          return Dismissible(
            key: ValueKey(t.date.toIso8601String() + t.amount.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) {
              widget.onDelete(t);
              setState(() {}); // мгновенно обновляем экран
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Операция удалена')),
              );
            },
            child: TransactionItem(
              transaction: t,
              onDelete: () {
                widget.onDelete(t);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Операция удалена')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
