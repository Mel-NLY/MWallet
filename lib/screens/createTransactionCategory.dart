import 'package:flutter/material.dart';
import 'package:MWallet/codes/transaction.dart';
import 'package:MWallet/screens/createTransactionRecord.dart';

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
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.commute),
                                ),
                                new Text('Transport'),
                              ]
                            ),
                            onPressed:(){selectedCategory("Transportation");},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.fastfood),
                                ),
                                new Text('Food'),
                                ],
                              ),
                            onPressed:(){selectedCategory("Food");},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.shopping_cart),
                                ),
                                new Text('Shopping'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Shopping");},
                          ),
                        ),
                      ],
                    ),
                    new TableRow(
                      children: <Widget>[
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.request_page),
                                ),
                                new Text('Bills'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Bills");},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.airplanemode_active),
                                ),
                                new Text('Travel'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Travel");},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.trending_up),
                                ),
                                new Text('Groceries'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Groceries");},
                          ),
                        ),
                      ],
                    ),
                    new TableRow(
                      children:<Widget>[
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.music_video),
                                ),
                                new Text('Fun'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Entertainment");},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.school),
                                ),
                                new Text('Education'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Education");},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.local_hospital),
                                ),
                                new Text('Health'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Health");},
                          ),
                        ),
                      ],
                    ),
                    new TableRow(
                      children:<Widget>[
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.attach_money),
                                ),
                                new Text('Others'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Others");},
                          ),
                        ),
                        new TableCell(
                          child: new Container(
                              width:0.0,
                              height: 0.0
                          ),
                        ),
                        new TableCell(
                          child: new Container(
                              width:0.0,
                              height: 0.0
                          ),
                        )
                      ],
                    )
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
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.work),
                                ),
                                new Text('Salary'),
                              ]
                            ),
                            onPressed:(){selectedCategory("Salary");},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.military_tech),
                                ),
                                new Text('Awards'),
                              ]
                            ),
                            onPressed:(){selectedCategory("Awards");},
                          )
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.replay),
                                ),
                                new Text('Refund'),
                              ]
                            ),
                          onPressed:(){selectedCategory("Refunds");},
                          ),
                        ),
                      ],
                    ),
                    new TableRow(
                      children: <Widget>[
                        new TableCell(
                          child: new Container(
                            width: 0.0,
                            height: 0.0,
                          ),
                        ),
                        new TableCell(
                          child: new Container(
                            width: 0.0,
                            height: 0.0,
                          ),
                        ),
                        new TableCell(
                          child: new Container(
                            width: 0.0,
                            height: 0.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Text('Transfer'),
                  ],
                ),
                new Table(
                  children:[
                    new TableRow(
                      children: <Widget> [
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new IconButton(
                                  icon: new Icon(Icons.save_alt),
                                ),
                                new Text('Transfer'),
                              ]
                            ),
                            onPressed:(){selectedCategory("Transfers");},
                          ),
                        ),
                        new TableCell(
                          child: new Container(
                            width: 0.0,
                            height: 0.0,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectedCategory(String c){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateTransactionRecord(selectedCategory: c),
        )
    );
  }
}