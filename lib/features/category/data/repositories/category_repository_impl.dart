import 'package:expense_iq/features/category/data/models/category_model.dart';
import 'package:expense_iq/features/category/domain/repositories/category_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Implementation of category repository using Supabase.
///
/// Handles retrieving, creating, updating, and deleting categories
/// from the database while keeping data access separate from the
/// application logic.
class CategoryRepositoryImpl implements CategoryRepository {
  final SupabaseClient supabase;

  CategoryRepositoryImpl({
    required this.supabase,
  });

  @override
  Future<List<CategoryModel>> getCategories() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User not authenticated.');
    }

    final response = await supabase
        .from('categories')
        .select()
        .eq('user_id', user.id)
        .order('name');

    return response
        .map<CategoryModel>(
          (json) => CategoryModel.fromJson(json),
        )
        .toList();
  }

  @override
  Future<void> addCategory(CategoryModel category) async {
    await supabase
        .from('categories')
        .insert(category.toInsertJson());
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    await supabase
        .from('categories')
        .update({
          'name': category.name,
          'type': category.type.name,
          'icon': category.icon,
        })
        .eq('id', category.id);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await supabase
        .from('categories')
        .delete()
        .eq('id', id);
  }
}