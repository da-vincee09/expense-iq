import 'package:expense_iq/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Displays a summary of the user's financial status.
///
/// Shows the current balance along with total income
/// and expenses using reusable summary components.
class DashboardSummary extends StatelessWidget {
  final double balance;
  final double income;
  final double expenses;

  const DashboardSummary({
    super.key,
    required this.balance,
    required this.income,
    required this.expenses,
  });

  String _formatCurrency(double value) {
    return '₱${value.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Balance',
              style: theme.textTheme.titleMedium,
            ),

            const SizedBox(height: 8),

            Text(
              _formatCurrency(balance),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: _SummaryItem(
                    title: 'Income',
                    amount: income,
                    color: AppColors.income,
                    icon: Icons.arrow_downward,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _SummaryItem(
                    title: 'Expenses',
                    amount: expenses,
                    color: AppColors.expense,
                    icon: Icons.arrow_upward,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;
  final IconData icon;

  const _SummaryItem({
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: theme.textTheme.bodyMedium,
          ),

          const SizedBox(height: 4),

          Text(
            '₱${amount.toStringAsFixed(2)}',
            style: theme.textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}