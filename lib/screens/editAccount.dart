import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MWallet/codes/account.dart';
import 'package:MWallet/screens/home.dart';

Account _newAccount;

class EditAccount extends StatefulWidget{
  //Declare a field to hold the selected account
  final Account selectedAccount;

  EditAccount({@required this.selectedAccount});

  @override
  _EditAccountState createState() => _EditAccountState();
}
class _EditAccountState extends State<EditAccount>{
  @override
  void initState(){
    _newAccount = widget.selectedAccount;
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Create Account"),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: new SingleChildScrollView(
        child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _AccountNameField(selectedAccount: _newAccount),
              new Container(
                padding : new EdgeInsets.all(16.0),
                child: new Column(
                  children: <Widget>[
                    _AccountBalanceField(selectedAccount: _newAccount),
                    _AccountTypeDropdown(selectedAccount: _newAccount),
                    new Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: new RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            side: BorderSide(color: Colors.black)),
                        padding: EdgeInsets.all(10.0),
                        color: Colors.white,
                        textColor: Colors.black,
                        child: new Text("Save Changes"),
                        onPressed: (){
                          setState(() {
                            for(var i = 0; i < accountList.length; i++){
                              if (accountList[i] == widget.selectedAccount){
                                accountList[i] = _newAccount;
                              }
                            }
                          });

                          Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
                        },
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(bottom: 5.0),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: new RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            side: BorderSide(color: Colors.white)),
                        padding: EdgeInsets.all(10.0),
                        color: Colors.red,
                        textColor: Colors.white,
                        child: new Text("Delete Account"),
                        onPressed: (){
                          setState(() {
                            for (var i = 0; i < accountList.length; i++){
                              if (accountList[i] == widget.selectedAccount){
                                for (var j = 0; j < accountList[i].accTransactionList.length; j++){
                                  for (var k = 0; k < transactionList.length; k++){
                                    if (accountList[i].accTransactionList[j] == transactionList[k]){
                                      transactionList.removeAt(k);
                                      break;
                                    }
                                  }
                                }
                                accountList.removeAt(i);
                                break;
                              }
                            }
                          });
                          Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
                        },
                      ),
                    ),
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
  final Account selectedAccount;

  _AccountNameField({ Key key, this.selectedAccount}): super(key:key);

  @override
  _AccountNameFieldState createState() => new _AccountNameFieldState();
}
class _AccountNameFieldState extends State<_AccountNameField>{
  final _accountNameController = TextEditingController();

  @override
  void initState() {
    _accountNameController.text = widget.selectedAccount.name;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width * 1,
      padding: new EdgeInsets.all(32.0),
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
  final Account selectedAccount;

  _AccountBalanceField({ Key key, this.selectedAccount}): super(key:key);

  @override
  _AccountBalanceFieldState createState() => new _AccountBalanceFieldState();
}
class _AccountBalanceFieldState extends State<_AccountBalanceField>{
  final _accountBalanceController = TextEditingController();

  @override
  void initState() {
    _accountBalanceController.text = widget.selectedAccount.balance.toString();
  }

  @override
  Widget build(BuildContext context) {
    return new TextField(
      decoration: new InputDecoration(labelText: "Account Balance", icon: Icon(Icons.edit)),
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
  final Account selectedAccount;

  _AccountTypeDropdown({@required this.selectedAccount});

  @override
  _AccountTypeDropdownState createState() => new _AccountTypeDropdownState();
}
class _AccountTypeDropdownState extends State<_AccountTypeDropdown>{

  @override
  void initState(){
    _newAccount.accountType = widget.selectedAccount.accountType;
  }

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
