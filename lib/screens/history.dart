import 'package:flutter/material.dart';
import 'package:MWallet/screens/home.dart';
import 'package:MWallet/codes/transaction.dart';
import 'package:MWallet/screens/editTransactionRecord.dart';
import 'package:intl/intl.dart';

String _selectedMonth = "Show prev months";
List<Transaction> _selectedTransactions = transactionList;

class History extends StatefulWidget{
  @override
  _HistoryState createState() => new _HistoryState();
}

class _HistoryState extends State<History>{
  List<DropdownMenuItem<String>> _dropdownMenuItems;

  @override
  void initState() {
    _dropdownMenuItems = buildDropDownMenuItems();
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(){
    List<DateTime> monthList = List();
    List<DropdownMenuItem<String>> menuItems = List();
    menuItems.add(new DropdownMenuItem(
      child: new Text("Show prev months"),
      value: "Show prev months",
    ),);
    for (Transaction t in transactionList){
      final foundDate = monthList.where((element) => DateFormat('MMMM yyyy').format(element) == DateFormat('MMMM yyyy').format(t.date));
      if (foundDate.isEmpty && DateFormat('MMMM yyyy').format(t.date) != DateFormat('MMMM yyyy').format(DateTime.now())){
        monthList.add(t.date);
        print(t.date);
      }
    }
    for (DateTime m in monthList){
      menuItems.add(
        new DropdownMenuItem(
          child: new Text(DateFormat('MMMM yyyy').format(m)),
          value: DateFormat('MMMM yyyy').format(m),
        ),
      );
    }
    return menuItems;
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
            padding: EdgeInsets.only(top: 10.0, left:10.0, right: 10.0),
            child: new Column(
              children: <Widget>[
                new DropdownButton<String>(
                  hint: new Text('Filter By Month'),
                  value: _selectedMonth,
                  items: _dropdownMenuItems,
                  onChanged: (newValue){
                    final List<Transaction> temp = List();
                    if (newValue != "Show prev months"){
                      for (Transaction t in transactionList){
                        if (DateFormat('MMMM yyyy').format(t.date) == newValue && DateFormat('MMMM yyyy').format(t.date) != DateFormat('MMMM yyyy').format(DateTime.now())){
                          temp.add(t);
                        }
                      }
                    } else{
                      for (Transaction t in transactionList){
                        if (DateFormat('MMMM yyyy').format(t.date) != DateFormat('MMMM yyyy').format(DateTime.now())) {
                          temp.add(t);
                        }
                      }
                    }
                    _selectedTransactions = temp;

                    setState(() {
                      _selectedMonth = newValue;
                    });
                  },
                ),
                new SizedBox(
                  height: 10,
                ),
                new Expanded(
                  child: new ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _selectedTransactions.length,
                    itemBuilder: (BuildContext context, int index){
                      return new Card(
                        margin: new EdgeInsets.all(5.0),
                        shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(color: Color.fromRGBO(240, 240, 240, 1.0))
                        ),
                        child: new InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditTransactionRecord(selectedTransaction: _selectedTransactions[index]),
                                )
                            );
                          },
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                padding: new EdgeInsets.all(13),
                                margin: new EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: new Text(
                                  '\$${_selectedTransactions[index].amount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              new Container(
                                padding: new EdgeInsets.all(18),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      '${_selectedTransactions[index].categoryType.name}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    new Text(
                                      '${_selectedTransactions[index].note}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              new Spacer(),
                              new Container(
                                padding: new EdgeInsets.all(15),
                                child: new Icon(Icons.keyboard_arrow_right, size: 40, color: Colors.grey,),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}