// ignore_for_file: use_build_context_synchronously

import 'package:expense_iq/core/enums/transaction_type.dart';
import 'package:expense_iq/core/router/app_routes.dart';
import 'package:expense_iq/features/dashboard/presentation/widgets/budget_progress_card.dart';
import 'package:expense_iq/features/dashboard/presentation/widgets/dashboard_summary.dart';
import 'package:expense_iq/features/dashboard/presentation/widgets/recent_transactions.dart';
import 'package:expense_iq/features/profile/presentation/providers/profile_provider.dart';
import 'package:expense_iq/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TransactionProvider>().loadTransactions();
    });
  }

  Widget _buildBody(
    TransactionProvider transactionProvider,
    ProfileProvider profileProvider,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        bottom: 70,
      ),
      child: Column(
        children: [
          DashboardSummary(
            balance: transactionProvider.balance,
            income: transactionProvider.totalIncome,
            expenses: transactionProvider.totalExpense,
          ),

          BudgetProgressCard(
            monthlyBudget: profileProvider.profile?.monthlyBudget ?? 0,
            spent: transactionProvider.totalExpense,
            remaining: transactionProvider.budgetRemaining(
              profileProvider.profile?.monthlyBudget ?? 0,
            ),
            progress: transactionProvider.budgetProgress(
              profileProvider.profile?.monthlyBudget ?? 0,
            ),
          ),

          RecentTransactions(
            transactions: transactionProvider.recentTransactions,
            onViewAll: () {
              context.push(
                AppRoutes.transactionHistory,
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAddTransactionSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.arrow_upward,
                    color: Colors.red,
                  ),
                  title: const Text('Add Expense'),
                  onTap: () {
                    Navigator.pop(context);

                    context.push(
                      AppRoutes.addTransaction,
                      extra: TransactionType.expense,
                    );
                  },
                ),

                ListTile(
                  leading: const Icon(
                    Icons.arrow_downward,
                    color: Colors.green,
                  ),
                  title: const Text('Add Income'),
                  onTap: () {
                    Navigator.pop(context);

                    context.push(
                      AppRoutes.addTransaction,
                      extra: TransactionType.income,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactionProvider>();
    final profileProvider = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("ExpenseIQ"),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.categories),
            icon: const Icon(Icons.category),
          ),
        ],
      ),
      body: SafeArea(
        child: _buildBody(transactionProvider, profileProvider),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTransactionSheet(),
        child: const Icon(Icons.add),
      ),
    );
  }
}