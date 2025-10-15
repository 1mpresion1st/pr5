import 'package:flutter/material.dart';
import '../models/transaction.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  final _commentController = TextEditingController();

  String _selectedType = 'Доход';

  void _saveTransaction() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) return;

    final newTransaction = Transaction(
      type: _selectedType,
      category: _categoryController.text,
      amount: amount,
      comment: _commentController.text,
      date: DateTime.now(),
    );

    Navigator.pop(context, newTransaction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить операцию')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedType,
              items: ['Доход', 'Расход']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedType = val!;
                });
              },
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Сумма'),
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Категория'),
            ),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(labelText: 'Комментарий'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTransaction,
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
