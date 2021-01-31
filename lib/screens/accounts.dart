import 'package:flutter/material.dart';
import 'package:MWallet/screens/home.dart';

class Accounts extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: new Center(
        child: new Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            children: <Widget>[
              !isEmpty(accountList) ? new Expanded(
                  child: new GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: accountList.length,
                    itemBuilder: (BuildContext context, int index){
                      return new Card(
                        color: accountList[index].accountType == "Cash" ? Colors.lightBlue : accountList[index].accountType == "Bank Account" ? Colors.blueAccent : accountList[index].accountType == "Debit Card" ? Colors.blueGrey : Colors.green,
                        margin: EdgeInsets.all(10.0),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: new Container(
                          padding: EdgeInsets.all(10),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                '${accountList[index].name}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              new Text(
                                '${accountList[index].accountType}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              new SizedBox(
                                  height: 20
                              ),
                              new Text(
                                '${accountList[index].balance.toStringAsFixed(2)} SGD',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}