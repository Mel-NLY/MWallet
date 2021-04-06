import 'package:flutter/material.dart';
import 'package:MWallet/screens/editTransactionRecord.dart';
import 'package:MWallet/codes/transaction.dart';

class EditTransactionCategory extends StatefulWidget{
  //Declare a field to hold the selected category
  final Transaction selectedTransaction;

  EditTransactionCategory({@required this.selectedTransaction});

  @override
  _EditTransactionCategoryState createState() => new _EditTransactionCategoryState();
}

class _EditTransactionCategoryState extends State<EditTransactionCategory>{
  void selectedCategory(String c){
    widget.selectedTransaction.categoryType.name = c;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditTransactionRecord(selectedTransaction: widget.selectedTransaction,),
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
                            onPressed:(){selectedCategory("Transportation");},
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
                            onPressed:(){selectedCategory("Food");},
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
                                new Icon(Icons.request_page),
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
                                new Icon(Icons.airplanemode_active),
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
                                new Icon(Icons.trending_up),
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
                                new Icon(Icons.music_video),
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
                                new Icon(Icons.school),
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
                                new Icon(Icons.local_hospital),
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
                                new Icon(Icons.attach_money),
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
                            onPressed:(){selectedCategory("Salary");},
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
                            onPressed:(){selectedCategory("Awards");},
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
                          onPressed:(){selectedCategory("Refunds");},
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
}