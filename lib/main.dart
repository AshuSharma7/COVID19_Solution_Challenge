import 'package:covid19/chart1.dart';
import 'package:covid19/chatBot.dart';
import 'package:covid19/googleMap.dart';
import 'package:covid19/grid.dart';
import 'package:covid19/homePage.dart';
import 'package:covid19/loginPage.dart';
import 'package:covid19/registerVariables.dart';
import 'package:covid19/tracker.dart';
import 'package:covid19/trackingMap.dart';
import 'package:covid19/userCheck.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'ministrystate.dart' as ministry;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: CheckUser());
  }
}

//POST Request
void makePost() async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/register";
  var body = {
    "username": "1234",
    "first_name": "demo",
    "password": "password",
    "father_name": "",
    "state": "",
    "district": "",
    "village": "",
    "latitude": null,
    "longitude": null,
    "is_infected": false,
    "travelled": false,
    "travel_country": "",
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

class ApiHit extends StatefulWidget {
  @override
  _ApiHitState createState() => _ApiHitState();
}

class _ApiHitState extends State<ApiHit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Demo"),
        ),
        body: Container(
          width: 100,
          height: 100,
          child: MaterialButton(
            onPressed: () {
              makePost();
            },
            child: Text("Post"),
          ),
        ));
  }
}
