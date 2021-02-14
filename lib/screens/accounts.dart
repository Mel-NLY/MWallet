import 'package:MWallet/screens/editAccount.dart';
import 'package:flutter/material.dart';
import 'package:MWallet/screens/home.dart';

class Accounts extends StatelessWidget{
  double calculateBalance(){
    double accountBalance = 0;
    for(int i = 0; i < accountList.length; i++){
      accountBalance += accountList.elementAt(i).balance;
    }
    return accountBalance;
  }

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - 340) / 2;
    final double itemWidth = size.width / 2;

    return new Scaffold(
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
              new Text(' \$${calculateBalance().toStringAsFixed(2)}', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              !isEmpty(accountList) ? new Expanded(
                  child: new GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: (itemWidth / itemHeight),),
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
                                    height: 20
                                ),
                                new Text(
                                  '${accountList[index].balance.toStringAsFixed(2)} SGD',
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