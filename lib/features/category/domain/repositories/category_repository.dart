import 'package:expense_iq/features/category/data/models/category_model.dart';

/// Defines the contract for category data operations.
///
/// Abstracts category-related actions from the data layer,
/// allowing different implementations without affecting
/// the rest of the application.
abstract class CategoryRepository {
  Future<List<CategoryModel>> getCategories();

  Future<void> addCategory(CategoryModel category);

  Future<void> updateCategory(CategoryModel category);

  Future<void> deleteCategory(String id);
}