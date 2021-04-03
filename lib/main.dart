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
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_core/firebase_core.dart';

//Create launch page (Add some animation)
//Error Handling https://medium.com/flutter-community/error-handling-in-flutter-98fce88a34f0
//App logo shows
//Remove local db
//Do up adding of amount for salary

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

  void initState() {
    super.initState();
    _query();

    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(resumeCallBack: () async => setState(() {
          _query();
        }))
    );
    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(inactiveCallBack: () async => setState(() {
        }))
    );
    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(pausedCallBack: () async => setState(() {
        }))
    );
    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(suspendingCallBack: () async => setState(() {
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

  void _query() async {
    List<Account> accountList = new List<Account>();
    List<Transaction> transactionList = new List<Transaction>();
    Account _acc = new Account();

    final accData = await FirebaseFirestore.instance.collection('accounts').get();
    accData.docs.forEach((accResult) async {
      _acc.name = accResult.id;
      _acc.balance = accResult["balance"];
      _acc.accountType = accResult["accountType"];
      print("ACCOUNT BALANCE " + _acc.balance.toString());
      final transData = await FirebaseFirestore.instance.collection('accounts').doc(accResult.id).collection("transactions").get();
      Transaction _trans = Transaction();
      transData.docs.forEach((transResult){
        _trans.amount = transResult["amount"].toDouble();
        _trans.date =  DateTime.parse(transResult["date"]);
        List _hm = transResult["time"].split(":");
        _trans.time = TimeOfDay(hour:int.parse(_hm[0]), minute: int.parse(_hm[1]));
        _trans.note = transResult["note"];
        _trans.categoryType.name = transResult["categoryType"];
        transactionList.add(_trans);
        _acc.accTransactionList.add(_trans);
        print("ACCOUNT BALANCE TRANSACTION AMOUNT" + _trans.amount.toString());
      });
      accountList.add(_acc);
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
