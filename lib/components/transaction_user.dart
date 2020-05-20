import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xpenses/components/transaction_form.dart';
import 'package:xpenses/components/trasanction_list.dart';
import 'package:xpenses/models/transaction.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo tênis de corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    ),
    // Transaction(
    //   id: 't3',
    //   title: 'Aluguel do AP',
    //   value: 211.30,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't4',
    //   title: 'Conta de Agua',
    //   value: 211.30,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't5',
    //   title: 'Compras do Mês',
    //   value: 211.30,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't6',
    //   title: 'Gastos na balada',
    //   value: 211.30,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't7',
    //   title: 'Ingresso showd',
    //   value: 211.30,
    //   date: DateTime.now(),
    // ),
  ];

  _addTransaction(String title, double value, DateTime date){
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
      );

      setState(() {
        _transactions.add(newTransaction);
      });
  }

  _removeTransaction(String id){
    setState(() {
      _transactions.retainWhere((tr) {
        return tr.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
          TransactionForm(onSubmit: _addTransaction),
          TransactionList(transactions: _transactions, onRemove: _removeTransaction),
      ],
    );
  }
}