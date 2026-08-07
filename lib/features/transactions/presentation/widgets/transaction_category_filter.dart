import 'package:expense_iq/features/category/presentation/providers/category_provider.dart';
import 'package:expense_iq/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Provides a category filter for transactions.
///
/// Allows users to filter transaction records
/// by selecting a specific category.
class TransactionCategoryFilter extends StatelessWidget {
  const TransactionCategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    final transactionProvider = context.watch<TransactionProvider>();

    final categories =
      transactionProvider.selectedType == null
          ? categoryProvider.categories
          : categoryProvider.categoriesByType(
              transactionProvider.selectedType!,
            );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: DropdownButtonFormField<String?>(
        initialValue: transactionProvider.selectedCategoryId,
        decoration: const InputDecoration(
          labelText: 'Category',
        ),
        items: [
          const DropdownMenuItem<String?>(
            value: null,
            child: Text('All Categories'),
          ),

          ...categories.map(
            (category) => DropdownMenuItem<String?>(
              value: category.id,
              child: Text(
                '${category.name} (${category.type.name})',
              ),
            ),
          ),
        ],
        onChanged: transactionProvider.setSelectedCategory,
      ),
    );
  }
}