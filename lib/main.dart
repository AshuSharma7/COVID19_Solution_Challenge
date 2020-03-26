import 'package:covid19/coronaMonitor.dart';
import 'package:covid19/familyDeclaration.dart';
import 'package:covid19/faqPage.dart';
import 'package:covid19/grid.dart';
import 'package:covid19/languagePage.dart';
import 'package:covid19/loginPage.dart';
import 'package:covid19/slefDeclaration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoronaMonitor(),
    );
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
