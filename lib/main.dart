import 'package:MWallet/screens/createAccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MWallet/screens/home.dart';
import 'package:MWallet/screens/accounts.dart';
import 'package:MWallet/screens/createTransactionCategory.dart';
import 'package:MWallet/theme.dart';

//Improvements
//- Make sure all variables are private unless otherwise is needed
//- Efficiency

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Navigation',
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new BottomNavBar(),
        '/CreateTransaction': (BuildContext context) => new CreateTransaction(),
        '/CreateAccount': (BuildContext context) => new CreateAccount(),
      },
      theme: myTheme,
      home: new BottomNavBar(),
    );
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
