import 'package:expense_iq/core/enums/transaction_type.dart';
import 'package:expense_iq/features/category/data/models/category_model.dart';
import 'package:expense_iq/features/category/domain/repositories/category_repository.dart';
import 'package:flutter/material.dart';

/// Manages category state and operations.
///
/// Acts as a bridge between the presentation layer and the
/// category repository by handling category loading, creation,
/// updating, deletion, filtering, loading states, and errors.
class CategoryProvider extends ChangeNotifier {
  final CategoryRepository _repository;

  CategoryProvider(this._repository);

  final List<CategoryModel> _categories = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<CategoryModel> get categories => List.unmodifiable(_categories);

  Future<void> loadCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _repository.getCategories();

      _categories
        ..clear()
        ..addAll(data);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      await _repository.addCategory(category);
      await loadCategories();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _repository.updateCategory(category);
      await loadCategories();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _repository.deleteCategory(id);

      _categories.removeWhere(
        (category) => category.id == id,
      );

      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  List<CategoryModel> categoriesByType(TransactionType type) {
    return _categories
        .where((category) => category.type == type)
        .toList();
  }
}