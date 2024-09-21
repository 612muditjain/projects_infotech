import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peta/NewExpense.dart';
import 'package:peta/main.dart';

class ExpenseTrackerHomePage extends StatefulWidget {
  @override
  _ExpenseTrackerHomePageState createState() => _ExpenseTrackerHomePageState();
}

class _ExpenseTrackerHomePageState extends State<ExpenseTrackerHomePage> {
  final List<Expense> _userExpenses = [];

  // Function to add a new expense
  void _addNewExpense(String title, double amount, DateTime date, String category) {
    final newExpense = Expense(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
      category: category,
    );

    setState(() {
      _userExpenses.add(newExpense);
    });
  }

  // Function to delete an expense
  void _deleteExpense(String id) {
    setState(() {
      _userExpenses.removeWhere((exp) => exp.id == id);
    });
  }

  // Function to start the Add Expense form
  void _startAddNewExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewExpense(_addNewExpense),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense Tracker'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewExpense(context),
          ),
        ],
      ),
      body: _userExpenses.isEmpty
          ? Center(child: Text('No expenses added yet!'))
          : ListView.builder(
        itemCount: _userExpenses.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(_userExpenses[index].id),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              _deleteExpense(_userExpenses[index].id);
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 40,
              ),
            ),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text('\$${_userExpenses[index].amount}'),
                    ),
                  ),
                ),
                title: Text(_userExpenses[index].title),
                subtitle: Text(
                  DateFormat.yMMMd().format(_userExpenses[index].date),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewExpense(context),
      ),
    );
  }
}
