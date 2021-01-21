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
        title: new Text('Choose a category'),
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
                  ],
                ),
                new Table(
                  children:[
                    new TableRow(
                      children:<Widget>[
                        new TableCell(
                          child: new Column(
                            children: <Widget>[
                              new IconButton(
                                icon: new Icon(Icons.commute),
                              ),
                              new Text('Transport'),
                            ]
                          ),
                        ),
                        new TableCell(
                          child: new Column(
                            children: <Widget>[
                              new IconButton(
                                icon: new Icon(Icons.fastfood),
                              ),
                              new Text('Food'),
                            ],
                          ),
                        ),
                        new TableCell(
                          child: new Column(
                            children: <Widget>[
                              new IconButton(
                                icon: new Icon(Icons.shopping_cart),
                              ),
                              new Text('Shopping'),
                            ],
                          ),
                        ),
                        new TableCell(
                          child: new Column(
                            children: <Widget>[
                              new IconButton(
                                icon: new Icon(Icons.attach_money),
                              ),
                              new Text('Bills'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    new TableRow(
                      children: <Widget>[
                        new TableCell(
                          child: new Column(
                            children: <Widget>[
                              new IconButton(
                                icon: new Icon(Icons.airplanemode_active),
                              ),
                              new Text('Travel'),
                            ],
                          ),
                        ),
                        new TableCell(
                          child: new Column(
                            children: <Widget>[
                              new IconButton(
                                icon: new Icon(Icons.trending_up),
                              ),
                              new Text('Investment'),
                            ],
                          ),
                        ),
                        new TableCell(
                          child: new Column(
                            children: <Widget>[
                              new IconButton(
                                icon: new Icon(Icons.anchor),
                              ),
                              new Text('Others'),
                            ],
                          ),
                        ),
                        new TableCell(
                          child: new Container(
                            width: 0.0,
                            height: 0.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Text('Income'),
                  ],
                ),
                new Table(
                  children:[
                    new TableRow(
                      children: <Widget> [
                        new TableCell(
                          child: null
                        ),
                      ],
                    ),
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