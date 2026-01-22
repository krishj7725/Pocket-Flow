import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import 'add_expense_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Expense> _expenses = [];

  void _addExpense(String title, double amount, String category) {
    setState(() {
      _expenses.add(
        Expense(
          title: title,
          amount: amount,
          category: category,
          date: DateTime.now(),
        ),
      );
    });
  }

  void _openAddExpensePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddExpensePage(onAddExpense: _addExpense),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} '
        '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PocketFlow'),
        centerTitle: true,
      ),
      body: _expenses.isEmpty
          ? const Center(child: Text('No expenses added yet'))
          : ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(expense.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(expense.category),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(expense.date),
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: Text(
                      '₹${expense.amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpensePage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
