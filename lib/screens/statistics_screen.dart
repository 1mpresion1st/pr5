import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/transaction.dart';

class StatisticsScreen extends StatelessWidget {
  final List<Transaction> transactions;

  const StatisticsScreen({super.key, required this.transactions});

  Map<String, double> _getCategoryTotals() {
    Map<String, double> totals = {};
    for (var t in transactions) {
      if (t.type == 'Расход') {
        totals[t.category] = (totals[t.category] ?? 0) + t.amount;
      }
    }
    return totals;
  }

  @override
  Widget build(BuildContext context) {
    final totals = _getCategoryTotals();
    final totalAmount = totals.values.fold(0.0, (a, b) => a + b);

    if (totals.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Статистика расходов')),
        body: const Center(child: Text('Нет данных для визуализации')),
      );
    }

    final sections = totals.entries.map((e) {
      final percent = (e.value / totalAmount * 100).toStringAsFixed(1);
      return PieChartSectionData(
        color: Colors.primaries[totals.keys.toList().indexOf(e.key) %
            Colors.primaries.length],
        value: e.value,
        title: '${e.key}\n$percent%',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Статистика расходов')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Диаграмма расходов по категориям',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Суммы по категориям:'),
            ...totals.entries.map((e) => ListTile(
              leading: const Icon(Icons.label),
              title: Text(e.key),
              trailing: Text('${e.value.toStringAsFixed(2)} ₽'),
            )),
          ],
        ),
      ),
    );
  }
}
