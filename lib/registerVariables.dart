import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

int mobile;
String fatherName;
List<String> stateList = ["rajsthan", "gujrat"];
List<String> rajsthan = ["Alwar", "Jaipur"];
List<String> gujrat = ["ahemdabad", "surat"];
List<String> defaultList = ["Please Select State First"];
List<List> districtList = [defaultList, rajsthan, gujrat];
Map<String, int> statesID = {
  "rajsthan": 1,
  "gujrat": 2,
};

List<String> firstName = [];
List<bool> haveTravelled = [false, false, false, false, false];
List<String> from = ["", "", "", "", ""];
List<String> to = ["", "", "", "", ""];
List<bool> isInfected = [false, false, false, false, false];
List<bool> haveSymptoms = [false, false, false, false, false];
List<bool> isCured = [false, false, false, false, false];
List<int> adhhar = [0, 0, 0, 0, 0];
List<String> country = ["", "", "", "", ""];
List<String> district = ["", "", "", "", ""];
List<String> fromDate = [];
List<String> toDate = [];
List<String> address = ["", "", "", "", ""];
List<String> state = ["", "", "", "", ""];
bool error = true;
List<Map<String, bool>> symptoms = [
  {"fever": false, "cough": false, "breathing": false},
  {"fever": false, "cough": false, "breathing": false},
  {"fever": false, "cough": false, "breathing": false},
  {"fever": false, "cough": false, "breathing": false},
  {"fever": false, "cough": false, "breathing": false}
];
List<String> gender = ["", "", "", "", ""];
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
TextEditingController a1Editor = new TextEditingController();
TextEditingController a2Editor = new TextEditingController();
TextEditingController a3Editor = new TextEditingController();
TextEditingController a4Editor = new TextEditingController();
TextEditingController a5Editor = new TextEditingController();
List<TextEditingController> adhharEditor = [
  a1Editor,
  a2Editor,
  a3Editor,
  a4Editor,
  a5Editor
];

void makePost(
  String username,
  String name,
  String gender,
  String adhhar,
  bool infected,
  bool symptoms,
  bool travel,
  String from,
  String to,
) async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/member/create";
  var body = {
    "user_id": username,
    "name": name,
    "father_name": "",
    "gender": gender,
    "aadhar": adhhar,
    "is_infected": infected,
    "diabetes": false,
    "symptoms": symptoms,
    "cured": null,
    "travelled": travel,
    "state": "",
    "district": "",
    "from_date": from,
    "to_date": to,
    "latitude": null,
    "longitude": null
  };
  //print(body);
  Response r = await post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );
  print(r.body);
  if (r.statusCode != 200) {
    error = true;
  } else {
    error = false;
  }
  //print(r.body);
}
