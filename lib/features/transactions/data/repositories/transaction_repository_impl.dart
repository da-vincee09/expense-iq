// ignore_for_file: avoid_print

import 'package:expense_iq/features/transactions/data/models/transaction_model.dart';
import 'package:expense_iq/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      .select()
      .eq('user_id', user.id)
      .order('date', ascending: false);
    
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
          'category': transaction.category,
          'type': transaction.type.name,
          'date': transaction.date.toIso8601String(),
          'note': transaction.note,
        })
        .eq('id', transaction.id)
        .select();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await supabase
        .from('transactions')
        .delete()
        .eq('id', id);
  }
  
}