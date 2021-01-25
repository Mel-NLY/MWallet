import 'package:flutter/material.dart';
import 'package:MWallet/screens/home.dart';

class Accounts extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: new Center(
        child: new Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            children: <Widget>[
              new Text("Hello")
            ]
          )
        )
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}