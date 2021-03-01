import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:MWallet/codes/account.dart';
import 'package:MWallet/codes/transaction.dart';
import 'package:MWallet/screens/createAccount.dart';
import 'package:MWallet/screens/home.dart';
import 'package:MWallet/screens/accounts.dart';
import 'package:MWallet/screens/history.dart';
import 'package:MWallet/screens/createTransactionCategory.dart';
import 'package:MWallet/theme.dart';
import 'dart:convert';

import 'package:MWallet/database_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;
  final AsyncCallback inactiveCallBack;
  final AsyncCallback pausedCallBack;
  final AsyncCallback suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.inactiveCallBack,
    this.pausedCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack();
        }
        break;
      case AppLifecycleState.inactive:
        if (inactiveCallBack != null) {
          await inactiveCallBack();
        }
        break;
      case AppLifecycleState.paused:
        if (pausedCallBack != null) {
          await pausedCallBack();
        }
        break;
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          await suspendingCallBack();
        }
        break;
    }
  }
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(resumeCallBack: () async => setState(() {
          _query();
        }))
    );
    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(inactiveCallBack: () async => setState(() {
          dbHelper.delete();
          _insert();
        }))
    );
    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(pausedCallBack: () async => setState(() {
        }))
    );
    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(suspendingCallBack: () async => setState(() {
          print("suspended");
        }))
    );
  }

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Navigation',
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new BottomNavBar(),
        '/CreateTransaction': (BuildContext context) => new CreateTransaction(),
        '/CreateAccount': (BuildContext context) => new CreateAccount(),
        '/History': (BuildContext context) => new History(),
      },
      theme: myTheme,
      home: new BottomNavBar(),
    );
  }

  void _insert() async {
    // row to insert
    for(var i=0;i<accountList.length;i++){
      for(var j=0;j<accountList[i].accTransactionList.length;j++){
        Map<String, dynamic> row = {
          DatabaseHelper.columnName : accountList[i].name,
          DatabaseHelper.columnBal  : accountList[i].balance,
          DatabaseHelper.columnAccType  : accountList[i].accountType,
          DatabaseHelper.columnAmt  : accountList[i].accTransactionList[j].amount,
          DatabaseHelper.columnDate  : accountList[i].accTransactionList[j].date.toString(),
          DatabaseHelper.columnTime  : accountList[i].accTransactionList[j].time.hour.toString()+":"+accountList[i].accTransactionList[j].time.minute.toString(),
          DatabaseHelper.columnNote  : accountList[i].accTransactionList[j].note,
          DatabaseHelper.columnCatType  : accountList[i].accTransactionList[j].categoryType.name
        };
        final id = dbHelper.insert(row);
      }
    }
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    List<Account> accountList = new List<Account>();
    List<Transaction> transactionList = new List<Transaction>();
    Account _acc = new Account();
    allRows.forEach((row) {
      if (!accountList.contains(row.values.toString().substring(1,row.values.toString().length-1).split(', ')[1])){
        _acc.name = row.values.toString().substring(1,row.values.toString().length-1).split(', ')[1];
        _acc.balance = double.parse(row.values.toString().substring(1,row.values.toString().length-1).split(', ')[2]);
        _acc.accountType = row.values.toString().substring(1,row.values.toString().length-1).split(', ')[3];
      } else{
        for (var i=0; i<accountList.length;i++){
          if (accountList[i].name == row.values.toString().substring(1,row.values.toString().length-1).split(', ')[1]){
           _acc = accountList[i];
          }
        }
      }

      Transaction _t = new Transaction();
      _t.amount = double.parse(row.values.toString().substring(1,row.values.toString().length-1).split(', ')[4]);
      print(row.values.toString().substring(1,row.values.toString().length-1).split(', '));
      _t.date = DateTime.parse(row.values.toString().substring(1,row.values.toString().length-1).split(', ')[5]);
      _t.time = TimeOfDay(hour:int.parse(row.values.toString().substring(1,row.values.toString().length-1).split(', ')[6].split(":")[0]), minute: int.parse(row.values.toString().substring(1,row.values.toString().length-1).split(', ')[6].split(":")[1]));
      _t.note = row.values.toString().substring(1,row.values.toString().length-1).split(', ')[7];
      _t.categoryType.name = row.values.toString().substring(1,row.values.toString().length-1).split(', ')[8];
      _acc.accTransactionList.add(_t);
      transactionList.add(_t);
    });
  }
}

//StatefulWidget for Bottom Navigation Bar
class BottomNavBar extends StatefulWidget{
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}
class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<dynamic> _widgetOptions = <dynamic>[
    Home(),
    Accounts(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: (){Navigator.of(context).pushNamed('/CreateTransaction');},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Accounts',
          ),
        ],
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        onTap: _onItemTapped,
      )
    );
  }
}
