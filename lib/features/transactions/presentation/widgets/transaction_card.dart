import 'package:expense_iq/core/enums/transaction_type.dart';
import 'package:expense_iq/core/router/app_routes.dart';
import 'package:expense_iq/core/theme/app_colors.dart';
import 'package:expense_iq/features/transactions/data/models/transaction_model.dart';
import 'package:expense_iq/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({
    super.key,
    required this.transaction,
  });


  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title: const Text(
            'Delete Transaction?',
          ),

          content: const Text(
            'This action cannot be undone.',
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
              ),
            ),


            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await context
                    .read<TransactionProvider>()
                    .deleteTransaction(
                      transaction.id,
                    );
              },

              child: const Text(
                'Delete',
              ),
            ),

          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    final isExpense = transaction.type == TransactionType.expense;
    final categoryName = transaction.category?.name ?? 'Unknown';

    return InkWell(

      onTap: () {
        context.push(
          AppRoutes.addTransaction,
          extra: transaction,
        );
      },


      child: Card(

        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),


        child: ListTile(

          leading: CircleAvatar(
            child: Icon(
              isExpense
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
            ),
          ),


          title: Text(
            transaction.title,
          ),


          subtitle: Text(
            categoryName,
          ),


          trailing: Row(
            mainAxisSize: MainAxisSize.min,

            children: [

              Text(
                '${isExpense ? '-' : '+'}₱${transaction.amount.toStringAsFixed(2)}',

                style: TextStyle(
                  color: isExpense
                      ? AppColors.expense
                      : AppColors.income,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),


              PopupMenuButton<String>(

                onSelected: (value) {

                  if (value == 'delete') {
                    _showDeleteDialog(context);
                  }

                },


                itemBuilder: (context) => [

                  const PopupMenuItem(
                    value: 'delete',

                    child: Row(
                      children: [

                        Icon(
                          Icons.delete,
                        ),

                        SizedBox(
                          width: 8,
                        ),

                        Text(
                          'Delete',
                        ),

                      ],
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}