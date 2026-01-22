import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  final void Function(String title, double amount, String category)
      onAddExpense;

  const AddExpensePage({
    super.key,
    required this.onAddExpense,
  });

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController customCategoryController =
      TextEditingController();

  String selectedCategory = 'Food';

  final List<String> categories = [
    'Food',
    'Travel',
    'Shopping',
    'Bills',
    'Other',
  ];

  void _saveExpense() {
    final String title = titleController.text.trim();
    final double amount =
        double.tryParse(amountController.text.trim()) ?? 0;

    final String finalCategory =
        selectedCategory == 'Other'
            ? customCategoryController.text.trim()
            : selectedCategory;

    if (title.isEmpty || amount <= 0 || finalCategory.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid details')),
      );
      return;
    }

    widget.onAddExpense(title, amount, finalCategory);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    customCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: categories
                  .map((c) =>
                      DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                  if (selectedCategory != 'Other') {
                    customCategoryController.clear();
                  }
                });
              },
            ),
            const SizedBox(height: 16),
            if (selectedCategory == 'Other')
              TextField(
                controller: customCategoryController,
                decoration: const InputDecoration(
                  labelText: 'Custom category',
                  border: OutlineInputBorder(),
                ),
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _saveExpense,
                child: const Text('Add Expense'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
