import 'package:MWallet/screens/editAccount.dart';
import 'package:flutter/material.dart';
import 'package:MWallet/screens/home.dart';
import 'package:MWallet/codes/account.dart';

class Accounts extends StatelessWidget{
  //Calculate total of all accounts
  double _calculateBalance(){
    double _accountBalance = 0;
    for(int i = 0; i < accountList.length; i++){
      _accountBalance += _calculateAccBalance(accountList[i]);
    }
    return _accountBalance;
  }

  //Calculate account amount in each account
  double _calculateAccBalance(Account a){
    double _accountBalance = 0;
    for (int j = 0; j < a.accTransactionList.length; j++){
      _accountBalance += a.accTransactionList[j].amount;
    }
    return a.balance-_accountBalance;
  }

  @override
  Widget build(BuildContext context){
    var _size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double _itemHeight = (_size.height - 340) / 3;
    final double _itemWidth = _size.width / 2;

    return new Scaffold(
      appBar: new PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: new AppBar(
              backgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
              elevation: 0,
          ),
      ),
      body: new Stack(
        children: <Widget>[
          new Container(
              height: 95.0,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                color: Color.fromRGBO(240, 240, 240, 1.0),
              )
          ),
          new Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new SizedBox(height: 10),
              new Text('  Total'.toUpperCase(), style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12)),
              new SizedBox(height: 5),
              new Text(' \$${_calculateBalance().toStringAsFixed(2)}', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              new SizedBox(
                  height: 5
              ),
              !isEmpty(accountList) ? new Expanded(
                  child: new GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: (_itemWidth / _itemHeight),),
                    itemCount: accountList.length,
                    itemBuilder: (BuildContext context, int index){
                      return new Card(
                        color: accountList[index].accountType == "Cash" ? Color.fromRGBO( 33, 107, 243, 1.0) : accountList[index].accountType == "Bank Account" ? Color.fromRGBO(65, 33, 243, 1.0) : Color.fromRGBO(33, 212, 243, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: new InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAccount(selectedAccount: accountList[index]),
                              )
                            );
                          },
                          child: new Container(
                            padding: EdgeInsets.all(15),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  '${accountList[index].name}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                new Text(
                                  '${accountList[index].accountType}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                new SizedBox(
                                    height: 25
                                ),
                                new Text(
                                  '${_calculateAccBalance(accountList[index]).toStringAsFixed(2)} SGD',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                )
                : new Column(
                children: [
                  new Text(
                    'No Accounts Added Yet!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  new SizedBox(
                    height: 20,
                  ),
                ],
              ),
              new Container(
                margin: new EdgeInsets.only(bottom: 5.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: new RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(color: Colors.black)),
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  textColor: Colors.black,
                  child: new Text("Add Account"),
                  onPressed: (){Navigator.of(context).pushNamed('/CreateAccount');},
                ),
              )
            ],
          ),
        )
        ]
      )
    );
  }
}