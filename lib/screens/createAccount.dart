
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MWallet/codes/account.dart';

Account _newAccount;

class CreateAccount extends StatefulWidget{
  @override
  _CreateAccountState createState() => _CreateAccountState();
}
class _CreateAccountState extends State<CreateAccount>{
  @override
  void initState(){
    _newAccount = new Account();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Create Account"),
      ),
      body: new SingleChildScrollView(
        child: new Center(
          child: new Card(
            child: new Container(
              padding: new EdgeInsets.all(16.0),
              child: new Column(
                children: <Widget>[
                  _AccountNameField(),
                  //_AccountBalanceField()
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

class _AccountNameField extends StatefulWidget{
  @override
  _AccountNameFieldState createState() => new _AccountNameFieldState();
}
class _AccountNameFieldState extends State<_AccountNameField>{
  final _accountNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
          color: Colors.blueAccent
      ),
      child: new TextField(
        controller: _accountNameController,
        decoration: new InputDecoration(labelText: 'Enter Account Name...'),
        onChanged: (String name){
          setState(() {
            _newAccount.name = name;
          });
        },
      ),
    );
  }
}

class _AccountBalanceField extends StatefulWidget{
  @override
  _AccountBalanceFieldState createState() => new _AccountBalanceFieldState();
}
class _AccountBalanceFieldState extends State<_AccountBalanceField>{
  final _accountBalanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Row(
          children: [
            new Icon(Icons.edit),
            new TextField(
              keyboardType: TextInputType.number,
              controller: _accountBalanceController,
              onChanged: (String bal){
                setState(() {
                  _newAccount.balance = double.parse(bal);
                });
              },
            )
         ],
      )
    );
  }
}