import 'dart:ui';

import 'package:MWallet/codes/account.dart';
import 'package:flutter/material.dart';
import 'package:MWallet/codes/transaction.dart';
import 'package:MWallet/screens//home.dart';

class CreateTransactionRecord extends StatelessWidget{
  //Declare a field to hold the selected category
  final String selectedCategory;
  final IconData selectedIcon;

  //In the constructor we require a String
  CreateTransactionRecord({Key key, @required this.selectedCategory, @required this.selectedIcon}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final dateController = TextEditingController();
    DateTime pickedDate;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Create Transaction'),
      ),
      body: new Center(
        child: Card(
          child: new Container(
            padding: new EdgeInsets.all(16.0),
            child: new Column(
              children:<Widget>[
                new Row(
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Icon(selectedIcon),
                        new FlatButton(
                          child: new Text(
                            "Change",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: (){Navigator.of(context).pushNamedAndRemoveUntil('/CreateTransaction', (Route<dynamic> route) => false);}
                        )
                      ],
                    ),
                    new Expanded(
                      child: new Column(
                        children:<Widget>[
                          new TextField(
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              prefixText: '- \$',
                            ),
                            keyboardType: TextInputType.number,
                            controller: amountController,
                          ),
                        ],
                      ),
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

//StatefulWidget
class _DropdownButton extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State<DropdownButton>{
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        items: accountList.map<DropdownMenuItem<Account>>((Account value){
          return DropdownMenuItem<Account>(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
        onChanged: null
    );
  }
}