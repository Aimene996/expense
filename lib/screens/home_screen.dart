// ignore_for_file: prefer_const_constructors, unused_import

import 'package:first/color_paleete.dart';
import 'package:first/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions_model.dart';
import 'add_newTransaction.dart';
import 'chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void startAddTrx(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: NewTransaction(
              addTx: _addNewTransaction,
              size: MediaQuery.of(context).size,
            ),
          );
        });
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime selectedTime) {
    final newTx = Transactionsmodel(
      name: txTitle,
      amount: txAmount,
      dateTime: selectedTime,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  final List<Transactionsmodel> _userTransactions = [
    Transactionsmodel(
      id: 't1',
      name: 'New Shoes',
      amount: 69.99,
      dateTime: DateTime.now(),
    ),
    Transactionsmodel(
      id: 't2',
      name: 'Weekly Groceries',
      amount: 16.53,
      dateTime: DateTime.now(),
    ),
  ];
  Iterable<Transactionsmodel> get filtredList {
    return _userTransactions.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ColorHelper colorHelper = ColorHelper();
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenseve'),
        backgroundColor: colorHelper.teal,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _userTransactions.clear();
              });
            },
            child: Icon(Icons.delete),
          ),
          FloatingActionButton(
            onPressed: () {
              startAddTrx(context);
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 0.1),
                      blurRadius: 8)
                ]),
                margin: EdgeInsets.all(20),
                child: Chart(
                  trList: filtredList.toList(),
                ),
              ),
              TransactionsList(
                list: _userTransactions,
                size: size,
              )
            ],
          ),
        ),
      ),
    );
  }
}
