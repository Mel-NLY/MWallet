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
    double transactionBalance = 0;
    for(int i = 0; i < transactionList.length; i++){
      transactionBalance += transactionList.elementAt(i).amount;
    }
    return transactionBalance;
  }


  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: new Center(
        child: new Container(
          padding: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('-\$', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  new Text('${calculateBalance().toStringAsFixed(2)}', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 45)),
                ]
              ),
              new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Colors.black,
                          height: 36,
                        )
                      ),
                    ),
                    new Text('${DateFormat('MMMM yyyy').format(DateTime.now()).toUpperCase()}', style: new TextStyle(color: Colors.black,fontSize: 14)),
                    new Expanded(
                      child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Colors.black,
                          height: 36,
                        )
                      ),
                    ),
                  ]
              ),
              !isEmpty(transactionList) ? new Expanded(
                child: new ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: transactionList.length,
                  itemBuilder: (BuildContext context, int index){
                    return new Card(
                      margin: new EdgeInsets.all(5.0),
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(color: Color.fromRGBO(240, 240, 240, 1.0))
                      ),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            padding: new EdgeInsets.all(10),
                            margin: new EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: new Text(
                              '\$${transactionList[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          new Container(
                            padding: new EdgeInsets.all(15),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  '${transactionList[index].categoryType.name}',
                                  style: TextStyle(
                                    fontSize: 15,
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
              : new Column(
                children: [
                  new SizedBox(
                    height: 20,
                  ),
                  new Text(
                    'No Transactions Added Yet!',
                    style: new TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  new SizedBox(
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