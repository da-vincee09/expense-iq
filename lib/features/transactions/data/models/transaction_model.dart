import 'package:expense_iq/core/enums/transaction_type.dart';
import 'package:expense_iq/features/category/data/models/category_model.dart';

/// Represents a financial transaction.
///
/// Stores transaction details including title, amount,
/// category, transaction type, date, notes, and related metadata.
class TransactionModel {
  final String id;
  final String userId;
  final String title;
  final double amount;
  final String categoryId;
  final TransactionType type;
  final DateTime date;
  final String? note;
  final CategoryModel? category;
  final DateTime createdAt;

  const TransactionModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.type,
    required this.date,
    this.note,
    this.category,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TransactionModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      title: json['title'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      categoryId: json['category_id']?.toString() ?? '',

      type: TransactionType.values.firstWhere(
        (e) => e.name == json['type'],
      ),

      date: DateTime.parse(
        json['date'],
      ),

      note: json['note'],

      category: json['categories'] != null
          ? CategoryModel.fromJson(
              json['categories'],
            )
          : null,

      createdAt: DateTime.parse(
        json['created_at'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'amount': amount,
      'category_id': categoryId,
      'type': type.name,
      'date': date.toIso8601String(),
      'note': note,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toInsertJson() {
    return {
      'user_id': userId,
      'title': title,
      'amount': amount,
      'category_id': categoryId,
      'type': type.name,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  TransactionModel copyWith({
    String? id,
    String? userId,
    String? title,
    double? amount,
    String? categoryId,
    TransactionType? type,
    DateTime? date,
    String? note,
    CategoryModel? category,
    DateTime? createdAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      type: type ?? this.type,
      date: date ?? this.date,
      note: note ?? this.note,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}