import 'package:flutter/material.dart';
import 'package:MWallet/codes/transaction.dart';

class CreateTransaction extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State<CreateTransaction>{
  Transaction _newTransaction = new Transaction();

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Transaction'),
      ),
      body: new Center(
        child: new SingleChildScrollView(
          child: new Container(
            padding: new EdgeInsets.all(16.0),
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Text('Expenses'),
                    new Row(
                      children: <Widget>[
                        new IconButton(
                          icon: new Icon(Icons.directions_bus),
                        ),
                        new Text('Public Transport'),
                        new IconButton(
                          icon: new Icon(Icons.fastfood),
                        ),
                        new Text('Food'),
                      ],
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[

                  ],
                ),
                new Row(
                  children: <Widget>[

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}