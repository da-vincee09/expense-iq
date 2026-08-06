// ignore_for_file: avoid_print

import 'package:expense_iq/core/constants/app_categories.dart';
import 'package:expense_iq/core/constants/app_strings.dart';
import 'package:expense_iq/core/enums/transaction_type.dart';
import 'package:expense_iq/features/transactions/data/models/transaction_model.dart';
import 'package:expense_iq/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:expense_iq/shared/extensions/snackbar_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTransactionScreen extends StatefulWidget {
  final TransactionType type;
  final TransactionModel? transaction;

  const AddTransactionScreen({
    super.key,
    required this.type,
    this.transaction,
  });

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  late String _selectedCategory;

  bool get isEditing => widget.transaction != null;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      final transaction = widget.transaction!;
      _titleController.text = transaction.title;
      _amountController.text = transaction.amount.toString();
      _selectedCategory = transaction.category;
      _selectedDate = transaction.date;
      _noteController.text = transaction.note ?? '';
    } else {
      _selectedCategory =
          widget.type == TransactionType.expense
              ? AppCategories.expense.first
              : AppCategories.income.first;
    }
  }

  Future<void> _selectDate() async{
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate, 
      firstDate: DateTime(2020), 
      lastDate: DateTime(2100),
    );

    if(pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  } 

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) return;

    try {
      final provider = context.read<TransactionProvider>();
      if (isEditing) {
        final updatedTransaction =
            widget.transaction!.copyWith(
              title: _titleController.text.trim(),
              amount: double.parse(
                _amountController.text,
              ),
              category: _selectedCategory,
              type: widget.type,
              date: _selectedDate,
              note: _noteController.text.trim().isEmpty
                  ? null
                  : _noteController.text.trim(),
            );

        await provider.updateTransaction(
          updatedTransaction,
        );

        if (!mounted) return;

        context.showSuccess(
          'Transaction updated successfully!',
        );

      } else {
        final transaction = TransactionModel(
          id: '',
          userId: user.id,
          title: _titleController.text.trim(),
          amount: double.parse(
            _amountController.text,
          ),
          category: _selectedCategory,
          type: widget.type,
          date: _selectedDate,
          note: _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim(),
          createdAt: DateTime.now(),
        );

        await provider.addTransaction(
          transaction,
        );

        if (!mounted) return;

        context.showSuccess(
          'Transaction added successfully!',
        );
      }

      Navigator.pop(context);

    } catch (e) {
      if (!mounted) return;

      context.showError(
        'Failed to save transaction.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? 'Edit Transaction'
              : widget.type == TransactionType.expense
                  ? AppStrings.addExpense
                  : AppStrings.addIncome,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: AppStrings.title,
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if(value == null || value.trim().isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: AppStrings.amount,
                  prefixText: '₱ ',
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount.';
                  }

                  final amount = double.tryParse(value);

                  if (amount == null || amount <= 0) {
                    return 'Enter a valid amount.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: AppStrings.category,
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                items: (widget.type == TransactionType.expense
                        ? AppCategories.expense
                        : AppCategories.income)
                    .map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  if(value == null) return;

                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text:
                      "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                ),
                decoration: const InputDecoration(
                  labelText: AppStrings.date,
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                onTap: _selectDate,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: AppStrings.notes,
                  prefixIcon: Icon(Icons.notes),
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _save, 
                  icon: const Icon(Icons.save),
                  label: const Text(AppStrings.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}