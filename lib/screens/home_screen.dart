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
      String txTitle, double txAmount, DateTime dateTimeChoosen) {
    final newTx = Transactionsmodel(
      name: txTitle,
      amount: txAmount,
      dateTime: dateTimeChoosen,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void deleteItem(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
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
      appBar: appBar(colorHelper),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorHelper.teal,
        onPressed: () {
          startAddTrx(context);
        },
        child: Icon(Icons.add),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // ignore: prefer_const_literals_to_create_immutables
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 0.1),
                      blurRadius: 8)
                ]),
                margin: EdgeInsets.all(20),
                child: Container(
                  height: size.height * 0.3 -
                      appBar(colorHelper).preferredSize.height,
                  child: Chart(
                    trList: filtredList.toList(),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.7 -
                    appBar(colorHelper).preferredSize.height,
                child: TransactionsList(
                  list: _userTransactions,
                  size: size,
                  deleteTx: deleteItem,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar(ColorHelper colorHelper) {
    return AppBar(
      title: Text('Expenseve'),
      backgroundColor: colorHelper.teal,
    );
  }
}
