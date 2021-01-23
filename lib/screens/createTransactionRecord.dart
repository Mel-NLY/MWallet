import 'package:MWallet/codes/account.dart';
import 'package:flutter/material.dart';
import 'package:MWallet/codes/transaction.dart';
import 'package:MWallet/screens//home.dart';

class CreateTransactionRecord extends StatelessWidget{
  //Declare a field to hold the selected category
  final String selectedCategory;
  final IconData selectedIcon;

  //In the constructor we require a String
  CreateTransactionRecord({Key key, @required this.selectedCategory, @required this.selectedIcon}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final titleController = TextEditingController();
    final amountController = TextEditingController();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Create Transaction'),
      ),
      body: new Center(
        child: Card(
          child: new Container(
            padding: new EdgeInsets.all(16.0),
            child: new Column(
              children:<Widget>[
                new Row(
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Icon(selectedIcon),
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
                    new Expanded(
                      child: new Column(
                        children:<Widget>[
                          new TextField(
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              prefixText: '- \$',
                            ),
                            keyboardType: TextInputType.number,
                            controller: amountController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Text("Wallet: "),
                    _DropdownButton()
                  ],
                ),
                _DatePicker(),
                _TimePicker()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//StatefulWidget for Dropdownbutton
class _DropdownButton extends StatefulWidget{
  @override
  _State createState() => new _State();
}
class _State extends State<_DropdownButton>{
  String dropdownValue = 'Choose';

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24.0,
      elevation: 16,
      style: new TextStyle(color: Colors.blue),
      underline: new Container(
        height: 2,
        color: Colors.blue
      ),
      items: accountList.map<DropdownMenuItem<String>>((Account value){
        return DropdownMenuItem<String>(
          value: value.name,
          child: new Text(value.name)
        );
      }).toList(),
      onChanged: (String newValue){
        setState(() {
          dropdownValue = newValue;
        });
      }
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
    dateController.text = picked.toString();
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
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
              enabled: false,
            ),
          ),
          FlatButton(
            onPressed: (){_selectDate(context);},
            child: Text(
              'Choose Date',
              style: TextStyle(
                color: Colors.purple,
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
    timeController.text = picked.toString();
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
              'Choose Date',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}