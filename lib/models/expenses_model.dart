// To parse this JSON data, do
//
//     final expenses = expensesFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Expenses expensesFromJson(String str) => Expenses.fromJson(json.decode(str));

String expensesToJson(Expenses data) => json.encode(data.toJson());

class Expenses {
    String description;
    int amount;
    String category;
    String docid;
    Timestamp date;

    Expenses({
        required this.description,
        required this.amount,
        required this.category,
        required this.docid,
        required this.date,
    });

    factory Expenses.fromJson(Map<String, dynamic> json) => Expenses(
        description: json["description"],
        amount: json["amount"],
        category: json["category"],
        docid: json["docid"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "amount": amount,
        "category": category,
        "docid": docid,
        "date": date,
    };
}
