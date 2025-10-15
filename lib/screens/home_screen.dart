import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../data/demo_data.dart'; // 👈 импорт стартовых данных
import 'add_transaction_screen.dart';
import 'transactions_list_screen.dart';
import 'statistics_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Подгружаем стартовые данные
  List<Transaction> _transactions = List.from(demoTransactions);

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

  void _addTransaction(Transaction transaction) {
    setState(() {
      _transactions.add(transaction);
    });
  }

  void _deleteTransaction(Transaction transaction) {
    setState(() {
      _transactions.remove(transaction);
    });
  }

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
              Text(
                'Текущий баланс: ${_totalBalance.toStringAsFixed(2)} ₽',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildWideButton(
                icon: Icons.add,
                text: 'Добавить операцию',
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
              _buildWideButton(
                icon: Icons.list,
                text: 'Список операций',
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
              _buildWideButton(
                icon: Icons.pie_chart,
                text: 'Статистика расходов',
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
              if (totals.isNotEmpty) ...[
                const Text(
                  'Быстрый обзор по категориям:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Column(
                  children: totals.entries.map((e) {
                    return ListTile(
                      leading: const Icon(Icons.attach_money_outlined),
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

  Widget _buildWideButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 22),
        label: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepPurple,
          side: const BorderSide(color: Colors.deepPurple, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
