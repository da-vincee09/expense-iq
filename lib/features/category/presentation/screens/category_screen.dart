// ignore_for_file: use_build_context_synchronously

import 'package:expense_iq/core/enums/transaction_type.dart';
import 'package:expense_iq/features/category/data/models/category_model.dart';
import 'package:expense_iq/features/category/presentation/providers/category_provider.dart';
import 'package:expense_iq/features/category/presentation/widgets/category_dialog.dart';
import 'package:expense_iq/shared/extensions/snackbar_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Displays and manages user transaction categories.
///
/// Allows users to view, add, edit, and delete categories while
/// communicating with CategoryProvider for state management.
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CategoryProvider>().loadCategories();
    });
  }

  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CategoryDialog(
          title: 'Add Category',
          actionText: 'Save',
          initialType: TransactionType.expense,
          onSave: (name, type) async {
            final user = Supabase.instance.client.auth.currentUser;

            if (user == null) return;

            final category = CategoryModel(
              id: '',
              userId: user.id,
              name: name,
              type: type,
              icon: null,
              createdAt: DateTime.now(),
            );

            try {
              await context
                  .read<CategoryProvider>()
                  .addCategory(category);

              if (!context.mounted) return;

              context.showSuccess('Category added successfully!');
            } catch (e) {
              if (!context.mounted) return;

              context.showError('Failed to add category.');
            }
          },
        );
      },
    );
  }

  void _showEditCategoryDialog(CategoryModel category) {
    showDialog(
      context: context,
      builder: (context) {
        return CategoryDialog(
          title: 'Edit Category',
          actionText: 'Update',
          initialName: category.name,
          initialType: category.type,
          onSave: (name, type) async {
            try {
              final updatedCategory = category.copyWith(
                name: name,
                type: type,
              );

              await context
                  .read<CategoryProvider>()
                  .updateCategory(updatedCategory);

              if (!mounted) return;

              context.showSuccess(
                'Category updated successfully!',
              );
            } catch (e) {
              if (!mounted) return;

              context.showError(
                'Failed to update category.',
              );
            }
          },
        );
      },
    );
  }

  void _showDeleteCategoryDialog(CategoryModel category) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Category'),
          content: Text(
            'Are you sure you want to delete "${category.name}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.pop(context);

                try {
                  await this
                      .context
                      .read<CategoryProvider>()
                      .deleteCategory(category.id);

                  if (!mounted) return;

                  context.showSuccess(
                    'Category deleted successfully!',
                  );
                } catch (e) {
                  if (!mounted) return;

                  context.showError(
                    'Failed to delete category.',
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CategoryProvider>();

    final expenseCategories = provider.categoriesByType(
      TransactionType.expense,
    );

    final incomeCategories = provider.categoriesByType(
      TransactionType.income,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (provider.errorMessage != null) {
              return Center(
                child: Text(provider.errorMessage!),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _CategorySection(
                  title: 'Expense',
                  categories: expenseCategories,
                  onEdit: _showEditCategoryDialog,
                  onDelete: _showDeleteCategoryDialog,
                ),

                _CategorySection(
                  title: 'Income',
                  categories: incomeCategories,
                  onEdit: _showEditCategoryDialog,
                  onDelete: _showDeleteCategoryDialog,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCategoryDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  final String title;
  final List categories;
  final void Function(CategoryModel category) onEdit;
  final void Function(CategoryModel category) onDelete;

  const _CategorySection({
    required this.title,
    required this.categories, 
    required this.onEdit, 
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            if (categories.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text('No categories'),
              )
            else
              ...categories.map(
                (category) => ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.category),
                  ),
                  title: Text(category.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => onEdit(category),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => onDelete(category),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}