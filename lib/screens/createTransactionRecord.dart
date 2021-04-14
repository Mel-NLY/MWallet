import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:flutter/material.dart';
import 'package:MWallet/codes/account.dart';
import 'package:MWallet/codes/transaction.dart';
import 'package:MWallet/screens/home.dart';
import 'package:intl/intl.dart';

Transaction _newTransaction;
Account _selectedAccount;
Account _transferAccount;
String categoryCat;

class CreateTransactionRecord extends StatefulWidget{
  //Declare a field to hold the selected category
  final String selectedCategory;
  final IconData selectedIcon;

  //In the constructor we require a String
  CreateTransactionRecord({@required this.selectedCategory, @required this.selectedIcon});

  @override
  _CreateTransactionRecordState createState() => _CreateTransactionRecordState();
}
class _CreateTransactionRecordState extends State<CreateTransactionRecord>{
  @override
  void initState() {
    _newTransaction = new Transaction();
    _selectedAccount = new Account();
    _transferAccount = new Account();
    Transaction.categoryTypes.forEach((x){
      if (x.name == widget.selectedCategory){
        categoryCat = x.category;
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Create Transaction'),
      ),
      body: new SingleChildScrollView(
        child: new Center(
          child: new Card(
            child: new Container(
              padding: new EdgeInsets.all(16.0),
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Column(
                        children: <Widget>[
                          new Icon(widget.selectedIcon),
                          new FlatButton(
                              child: new Text(
                                "Change",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.blueAccent,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onPressed: (){Navigator.of(context).pushNamedAndRemoveUntil('/CreateTransaction', (Route<dynamic> route) => false);}
                          )
                        ],
                      ),
                      _AmtTextField()
                    ],
                  ),
                  _DropdownButton(),
                  if (categoryCat == "Transfer") _TransferDropdownButton(),
                  _DatePicker(),
                  _TimePicker(),
                  _Notes(),
                  new Align(
                    alignment: Alignment.bottomRight,
                    child: new RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: new Text('Submit'),
                      onPressed: (){
                        setState(() {
                          Account _chosenAccount = new Account();
                          Account _toAccount = new Account();
                          for (var i = 0; i < accountList.length; i++) {
                            if (accountList[i].name == _selectedAccount.name && categoryCat == "Income") {
                              _chosenAccount = accountList[i];
                              _chosenAccount.balance += _newTransaction.amount; //Deduct transaction amount from chosen account
                              break;
                            } else if (accountList[i].name == _selectedAccount.name && categoryCat == "Expenses") {
                              _chosenAccount = accountList[i];
                              _chosenAccount.balance -= _newTransaction.amount; //Deduct transaction amount from chosen account
                              break;
                            } else if (accountList[i].name == _selectedAccount.name && categoryCat == "Transfer"){
                              _chosenAccount = accountList[i];
                              for (var i = 0; i < accountList.length; i++) {
                                if (accountList[i].name == _transferAccount.name){ //Need to check again for receiving acc
                                  _toAccount = accountList[i];
                                  _chosenAccount.balance -= _newTransaction.amount;
                                  _toAccount.balance += _newTransaction.amount;
                                }
                              }
                              break;
                            }
                          }
                          for (var i = 0; i < Transaction.categoryTypes.length; i++) {
                            if (Transaction.categoryTypes[i].name == widget.selectedCategory) {
                              _newTransaction.categoryType = Transaction.categoryTypes[i];
                              break;
                            }
                          }
                          widget.selectedCategory != "Transfer" ? FirebaseFirestore.instance
                            .collection('accounts')
                            .doc(_chosenAccount.name)
                            .collection('transactions')
                            .add({
                              'amount': _newTransaction.amount,
                              'date': _newTransaction.date.toString(),
                              'time': _newTransaction.time.hour.toString()+":"+_newTransaction.time.minute.toString(),
                              'note': _newTransaction.note,
                              'categoryType': _newTransaction.categoryType.name
                            }).then((value){
                              _newTransaction.id = value.id; //Get random generated document ID
                            }).catchError((onError){
                              print("Error when adding new transaction");
                            }) : FirebaseFirestore.instance
                            .collection('accounts')
                            .doc(_chosenAccount.name)
                            .collection('transactions')
                            .add({
                              'amount': _newTransaction.amount,
                              'date': _newTransaction.date.toString(),
                              'time': _newTransaction.time.hour.toString()+":"+_newTransaction.time.minute.toString(),
                              'note': _newTransaction.note,
                              'categoryType': _newTransaction.categoryType.name,
                              'receivingAcc': _transferAccount.name
                            }).then((value){
                              _newTransaction.id = value.id; //Get random generated document ID
                            }).catchError((onError){
                              print("Error when adding new transaction");
                            });
                          _chosenAccount.accTransactionList.add(_newTransaction);
                          transactionList.add(_newTransaction);
                          _chosenAccount.accTransactionList.add(_newTransaction);
                          transactionList.add(_newTransaction);
                        });

                        Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
                      }
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

//StatefulWidget for Amount
class _AmtTextField extends StatefulWidget{
  @override
  _AmtTextFieldState createState() => new _AmtTextFieldState();
}
class _AmtTextFieldState extends State<_AmtTextField>{
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return new Expanded(
      child: new Column(
        children:<Widget>[
          new TextField(
            decoration: (categoryCat == "Income") ? new InputDecoration(
              labelText: 'Amount',
              prefixText: '+ \$',
            ) : new InputDecoration(
              labelText: 'Amount',
              prefixText: '- \$',
            ),
            keyboardType: TextInputType.number,
            controller: _amountController,
            onChanged: (String a){
              setState(() {
                _newTransaction.amount = double.parse(a);
              });
            },
          ),
        ],
      ),
    );
  }
}

//StatefulWidget for DropdownButton
class _DropdownButton extends StatefulWidget{
  @override
  _DropdownButtonState createState() => new _DropdownButtonState();
}
class _DropdownButtonState extends State<_DropdownButton>{
  @override
  void initState(){
    _selectedAccount.name = accountList[0].name;
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<String>> items = List();
    for (Account listItem in listItems) {
      items.add(
        new DropdownMenuItem(
          child: new Text(listItem.name),
          value: listItem.name
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        children: [
          new Text('From:     ',
          style: new TextStyle(
            fontSize: 16,
            ),
          ),
          new DropdownButton<String>(
            value: _selectedAccount.name,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24.0,
            elevation: 16,
            style: new TextStyle(color: Colors.blue),
            underline: new Container(
                height: 2,
                color: Colors.blue
            ),
            items: buildDropDownMenuItems(List.from(accountList)),
            onChanged: (value){
              setState(() {
                _selectedAccount.name = value;
              });
            },
          ),
        ],
      )
    );
  }
}

//StatefulWidget for TransferDropdownButton
class _TransferDropdownButton extends StatefulWidget{
  @override
  _TransferDropdownButtonState createState() => new _TransferDropdownButtonState();
}
class _TransferDropdownButtonState extends State<_TransferDropdownButton>{
  @override
  void initState(){
    _transferAccount.name = accountList[0].name;
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<String>> items = List();
    for (Account listItem in listItems) {
      items.add(
        new DropdownMenuItem(
            child: new Text(listItem.name),
            value: listItem.name
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Row(
          children: [
            new Text('To:           ',
              style: new TextStyle(
                fontSize: 16,
              ),
            ),
            new DropdownButton<String>(
              value: _transferAccount.name,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24.0,
              elevation: 16,
              style: new TextStyle(color: Colors.blue),
              underline: new Container(
                  height: 2,
                  color: Colors.blue
              ),
              items: buildDropDownMenuItems(List.from(accountList)),
              onChanged: (value){
                setState(() {
                  _transferAccount.name = value;
                });
              },
            ),
          ],
        )
    );
  }
}

//StatefulWidget for Datepicker
class _DatePicker extends StatefulWidget{
  @override
  _DatePickerState createState() => _DatePickerState();
}
class _DatePickerState extends State<_DatePicker>{
  final dateController = TextEditingController();
  DateTime _date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2021),
        lastDate: new DateTime(2025)
    );
    if (picked == null) {
      return;
    }
    dateController.text = DateFormat("dd-MM-yyyy").format(picked);
    _newTransaction.date = picked;
  }

  @override
  Widget build(BuildContext context){
    return new Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 30,
      ),
      child: new Row(
        children: [
          new Expanded(
            child: new TextField(
              readOnly: true,
              controller: dateController,
              decoration: new InputDecoration(labelText: 'Date'),
              enabled: false,
            ),
          ),
          new FlatButton(
            onPressed: (){_selectDate(context);},
            child: new Text(
              'Choose Date',
              style: new TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}

//StatefulWidget for Timepicker
class _TimePicker extends StatefulWidget{
  @override
  _TimePickerState createState() => _TimePickerState();
}
class _TimePickerState extends State<_TimePicker>{
  final timeController = TextEditingController();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time
    );
    if (picked == null) {
      return;
    }
    timeController.text = "${picked.hour}:${picked.minute}";
    _newTransaction.time = picked;
  }

  @override
  Widget build(BuildContext context){
    return new Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 30,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              readOnly: true,
              controller: timeController,
              decoration: InputDecoration(labelText: 'Time'),
              enabled: false,
            ),
          ),
          FlatButton(
            onPressed: (){_selectTime(context);},
            child: Text(
              'Choose Time',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}

//StatefulWidget for Notes
class _Notes extends StatefulWidget{
  @override
  _NotesState createState() => _NotesState();
}
class _NotesState extends State<_Notes>{
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: _notesController,
      maxLines: 1,
      autocorrect: true,
      onChanged: (String t){
        setState(() {
          _newTransaction.note = t;
        });
      },
      decoration: new InputDecoration(labelText: "Notes (Optional)"),
    );
  }
}

