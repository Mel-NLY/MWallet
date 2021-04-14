import 'package:flutter/material.dart';
import 'package:MWallet/screens/createTransactionRecord.dart';

class CreateTransaction extends StatefulWidget{
  @override
  _CreateTransactionState createState() => new _CreateTransactionState();
}
class _CreateTransactionState extends State<CreateTransaction>{
  void selectedCategory(String c, IconData i){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateTransactionRecord(selectedCategory: c, selectedIcon: i),
        )
    );
  }

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Text(
                      'Expenses',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                new SizedBox(
                    height: 10
                ),
                new Table(
                  children:[
                    new TableRow(
                      children:<Widget>[
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new Icon(Icons.commute),
                                new Text('Transport'),
                              ]
                            ),
                            onPressed:(){selectedCategory("Transportation", Icons.commute);},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new Icon(Icons.fastfood),
                                new Text('Food'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Food", Icons.fastfood);},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new Icon(Icons.shopping_cart),
                                new Text('Shopping'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Shopping", Icons.shopping_cart);},
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
                                new Icon(Icons.request_page),
                                new Text('Bills'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Bills", Icons.request_page);},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new Icon(Icons.airplanemode_active),
                                new Text('Travel'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Travel", Icons.airplanemode_active);},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new Icon(Icons.trending_up),
                                new Text('Groceries'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Groceries", Icons.trending_up);},
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
                                new Icon(Icons.music_video),
                                new Text('Fun'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Entertainment", Icons.music_video);},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new Icon(Icons.school),
                                new Text('Education'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Education", Icons.school);},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new Icon(Icons.local_hospital),
                                new Text('Health'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Health", Icons.local_hospital);},
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
                                new Icon(Icons.attach_money),
                                new Text('Others'),
                              ],
                            ),
                            onPressed:(){selectedCategory("Others", Icons.attach_money);},
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
                new SizedBox(
                  height: 20
                ),
                new Row(
                  children: <Widget>[
                    new Text(
                     'Income',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                new SizedBox(
                    height: 10
                ),
                new Table(
                  children:[
                    new TableRow(
                      children: <Widget> [
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new Icon(Icons.work),
                                new Text('Salary'),
                              ]
                            ),
                            onPressed:(){selectedCategory("Salary", Icons.work);},
                          ),
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new Icon(Icons.military_tech),
                                new Text('Awards'),
                              ]
                            ),
                            onPressed:(){selectedCategory("Awards", Icons.military_tech);},
                          )
                        ),
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new Icon(Icons.replay),
                                new Text('Refund'),
                              ]
                            ),
                          onPressed:(){selectedCategory("Refunds", Icons.replay);},
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                new SizedBox(
                    height: 20
                ),
                new Row(
                  children: <Widget>[
                    new Text(
                      'Transfer',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                new SizedBox(
                    height: 10
                ),
                new Table(
                  children:[
                    new TableRow(
                      children: <Widget> [
                        new TableCell(
                          child: new FlatButton(
                            child: new Column(
                              children: <Widget>[
                                new Icon(Icons.save_alt),
                                new Text('Transfer'),
                              ]
                            ),
                            onPressed:(){selectedCategory("Transfers", Icons.save_alt);},
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
}