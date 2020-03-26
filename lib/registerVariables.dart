import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

String password;
int adhhar;
int mobile;
String fatherName;

List<String> firstName = [];
List<String> state = [];
List<int> isInfected = [0, 0, 0, 0, 0];
List<int> haveTravelled = [0, 0, 0, 0, 0];
List<String> country = [];
List<String> fromDate = [];
List<String> toDate = [];
List<int> gender = [0, 0, 0, 0, 0];
TextEditingController name1Editor = new TextEditingController();
TextEditingController name2Editor = new TextEditingController();
TextEditingController name3Editor = new TextEditingController();
TextEditingController name4Editor = new TextEditingController();
TextEditingController name5Editor = new TextEditingController();
TextEditingController name6Editor = new TextEditingController();
List<TextEditingController> editor = [
  name1Editor,
  name2Editor,
  name3Editor,
  name4Editor,
  name5Editor,
  name6Editor
];

void makePost(
    int username,
    String name,
    String password,
    String fatherName,
    String state,
    String district,
    String village,
    int lat,
    int long,
    bool infected,
    bool travel,
    String country) async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/register";
  var body = {
    "username": username,
    "first_name": name,
    "password": password,
    "father_name": fatherName,
    "state": state,
    "district": district,
    "village": village,
    "latitude": lat,
    "longitude": long,
    "is_infected": infected,
    "travelled": travel,
    "travel_country": country,
    "from_date": null,
    "to_date": null
  };
  Response r = await post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );
  print(r.body);
}
