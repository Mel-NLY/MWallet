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
                              child: Text(
                                '\$${accountList[index].name}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            new Container(
                              padding: EdgeInsets.all(15),
                              child: new Text(
                                '${accountList[index].balance}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ),
                          ],
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
                  SizedBox(
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