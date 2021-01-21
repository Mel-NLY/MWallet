import 'package:flutter/material.dart';
import 'package:MWallet/codes/transaction.dart';

class CreateTransactionRecord extends StatelessWidget{
  //Declare a field to hold the selected category
  final String selectedCategory;

  //In the constructor we require a String
  CreateTransactionRecord({Key key, @required this.selectedCategory}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final dateController = TextEditingController();
    DateTime pickedDate;

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
                new TextField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    prefixText: '- \$',
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                ),
              ],
            )
          ),
        ),
      )
    );
  }
}