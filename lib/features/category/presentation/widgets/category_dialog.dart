import 'package:expense_iq/core/enums/transaction_type.dart';
import 'package:flutter/material.dart';

/// Provides a reusable dialog for creating and editing categories.
///
/// Handles category name input, transaction type selection,
/// validation, and returns the entered data through a callback.
class CategoryDialog extends StatefulWidget {
  final String? initialName;
  final TransactionType initialType;
  final String title;
  final String actionText;
  final void Function(
    String name,
    TransactionType type,
  ) onSave;

  const CategoryDialog({
    super.key,
    this.initialName,
    required this.initialType,
    required this.title,
    required this.actionText,
    required this.onSave,
  });

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;

  late TransactionType _selectedType;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(
      text: widget.initialName ?? '',
    );

    _selectedType = widget.initialType;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSave(
      _nameController.text.trim(),
      _selectedType,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter a category name';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<TransactionType>(
              initialValue: _selectedType,
              decoration: const InputDecoration(
                labelText: 'Type',
              ),
              items: TransactionType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _selectedType = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),

        FilledButton(
          onPressed: _save,
          child: Text(widget.actionText),
        ),
      ],
    );
  }
}