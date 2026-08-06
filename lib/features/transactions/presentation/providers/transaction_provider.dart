import 'package:expense_iq/core/enums/transaction_type.dart';
import 'package:expense_iq/features/transactions/data/models/transaction_model.dart';
import 'package:expense_iq/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepository _repository;

  TransactionProvider(this._repository);

  final List<TransactionModel> _transactions = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<TransactionModel> get transactions =>
      List.unmodifiable(_transactions);

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  double get totalIncome {
    return _transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalExpense {
    return _transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get balance => totalIncome - totalExpense;

  double get budgetUsed => totalExpense;
  
  double budgetRemaining(double monthlyBudget) {
    return monthlyBudget - totalExpense;
  }

  double budgetProgress(double monthlyBudget) {
    if (monthlyBudget <= 0) return 0;

    return (totalExpense / monthlyBudget).clamp(0.0, 1.0);
  }

  List<TransactionModel> get recentTransactions {
    final sorted = [..._transactions];

    sorted.sort(
      (a, b) => b.date.compareTo(a.date),
    );

    return sorted.take(5).toList();
  }

  Future<void> loadTransactions() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _repository.getTransactions();

      _transactions
        ..clear()
        ..addAll(data);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTransaction(
      TransactionModel transaction) async {
    try {
      await _repository.addTransaction(transaction);

      await loadTransactions();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateTransaction(
      TransactionModel transaction) async {

    try {
      await _repository.updateTransaction(transaction);

      await loadTransactions();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  

  Future<void> deleteTransaction(String id) async {
    try {
      await _repository.deleteTransaction(id);

      _transactions.removeWhere(
        (transaction) => transaction.id == id,
      );

      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}