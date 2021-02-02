import 'package:flutter/material.dart';

class Transaction{
  double amount = 0;
  DateTime date = new DateTime.now();
  TimeOfDay time = new TimeOfDay.now();
  String note = "";
  static List<Category> categoryTypes = <Category>[
    new Category("Transportation", "Expenses"),
    new Category("Food", "Expenses"),
    new Category("Shopping", "Expenses"),
    new Category("Bills", "Expenses"),
    new Category("Travel", "Expenses"),
    new Category("Groceries", "Expenses"),
    new Category("Entertainment", "Expenses"),
    new Category("Education", "Expenses"),
    new Category("Health", "Expenses"),
    new Category("Others", "Expenses"),
    new Category("Salary", "Income"),
    new Category("Awards", "Income"),
    new Category("Refunds", "Income"),
    new Category("Transfers", "Transfer"),
  ];

  Category categoryType = categoryTypes.elementAt(0);
}

class Category{
  String name = "";
  String category = "";

  Category(this.name, this.category);
}