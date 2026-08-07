import 'package:expense_iq/features/transactions/data/models/transaction_model.dart';
import 'package:expense_iq/features/transactions/presentation/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

/// Displays a list of the user's recent transactions.
///
/// Shows an empty state when there are no transactions.
/// Provides an optional callback to navigate to the full transaction history.
class RecentTransactions extends StatelessWidget {
  final List<TransactionModel> transactions;
  final VoidCallback? onViewAll;

  const RecentTransactions({
    super.key,
    required this.transactions, 
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {

    if (transactions.isEmpty) {
      return Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Icon(
                Icons.receipt_long,
                size: 40,
              ),

              const SizedBox(height: 12),

              Text(
                'No transactions yet.',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium,
              ),

              const SizedBox(height: 8),

              const Text(
                'Start adding your income and expenses.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Text(
            'Recent Transactions',
            style: Theme.of(context)
                .textTheme
                .titleMedium,
          ),
        ),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return TransactionCard(
              transaction: transactions[index],
            );
          },
        ),

        if (onViewAll != null)
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: onViewAll,
            child: const Text(
              'View All',
            ),
          ),
        ),
      ],
    );
  }
}