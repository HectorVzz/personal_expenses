import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;
  NewTransaction(this.newTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitTransaction() {
    String title = titleController.text;
    double amount = double.parse(amountController.text);
    if (title != '' && amount >= 0 && _selectedDate != null) {
      widget.newTransaction(title, amount, _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
            onSubmitted: (_) => _submitTransaction(),
          ),
          TextField(
            controller: amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitTransaction(),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No date Chosen!'
                      : DateFormat.yMMMMd().format(_selectedDate)),
                ),
                FlatButton(
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: _presentDatePicker,
                  textColor: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
          RaisedButton(
            child: Text('Add Transaction'),
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
            onPressed: _submitTransaction,
          ),
        ]),
      ),
    );
  }
}
