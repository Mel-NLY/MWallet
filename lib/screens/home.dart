import 'package:MWallet/codes/transaction.dart';
import 'package:MWallet/codes/account.dart';
import 'package:flutter/material.dart';

List<Account> accountList = new List<Account>();
List<Transaction> transactionList = new List<Transaction>();

class Home extends StatelessWidget{
  int calculateBalance(){
    int accountBalance = 0;
    for(int i = 0; i < accountList.length; i++){
      accountBalance += accountList.elementAt(i).balance;
    }
    return accountBalance;
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: (){Navigator.of(context).pushNamed('/CreateTransaction');},
      ),
      body: new Center(
        child: new Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: new Row(
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Text('Available')
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Text('${calculateBalance()}')
                          ],
                        ),
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Text('Date')
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Text('${DateTime.now().month}')
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}