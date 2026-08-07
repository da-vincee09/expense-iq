import 'package:expense_iq/core/enums/transaction_type.dart';
import 'package:expense_iq/features/transactions/data/models/transaction_model.dart';
import 'package:expense_iq/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';

/// Manages transaction state and business logic.
///
/// Handles loading, adding, updating, deleting, searching,
/// filtering, and calculating transaction summaries.
class TransactionProvider extends ChangeNotifier {
  final TransactionRepository _repository;

  TransactionProvider(this._repository);

  final List<TransactionModel> _transactions = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  String? _selectedCategoryId;
  String? get selectedCategoryId => _selectedCategoryId;

  TransactionType? _selectedType;
  TransactionType? get selectedType => _selectedType;

  List<TransactionModel> get transactions =>
      List.unmodifiable(_transactions);


  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  List<TransactionModel> get filteredTransactions {
    Iterable<TransactionModel> filtered = _transactions;

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();

      filtered = filtered.where(
        (transaction) =>
            transaction.title.toLowerCase().contains(query),
      );
    }

    if (_selectedType != null) {
      filtered = filtered.where(
        (transaction) =>
            transaction.type == _selectedType,
      );
    }

    if (_selectedCategoryId != null) {
      filtered = filtered.where(
        (transaction) =>
            transaction.categoryId == _selectedCategoryId,
      );
    }

    return filtered.toList();
  }

  void setSelectedType(TransactionType? type) {
    _selectedType = type;
    _selectedCategoryId = null;
    notifyListeners();
  }

  void setSelectedCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

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

  Map<String, double> get expensesByCategory {
    final Map<String, double> data = {};

    for (final transaction in _transactions) {
      if (transaction.type == TransactionType.expense) {
        final category = transaction.category?.name ?? 'Unknown';

        data[category] = (data[category] ?? 0) + transaction.amount;
      }
    }

    return data;
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