import 'package:flutter/material.dart';
import 'package:MWallet/screens/home.dart';
import 'package:MWallet/screens/accounts.dart';
import 'package:MWallet/screens/createTransactionCategory.dart';

void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Navigation',
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new Home(),
        '/CreateTransaction': (BuildContext context) => new CreateTransaction(),
        // '/Review': (BuildContext context) => new Review(),
      },
      home: new _BottomNavBar(),
    );
  }
}

//StatefulWidget for Bottom Navigation Bar
class _BottomNavBar extends StatefulWidget{
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}
class _BottomNavBarState extends State<_BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold);
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
          backgroundColor: Colors.blue,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
        )
    );
  }
}
