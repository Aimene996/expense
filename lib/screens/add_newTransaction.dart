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
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  late DateTime selectedTime;

  void submited() {
    final entredName = titleController.text;
    final entredAmount = amountController.text;
    if (entredAmount.isEmpty) {
      return;
    }
    if (entredName.isEmpty || entredAmount.isEmpty || selectedTime == null) {
      return;
    }
    widget.addTx(titleController.text, double.parse(amountController.text),
        selectedTime);
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
      if (selectedTime == null) {
        return;
      }
      setState(() {
        selectedTime = value!;
        print(selectedTime);
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
              onSubmitted: (_) => submited,
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              onSubmitted: (_) => submited,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            Row(
              children: <Widget>[
                // ignore: unnecessary_null_comparison
                Text(selectedTime == null
                    ? 'No Date Selected'
                    : DateFormat.yMd().format(selectedTime)),
                TextButton(
                    onPressed: selectDate, child: Text('Select Date Time'))
              ],
            ),
            TextButton(
              child: Text('Add Transaction'),
              onPressed: () {
                submited();
              },
            ),
          ],
        ),
      ),
    );
  }
}
