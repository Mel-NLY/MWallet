import 'package:flutter/material.dart';
import 'package:MWallet/screens/home.dart';
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
      home: new Home(),
    );
  }
}