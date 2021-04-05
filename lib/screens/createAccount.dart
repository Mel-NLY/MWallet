import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MWallet/codes/account.dart';
import 'package:MWallet/screens/home.dart';

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
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: new SingleChildScrollView(
        child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Container(
                padding : new EdgeInsets.all(20.0),
                child: new Column(
                  children: <Widget>[
                    _AccountNameField(),
                    _AccountBalanceField(),
                    _AccountTypeDropdown(),
                    new SizedBox(height: 20),
                    new Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: new RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            side: BorderSide(color: Colors.black)),
                        padding: EdgeInsets.all(10.0),
                        color: Colors.white,
                        textColor: Colors.black,
                        child: new Text("Add the account!"),
                        onPressed: (){
                          accountList.add(_newAccount);
                          FirebaseFirestore.instance
                            .collection('accounts')
                            .doc(_newAccount.name)
                            .set({
                              'balance': _newAccount.name,
                              'accountType': _newAccount.accountType
                            }).catchError((onError){
                              print("Error when adding new Account");
                            });
                          Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
                        },
                      ),
                    )
                  ]
                )
              )
            ],
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
    return new TextField(
      controller: _accountNameController,
      decoration: new InputDecoration(labelText: "Enter Account Name...", icon: Icon(Icons.edit)),
      onChanged: (String name){
        setState(() {
          _newAccount.name = name;
        });
      },
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
    return new TextField(
      decoration: new InputDecoration(labelText: "Account Balance", icon: Icon(Icons.account_balance)),
      keyboardType: TextInputType.number,
      controller: _accountBalanceController,
      onChanged: (String bal){
        setState(() {
          _newAccount.balance = double.parse(bal);
        });
      },
    );
  }
}

class _AccountTypeDropdown extends StatefulWidget{
  @override
  _AccountTypeDropdownState createState() => new _AccountTypeDropdownState();
}
class _AccountTypeDropdownState extends State<_AccountTypeDropdown>{

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<String>> items = List();
    for (String listItem in listItems) {
      items.add(
        new DropdownMenuItem(
          child: new Text(listItem),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new DropdownButton<String>(
        value: _newAccount.accountType,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24.0,
        elevation: 16,
        style: new TextStyle(color: Colors.blue),
        underline: new Container(
            height: 2,
            color: Colors.blue
        ),
        items: buildDropDownMenuItems(Account.accountTypes),
        onChanged: (value){
          setState(() {
            _newAccount.accountType = value;
          });
        },
      ),
    );
  }
}
