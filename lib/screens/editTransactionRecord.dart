import 'package:MWallet/codes/account.dart';
import 'package:flutter/material.dart';
import 'package:MWallet/codes/transaction.dart';
import 'package:MWallet/screens/home.dart';
import 'package:intl/intl.dart';

Account _selectedAccount;

class EditTransactionRecord extends StatefulWidget{
  //Declare a field to hold the selected category
  final Transaction selectedTransaction;

  //In the constructor we require a String
  EditTransactionRecord({@required this.selectedTransaction});

  @override
  _EditTransactionRecordState createState() => _EditTransactionRecordState();
}

class _EditTransactionRecordState extends State<EditTransactionRecord>{
  @override
  void initState() {
    _selectedAccount = new Account();
    print(widget.selectedTransaction.categoryType.name);
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Edit Transaction'),
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
                            new Icon(
                              widget.selectedTransaction.categoryType.name == "Transportation" ? Icons.commute :
                              widget.selectedTransaction.categoryType.name == "Food" ? Icons.fastfood :
                              widget.selectedTransaction.categoryType.name == "Shopping" ? Icons.shopping_cart :
                              widget.selectedTransaction.categoryType.name == "Bills" ? Icons.request_page :
                              widget.selectedTransaction.categoryType.name == "Travel" ? Icons.airplanemode_active :
                              widget.selectedTransaction.categoryType.name == "Groceries" ? Icons.trending_up :
                              widget.selectedTransaction.categoryType.name == "Entertainment" ? Icons.music_video :
                              widget.selectedTransaction.categoryType.name == "Education" ? Icons.school :
                              widget.selectedTransaction.categoryType.name == "Health" ? Icons.local_hospital :
                              widget.selectedTransaction.categoryType.name == "Others" ? Icons.attach_money :

                              widget.selectedTransaction.categoryType.name == "Salary" ? Icons.work :
                              widget.selectedTransaction.categoryType.name == "Awards" ? Icons.military_tech :
                              widget.selectedTransaction.categoryType.name == "Refunds" ? Icons.replay :  Icons.save_alt
                            ),
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
                        _AmtTextField(selectedTransaction: widget.selectedTransaction)
                      ],
                    ),
                    _DropdownButton(selectedTransaction: widget.selectedTransaction),
                    _DatePicker(selectedTransaction: widget.selectedTransaction),
                    _TimePicker(selectedTransaction: widget.selectedTransaction),
                    _Notes(selectedTransaction: widget.selectedTransaction),
                    new SizedBox(
                      height: 20,
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
                        child: new Text("Save Changes"),
                        onPressed: (){

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
                        child: new Text("Delete Transaction"),
                        onPressed: (){

                        },
                      ),
                    ),
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
  //Declare a field to hold the selected category
  final Transaction selectedTransaction;

  //In the constructor we require a String
  _AmtTextField({ Key key, this.selectedTransaction}): super(key: key);

  @override
  _AmtTextFieldState createState() => new _AmtTextFieldState();
}
class _AmtTextFieldState extends State<_AmtTextField>{
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    _amountController.text = widget.selectedTransaction.amount.toString();
  }

  @override
  Widget build(BuildContext context){
    return new Expanded(
      child: new Column(
        children:<Widget>[
          new TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
              prefixText: '- \$',
            ),
            keyboardType: TextInputType.number,
            controller: _amountController,
            onChanged: (String a){
              setState(() {
                widget.selectedTransaction.amount = double.parse(a);
              });
            },
          ),
        ],
      ),
    );
  }
}

//StatefulWidget for Dropdownbutton
class _DropdownButton extends StatefulWidget{
  //Declare a field to hold the selected category
  final Transaction selectedTransaction;

  //In the constructor we require a String
  _DropdownButton({ Key key, this.selectedTransaction}): super(key: key);

  @override
  _State createState() => new _State();
}
class _State extends State<_DropdownButton>{
  List<DropdownMenuItem<Account>> _dropdownMenuItems;

  void initState() {
    _dropdownMenuItems = buildDropDownMenuItems(accountList);
    for (int i = 0; i < accountList.length; i++){
      for (int j = 0; j < accountList[i].accTransactionList.length; j++){
        if (accountList[i].accTransactionList[j] == widget.selectedTransaction) {
          for (int k = 0; k<_dropdownMenuItems.length; k++){
            if (_dropdownMenuItems[k].value == accountList[i]){
              _selectedAccount = _dropdownMenuItems[k].value;
            }
          }
        }
      }
    }
  }

  List<DropdownMenuItem<Account>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<Account>> items = List();
    for (Account listItem in listItems) {
      items.add(
        new DropdownMenuItem(
          child: new Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new DropdownButton<Account>(
        value: _selectedAccount,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24.0,
        elevation: 16,
        style: new TextStyle(color: Colors.blue),
        underline: new Container(
            height: 2,
            color: Colors.blue
        ),
        items: _dropdownMenuItems,
        onChanged: (value){
          setState(() {
            _selectedAccount.name = value.name;
          });
        },
      ),
    );
  }
}

//StatefulWidget for Datepicker
class _DatePicker extends StatefulWidget{
  //Declare a field to hold the selected category
  final Transaction selectedTransaction;

  //In the constructor we require a String
  _DatePicker({ Key key, this.selectedTransaction}): super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}
class _DatePickerState extends State<_DatePicker>{
  final dateController = TextEditingController();

  void initState(){
    dateController.text = DateFormat("dd-MM-yyyy").format(widget.selectedTransaction.date).toString();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: widget.selectedTransaction.date,
        firstDate: new DateTime(2021),
        lastDate: new DateTime(2025)
    );
    if (picked == null) {
      return;
    }
    dateController.text = DateFormat("dd-MM-yyyy").format(picked);
    widget.selectedTransaction.date = picked;
  }

  @override
  Widget build(BuildContext context){
    return new Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 0,
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
  //Declare a field to hold the selected category
  final Transaction selectedTransaction;

  //In the constructor we require a String
  _TimePicker({ Key key, this.selectedTransaction}): super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}
class _TimePickerState extends State<_TimePicker>{
  final timeController = TextEditingController();

  void initState(){
    timeController.text = "${widget.selectedTransaction.time.hour.toString()}:${widget.selectedTransaction.time.minute.toString()}";
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: widget.selectedTransaction.time
    );
    if (picked == null) {
      return;
    }
    timeController.text = "${picked.hour}:${picked.minute}";
    widget.selectedTransaction.time = picked;
  }

  @override
  Widget build(BuildContext context){
    return new Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
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
  //Declare a field to hold the selected category
  final Transaction selectedTransaction;

  //In the constructor we require a String
  _Notes({ Key key, this.selectedTransaction}): super(key: key);

  @override
  _NotesState createState() => _NotesState();
}
class _NotesState extends State<_Notes>{
  final _notesController = TextEditingController();

  void initState(){
    _notesController.text = widget.selectedTransaction.note.toString();
  }

  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: _notesController,
      maxLines: 1,
      autocorrect: true,
      onChanged: (String t){
        setState(() {
          widget.selectedTransaction.note = t;
        });
      },
      decoration: new InputDecoration(labelText: "Notes (Optional)"),
    );
  }
}