import 'package:MWallet/codes/transaction.dart';
import 'package:MWallet/codes/account.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Account> accountList = new List<Account>();
List<Transaction> transactionList = new List<Transaction>();

bool isEmpty(List<dynamic> tl){
  if (tl.length == 0){
    return true;
  } else{
    return false;
  }
}

class Home extends StatelessWidget{

  double calculateBalance(){
    Account a1 = new Account();
    a1.name = "DBS";
    a1.balance = 800;
    accountList.add(a1);

    double accountBalance = 0;
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
              new Card(
                margin: EdgeInsets.all(16.0),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text('Available'),
                          new Text('${calculateBalance()}')
                        ],
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text('Date'),
                          new Text('${DateFormat('MMMM yyyy').format(DateTime.now())}')
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              !isEmpty(transactionList) ? new Expanded(
                child: new ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: transactionList.length,
                  itemBuilder: (BuildContext context, int index){
                    return new Card(
                      margin: EdgeInsets.all(16.0),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Text(
                              '\$${transactionList[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          new Container(
                            padding: EdgeInsets.all(15),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  '${transactionList[index].categoryType.name}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                new Text(
                                  '${transactionList[index].note}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              )
              : Column(
                children: [
                  Text(
                    'No Transactions Added Yet!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}