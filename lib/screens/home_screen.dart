import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'add_transaction_screen.dart';
import 'transactions_list_screen.dart';
import 'statistics_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Transaction> _transactions = [];

  // --- вычисление общего баланса ---
  double get _totalBalance {
    double income = _transactions
        .where((t) => t.type == 'Доход')
        .fold(0, (sum, t) => sum + t.amount);
    double expense = _transactions
        .where((t) => t.type == 'Расход')
        .fold(0, (sum, t) => sum + t.amount);
    return income - expense;
  }

  // --- добавление операции ---
  void _addTransaction(Transaction transaction) {
    setState(() {
      _transactions.add(transaction);
    });
  }

  // --- удаление операции ---
  void _deleteTransaction(Transaction transaction) {
    setState(() {
      _transactions.remove(transaction);
    });
  }

  // --- подсчёт по категориям (для будущего анализа) ---
  Map<String, double> _getCategoryTotals() {
    Map<String, double> totals = {};
    for (var t in _transactions) {
      if (t.type == 'Расход') {
        totals[t.category] = (totals[t.category] ?? 0) + t.amount;
      }
    }
    return totals;
  }

  @override
  Widget build(BuildContext context) {
    final totals = _getCategoryTotals();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Планировщик бюджета'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ---- общий баланс ----
              Text(
                'Текущий баланс: ${_totalBalance.toStringAsFixed(2)} ₽',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // ---- кнопка добавления ----
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Добавить операцию'),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddTransactionScreen(),
                    ),
                  );
                  if (result != null && result is Transaction) {
                    _addTransaction(result);
                  }
                },
              ),
              const SizedBox(height: 10),

              // ---- кнопка просмотра списка ----
              ElevatedButton.icon(
                icon: const Icon(Icons.list),
                label: const Text('Список операций'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TransactionsListScreen(
                        transactions: _transactions,
                        onDelete: _deleteTransaction,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),

              // ---- кнопка статистики ----
              ElevatedButton.icon(
                icon: const Icon(Icons.pie_chart),
                label: const Text('Статистика расходов'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          StatisticsScreen(transactions: _transactions),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // ---- мини-обзор по категориям ----
              if (totals.isNotEmpty) ...[
                const Text(
                  'Быстрый обзор по категориям:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Column(
                  children: totals.entries.map((e) {
                    return ListTile(
                      leading: const Icon(Icons.label_outline),
                      title: Text(e.key),
                      trailing: Text('${e.value.toStringAsFixed(2)} ₽'),
                    );
                  }).toList(),
                ),
              ] else
                const Text('Пока нет расходов для анализа.'),
            ],
          ),
        ),
      ),
    );
  }
}
