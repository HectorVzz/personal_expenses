import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  _TransactionListState createState() => _TransactionListState(transactions);
}

class _TransactionListState extends State<TransactionList> {
  final List<Transaction> _userTransactions;

  _TransactionListState(this._userTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _userTransactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 20,),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                    child: Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 2),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Text(
                          '\$ ${_userTransactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.deepPurple,
                          )),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userTransactions[index].title,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(DateFormat('dd/MM/yyyy')
                              .format(_userTransactions[index].date)
                              .toString())
                        ]),
                  ],
                ));
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
