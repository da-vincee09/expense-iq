import 'package:expense_iq/core/theme/app_colors.dart';
import 'package:expense_iq/features/statistics/presentation/widgets/expense_pie_chart.dart';
import 'package:expense_iq/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    if (provider.transactions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Statistics"),
        ),
        body: const Center(
          child: Text(
            "No statistics available yet.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    final totalExpense = provider.totalExpense;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistics"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// SUMMARY
          Text(
            "Overview",
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 16),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.15, // was 1.35
            children: [
              _SummaryCard(
                title: "Balance",
                value: "₱${provider.balance.toStringAsFixed(2)}",
                icon: Icons.account_balance_wallet,
                color: Colors.blue,
              ),
              _SummaryCard(
                title: "Income",
                value: "₱${provider.totalIncome.toStringAsFixed(2)}",
                icon: Icons.arrow_downward,
                color: AppColors.income,
              ),
              _SummaryCard(
                title: "Expenses",
                value: "₱${provider.totalExpense.toStringAsFixed(2)}",
                icon: Icons.arrow_upward,
                color: AppColors.expense,
              ),
              _SummaryCard(
                title: "Transactions",
                value: provider.transactions.length.toString(),
                icon: Icons.receipt_long,
                color: Colors.orange,
              ),
            ],
          ),

          const SizedBox(height: 24),

          Text(
            "Expense Breakdown",
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 16),

          ExpensePieChart(
            expenses: provider.expensesByCategory,
          ),

          const SizedBox(height: 24),

          Text(
            "Expenses by Category",
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 12),

          ...provider.expensesByCategory.entries.map((entry) {

            final percent = totalExpense == 0
                ? 0
                : (entry.value / totalExpense) * 100;

            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.category),
                ),
                title: Text(entry.key),
                subtitle:
                    Text("${percent.toStringAsFixed(1)}%"),
                trailing: Text(
                  "₱${entry.value.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: color.withValues(alpha: .15),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),

            const Spacer(),

            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 4),

            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
