import 'package:expenses/widgets/chart/chart.dart';
import 'package:expenses/widgets/expenses_list/expenses_list.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        amount: 500,
        title: 'Flutter Course',
        date: DateTime.now(),
        category: Category.work),
    Expense(
        amount: 700,
        title: 'Cinema',
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        amount: 300,
        title: 'Cafeteria',
        date: DateTime.now(),
        category: Category.food),
    Expense(
        amount: 1000,
        title: 'Vacation',
        date: DateTime.now(),
        category: Category.travel),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense Removed'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(
                _registeredExpenses.indexOf(expense), expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(child: Text("No expenses found"));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        removeExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: (width < 600)
          ? Column(children: [
              Chart(expenses: _registeredExpenses),
              Expanded(child: mainContent)
            ])
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent)
              ],
            ),
    );
  }
}
