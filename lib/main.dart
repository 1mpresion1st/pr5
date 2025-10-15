import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(BudgetPlannerApp());
}

class BudgetPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Планировщик бюджета',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeScreen(),
    );
  }
}
