import 'package:expense_iq/core/enums/transaction_type.dart';
import 'package:expense_iq/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Provides transaction type filters.
///
/// Allows users to filter transactions
/// by all, income, or expense categories.
class TransactionFilterChips extends StatelessWidget {
  const TransactionFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Wrap(
        spacing: 8,
        children: [
          ChoiceChip(
            label: const Text('All'),
            selected: provider.selectedType == null,
            onSelected: (_) {
              provider.setSelectedType(null);
            },
          ),

          ChoiceChip(
            label: const Text('Income'),
            selected:
                provider.selectedType ==
                TransactionType.income,
            onSelected: (_) {
              provider.setSelectedType(
                TransactionType.income,
              );
            },
          ),

          ChoiceChip(
            label: const Text('Expense'),
            selected:
                provider.selectedType ==
                TransactionType.expense,
            onSelected: (_) {
              provider.setSelectedType(
                TransactionType.expense,
              );
            },
          ),
        ],
      ),
    );
  }
}