class Account{
  static List<String> accountTypes = <String>["Cash", "Credit Card", "Debit Card", "Bank Account"];

  String accountType = accountTypes.elementAt(0);
  String name = "";
  int balance = 0;
}