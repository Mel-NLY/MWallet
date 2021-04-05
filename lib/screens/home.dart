import 'package:MWallet/codes/transaction.dart';
import 'package:MWallet/codes/account.dart';
import 'package:MWallet/screens/editTransactionRecord.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Account> accountList = new List<Account>();
List<Transaction> transactionList = new List<Transaction>();
List<Transaction> _currentMonthTransactionList;

bool isEmpty(List<dynamic> tl){
  if (tl.length == 0){
    return true;
  } else{
    return false;
  }
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  double calculateBalance(){
    double _transactionBalance = 0;
    for(int i = 0; i < _currentMonthTransactionList.length; i++){
      _transactionBalance += _currentMonthTransactionList.elementAt(i).amount;
    }
    return _transactionBalance;
  }

  @override
  void initState(){
    transactionList.sort((a,b)=> a.date.millisecondsSinceEpoch.compareTo(b.date.millisecondsSinceEpoch));
    _currentMonthTransactionList = new List<Transaction>();
    for(int i = 0; i < transactionList.length; i++){
      if (DateFormat('MMMM yyyy').format(transactionList[i].date) == DateFormat('MMMM yyyy').format(DateTime.now())){
        _currentMonthTransactionList.add(transactionList[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: new AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.article_outlined,
                size: 30,
                color: Theme.of(context).unselectedWidgetColor,
              ),
              onPressed: (){Navigator.of(context).pushNamed('/History');},
            ),
          ],
        ),
      ),
      body: new Center(
        child: new Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('-\$', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  new Text('${calculateBalance().toStringAsFixed(2)}', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 45)),
                ]
              ),
              new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Colors.black,
                          height: 36,
                        )
                      ),
                    ),
                    new Text('${DateFormat('MMMM yyyy').format(DateTime.now()).toUpperCase()}', style: new TextStyle(color: Colors.black,fontSize: 14)),
                    new Expanded(
                      child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Colors.black,
                          height: 36,
                        )
                      ),
                    ),
                  ]
              ),
              !isEmpty(_currentMonthTransactionList) ? new Expanded(
                child: new ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _currentMonthTransactionList.length,
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
                                builder: (context) => EditTransactionRecord(selectedTransaction: _currentMonthTransactionList[index]),
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
                                '\$${_currentMonthTransactionList[index].amount.toStringAsFixed(2)}',
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
                                    '${_currentMonthTransactionList[index].categoryType.name}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  new Text(
                                    '${_currentMonthTransactionList[index].note}',
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
                )
              )
              : new Column(
                children: [
                  new SizedBox(
                    height: 20,
                  ),
                  new Text(
                    'No Transactions Added Yet!',
                    style: new TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  new SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}