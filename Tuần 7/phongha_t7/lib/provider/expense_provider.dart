import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../model/expense.dart';

class ExpenseProvider extends ChangeNotifier {
  List<Expense> _expenses = [];
  double _totalAmount = 0.0;
  
  List<Expense> get expenses => _expenses;
  double get totalAmount => _totalAmount;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> loadExpenses() async {
    _expenses = await _dbHelper.getExpenses();
    _totalAmount = await _dbHelper.getTotalExpense();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await _dbHelper.insertExpense(expense);
    await loadExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    await _dbHelper.updateExpense(expense);
    await loadExpenses();
  }

  Future<void> deleteExpense(int id) async {
    await _dbHelper.deleteExpense(id);
    await loadExpenses();
  }
}