// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  final Size size;

  NewTransaction({required this.addTx, required this.size});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime? chooseDate;

  final titleController = TextEditingController();

  final amountController = TextEditingController();
  void submited() {
    final entredName = titleController.text;
    final entredAmount = amountController.text;
    if (entredName.isEmpty || entredAmount.isEmpty || chooseDate == null) {
      return;
    }
    widget.addTx(
        titleController.text, double.parse(amountController.text), chooseDate);
    titleController.clear();
    amountController.clear();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        chooseDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
                controller: titleController,
                onSubmitted: (_) => submited,
                decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter expense title',
                    labelStyle: TextStyle(color: Colors.teal),
                    hintStyle: TextStyle(color: Colors.teal),
                    errorStyle: TextStyle(color: Colors.red),
                    filled: true,
                    fillColor: Colors.teal.withOpacity(0.1),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),
                    ))),
            SizedBox(
              height: 17,
            ),
            TextField(
                controller: amountController,
                onSubmitted: (_) => submited,
                decoration: InputDecoration(
                    labelText: 'amount',
                    hintText: 'Enter amount title',
                    labelStyle: TextStyle(color: Colors.teal),
                    hintStyle: TextStyle(color: Colors.teal),
                    errorStyle: TextStyle(color: Colors.red),
                    filled: true,
                    fillColor: Colors.teal.withOpacity(0.1),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),
                    ))),
            Row(
              children: <Widget>[
                Text(chooseDate == null
                    ? 'No Date Selected'
                    : DateFormat().add_yMd().format(chooseDate!)),
                TextButton(
                    onPressed: selectDate, child: Text('Select Date Time'))
              ],
            ),
            InkWell(
              onTap: () {
                submited();
              },
              child: Container(
                height: 60,
                width: 170,
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'add New Trx',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
