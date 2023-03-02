// ignore_for_file: prefer_const_constructors

import 'package:first/color_paleete.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../models/transactions_model.dart';

class TransactionsList extends StatelessWidget {
  final Size size;
  final List<Transactionsmodel> list;
  final Function deleteTx;
  // ignore: prefer_final_fields

  TransactionsList(
      {super.key,
      required this.size,
      required this.list,
      required this.deleteTx});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.6,
      child: list.isEmpty
          ? Center(
              child: Container(
                height: 200,
                width: 200,
                child: Lottie.network(
                    "https://assets7.lottiefiles.com/packages/lf20_3VDN1k.json"),
              ),
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Center(
                        child: Text("\$ ${list[index].amount.toString()}")),
                  ),
                  title: Text(list[index].name),
                  subtitle:
                      Text(DateFormat.yMMMM().format(list[index].dateTime)),
                  trailing: IconButton(
                      onPressed: () {
                        deleteTx(list[index].id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: ColorHelper().green,
                      )),
                ),
              ),
            ),
    );
  }
}
