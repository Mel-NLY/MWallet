import 'package:flutter/material.dart';
import 'package:MWallet/screens/home.dart';
import 'package:MWallet/codes/transaction.dart';

DateTime _selectedMonth;

class History extends StatefulWidget{
  @override
  _HistoryState createState() => new _HistoryState();
}

class _HistoryState extends State<History>{
  List<DropdownMenuItem<DateTime>> _dropdownMenuItems;

  @override
  void initState() {
    _dropdownMenuItems = buildDropDownMenuItems(accountList);
  }

  List<DropdownMenuItem<DateTime>> buildDropDownDateTimes(List listItems){
    List<DropdownDateTimes<DateTime>> items = List();
    for (Transaction listItem in listItems){
      items.add(
        new DropdownMenuItem(
          child: new Text(listItem.date.toString()),
          value: listItem,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Transaction History"),
      ),
      body: new Container(
        child: new Center(
          child: new Container(
            padding: EdgeInsets.only(top: 50.0, left:10.0, right: 10.0),
            child: new Column(
              children: <Widget>[
                new DropdownButton<DateTime>(
                  hint: new Text('Filter By Month'),
                  value: _selectedMonth,
                  onChanged: (newValue){
                    setState(() {
                      _selectedMonth = newValue;
                    });
                  },
                  items: transactionList.map((transaction){
                    return DropdownMenuItem(
                      child: new Text(transaction),
                      value: transaction,
                    );
                  })
                )
              ],
            ),
          ),
        )
      ),
    ),
  }
}