import 'package:flutter/material.dart';
import 'package:xpenses/components/chart.dart';
import 'dart:math';
import 'package:xpenses/components/transaction_form.dart';
import 'package:xpenses/components/trasanction_list.dart';
import 'package:xpenses/models/transaction.dart';

main() => runApp(XpensesApp());

class XpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Continha safada',
      value: 39.99,
      date: DateTime.now().subtract(Duration(days: 0)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo tênis de corrida',
      value: 10.76,
      date: DateTime.now().subtract(Duration(days: 0)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't3',
      title: 'Aluguel do AP',
      value: 100.00,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't4',
      title: 'Conta de Agua',
      value: 40.30,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't5',
      title: 'Compras do Mês',
      value: 11.99,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't6',
      title: 'Gastos na balada',
      value: 25.25,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't7',
      title: 'Ingresso showd',
      value: 90.68,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    //usado para fechar o modal
    Navigator.of(context).pop();
  }

  _removeTransaction(String id){
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xpenses"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentsTransactions: _recentTransactions),
            TransactionList(transactions: _transactions, onRemove: _removeTransaction,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
