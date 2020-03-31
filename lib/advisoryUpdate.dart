import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AdvisoryUpdate extends StatefulWidget {
  @override
  _AdvisoryUpdateState createState() => _AdvisoryUpdateState();
}

TextEditingController titleEditor = new TextEditingController();
TextEditingController detailEditor = new TextEditingController();

void makePost() async {
  String url = "https://covid-mitrc.herokuapp.com/apis/advisory/create";
  var body = {
    "lang": "ENGLISH",
    "title": titleEditor.text,
    "detail": detailEditor.text,
    "is_update": true,
  };
  Response r = await post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );
  print(r.body);
}

class _AdvisoryUpdateState extends State<AdvisoryUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Advisory"),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFF9933),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFFF9933),
          Color(0xFFFFFFFF),
          Color(0xFF138808),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                "Title.",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10.0),
                  ]),
              child: TextField(
                controller: titleEditor,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Details",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 100.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10.0),
                  ]),
              child: Expanded(
                child: TextField(
                  controller: detailEditor,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: 150.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFF3180e4),
                    Color(0xFF564dc2),
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10.0),
                  ]),
              child: MaterialButton(
                onPressed: () {
                  makePost();
                  detailEditor.clear();
                  titleEditor.clear();
                },
                child: Text(
                  "submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
