import 'package:flutter/material.dart';

/// Displays the user's monthly budget progress.
///
/// Shows budget usage percentage, spending amount,
/// remaining balance, and total monthly budget.
class BudgetProgressCard extends StatelessWidget {
  final double monthlyBudget;
  final double spent;
  final double remaining;
  final double progress;

  const BudgetProgressCard({
    super.key,
    required this.monthlyBudget,
    required this.spent,
    required this.remaining,
    required this.progress,
  });

  String _currency(double value) {
    return '₱${value.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Monthly Budget',
              style: theme.textTheme.titleMedium,
            ),

            const SizedBox(height: 16),

            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              borderRadius: BorderRadius.circular(12),
            ),

            const SizedBox(height: 16),

            Text(
              '${(progress * 100).toStringAsFixed(0)}% used',
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Spent'),
                Text(
                  _currency(spent),
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Remaining'),
                Text(
                  _currency(remaining),
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Budget'),
                Text(
                  _currency(monthlyBudget),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}