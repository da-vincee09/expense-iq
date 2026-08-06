import 'package:expense_iq/core/enums/transaction_type.dart';

class CategoryModel {
  final String id;
  final String userId;
  final String name;
  final TransactionType type;
  final String? icon;
  final DateTime createdAt;

  const CategoryModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    this.icon,
    required this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      type: TransactionType.values.firstWhere(
        (e) => e.name == json['type'],
      ),
      icon: json['icon'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'type': type.name,
      'icon': icon,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toInsertJson() {
    return {
      'user_id': userId,
      'name': name,
      'type': type.name,
      'icon': icon,
    };
  }

  CategoryModel copyWith({
    String? id,
    String? userId,
    String? name,
    TransactionType? type,
    String? icon,
    DateTime? createdAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}