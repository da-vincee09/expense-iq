// ignore_for_file: avoid_print

import 'package:expense_iq/features/transactions/data/models/transaction_model.dart';
import 'package:expense_iq/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Handles transaction data operations.
///
/// Manages retrieving, creating, updating, and deleting
/// user transactions through Supabase database services.
class TransactionRepositoryImpl implements TransactionRepository{
  final SupabaseClient supabase;

  TransactionRepositoryImpl({required this.supabase});

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final user = supabase.auth.currentUser;

    if(user == null) {
      throw Exception("User not authenticated.");
    }

   final response = await supabase
    .from('transactions')
    .select('''
      *,
      categories (
        id,
        user_id,
        name,
        type,
        icon,
        created_at
      )
      ''')
    .eq('user_id', user.id)
    .order(
      'date',
      ascending: false,
    );

    print(response);
  
    return response.map<TransactionModel>(
      (json) => TransactionModel.fromJson(json)
    ).toList();
  }

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    await supabase
      .from('transactions')
      .insert(transaction.toInsertJson());
  }

  @override
  Future<void> updateTransaction(TransactionModel transaction) async {
    await supabase
        .from('transactions')
        .update({
          'title': transaction.title,
          'amount': transaction.amount,
          'category_id': transaction.categoryId,
          'type': transaction.type.name,
          'date': transaction.date.toIso8601String(),
          'note': transaction.note,
        })
        .eq('id', transaction.id);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await supabase
        .from('transactions')
        .delete()
        .eq('id', id);
  }
  
}