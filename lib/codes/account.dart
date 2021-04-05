import 'package:MWallet/codes/transaction.dart';

class Account{
  static List<String> accountTypes = <String>["Cash", "Credit Card", "Debit Card", "Bank Account"];

  String accountType = accountTypes.elementAt(0);
  String name = "";
  double balance = 0;
  List<Transaction> accTransactionList = <Transaction>[];
}

//Add a constructor