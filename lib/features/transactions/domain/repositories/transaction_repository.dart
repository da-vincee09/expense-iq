import 'package:expense_iq/features/transactions/data/models/transaction_model.dart';

abstract interface class TransactionRepository {
  Future<List<TransactionModel>> getTransactions();

  Future<void> addTransaction(TransactionModel transaction);

  Future<void> updateTransaction(TransactionModel transaction);

  Future<void> deleteTransaction(String id);
}