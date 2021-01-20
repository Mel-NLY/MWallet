import 'package:flutter/material.dart';

class Transaction{
  int amount = 0;
  DateTime date = new DateTime.now();
  TimeOfDay time = new TimeOfDay.now();
  String note = "";
  Map<String, String> category = new Map<String, String>();

  Transaction(){
    category.putIfAbsent("Transportation", () => "Expenses");
    category.putIfAbsent("Groceries", () => "Expenses");
    category.putIfAbsent("Food", () => "Expenses");
    category.putIfAbsent("Shopping", () => "Expenses");
    category.putIfAbsent("Entertainment", () => "Expenses");
    category.putIfAbsent("Bills", () => "Expenses");
    category.putIfAbsent("Education", () => "Expenses");
    category.putIfAbsent("Investments", () => "Expenses");
    category.putIfAbsent("Health", () => "Expenses");
    category.putIfAbsent("Travel", () => "Expenses");
    category.putIfAbsent("Others", () => "Expenses");

    category.putIfAbsent("Salary", () => "Income");
    category.putIfAbsent("Investments", () => "Income");
    category.putIfAbsent("Refunds", () => "Income");

    category.putIfAbsent("Transfers", () => "Transfer");
  }
}