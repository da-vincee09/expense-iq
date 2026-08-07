// ignore_for_file: use_build_context_synchronously

import 'package:expense_iq/features/category/presentation/providers/category_provider.dart';
import 'package:expense_iq/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:expense_iq/features/transactions/presentation/widgets/transaction_card.dart';
import 'package:expense_iq/features/transactions/presentation/widgets/transaction_category_filter.dart';
import 'package:expense_iq/features/transactions/presentation/widgets/transaction_filter_chips.dart';
import 'package:expense_iq/features/transactions/presentation/widgets/transaction_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Displays the user's transaction history.
///
/// Provides transaction search, filtering options,
/// and a list of recorded income and expense transactions.
class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends State<TransactionHistoryScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await context.read<TransactionProvider>().loadTransactions();
      await context.read<CategoryProvider>().loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<TransactionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transactions',
        ),
      ),
      body: provider.isLoading
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : provider.transactions.isEmpty
          ? const Center(
              child: Text(
                'No transactions yet.',
              ),
            )
          : provider.filteredTransactions.isEmpty
              ? Column(
                  children: const [
                    TransactionSearchBar(),
                    SizedBox(height: 8),

                    TransactionFilterChips(),
                    SizedBox(height: 8),

                    TransactionCategoryFilter(),
                    SizedBox(height: 8),

                    Expanded(
                      child: Center(
                        child: Text(
                          'No matching transactions found.',
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    const TransactionSearchBar(),
                    const SizedBox(height: 8),

                    const TransactionFilterChips(),
                    const SizedBox(height: 8),

                    const TransactionCategoryFilter(),
                    const SizedBox(height: 8),    

                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount:
                            provider.filteredTransactions.length,
                        itemBuilder: (context, index) {
                          final transaction =
                              provider.filteredTransactions[index];

                          return TransactionCard(
                            transaction: transaction,
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}