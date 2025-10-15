import '../models/transaction.dart';

final List<Transaction> demoTransactions = [
  // --- Доходы ---
  Transaction(
    type: 'Доход',
    category: 'Зарплата',
    amount: 52000,
    comment: 'Основная работа',
    date: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Transaction(
    type: 'Доход',
    category: 'Фриланс',
    amount: 18000,
    comment: 'Проект по дизайну сайта',
    date: DateTime.now().subtract(const Duration(days: 5)),
  ),
  Transaction(
    type: 'Доход',
    category: 'Кэшбэк',
    amount: 1200,
    comment: 'Кэшбэк от банка',
    date: DateTime.now().subtract(const Duration(days: 3)),
  ),
  Transaction(
    type: 'Доход',
    category: 'Подарок',
    amount: 5000,
    comment: 'День рождения 🎉',
    date: DateTime.now().subtract(const Duration(days: 10)),
  ),

  // --- Расходы ---
  Transaction(
    type: 'Расход',
    category: 'Еда',
    amount: 3200,
    comment: 'Продукты на неделю',
    date: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Transaction(
    type: 'Расход',
    category: 'Еда',
    amount: 850,
    comment: 'Кафе с друзьями',
    date: DateTime.now().subtract(const Duration(days: 4)),
  ),
  Transaction(
    type: 'Расход',
    category: 'Одежда',
    amount: 4200,
    comment: 'Куртка и кроссовки',
    date: DateTime.now().subtract(const Duration(days: 9)),
  ),
  Transaction(
    type: 'Расход',
    category: 'Развлечения',
    amount: 2600,
    comment: 'Кино, кофе, настолки',
    date: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Transaction(
    type: 'Расход',
    category: 'Здоровье',
    amount: 2300,
    comment: 'Аптека и витамины',
    date: DateTime.now().subtract(const Duration(days: 4)),
  ),
];
