import 'package:expense_iq/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:expense_iq/features/transactions/presentation/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<TransactionProvider>()
          .loadTransactions();
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

              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.transactions.length,

                  itemBuilder: (context, index) {

                    final transaction =
                        provider.transactions[index];

                    return TransactionCard(
                      transaction: transaction,
                    );
                  },
                ),
    );
  }
}