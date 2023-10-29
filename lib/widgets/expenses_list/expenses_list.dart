import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;
  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpense});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal),
            ),
            onDismissed: (direction) => removeExpense(expenses[index]),
            key: ValueKey(expenses[index]),
            child: ExpenseItem(expenses[index]));
      },
    );
  }
}
