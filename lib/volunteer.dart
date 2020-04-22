import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Volunteer extends StatefulWidget {
  @override
  _Volunteer createState() => _Volunteer();
}

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/apis/requirements";
  http.Response response = await http.get(url);
  return jsonDecode(response.body);
}

List<Color> blue = [Color(0xFF36D1DC), Color(0xFF5B86E5)];
List<Color> sweet = [Color(0xFFFF5F6D), Color(0xFFFFC371)];

class _Volunteer extends State<Volunteer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Volunteer",
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: FutureBuilder(
          future: getUri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List content = snapshot.data;
              return ListView.builder(
                itemCount: content.length,
                itemBuilder: (BuildContext context, int index) {
                  // textOriginal = content[index]["title"];
                  // translator.translate(textOriginal, to: "hi").then((value) {
                  //   text = value;
                  // });
                  return GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                          colors: index % 2 == 0 ? sweet : blue,
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: index % 2 == 0
                                  ? Colors.deepOrange[300]
                                  : Colors.blue[200],
                              blurRadius: 20.0,
                              spreadRadius: 0.1,
                              offset: Offset.fromDirection(4.0, -10.0))
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            content[index]["house"],
                            // text,
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            content[index]["mobile"].toString(),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  reqDetails(content[index]["mobile"])));
                    },
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget reqDetails(int data) {
  return Scaffold(
    body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: getUri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List content = snapshot.data;
              return ListView.builder(
                itemCount: content.length,
                itemBuilder: (BuildContext context, int index) {
                  if (content[index]["mobile"] == data) {
                    return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(children: <Widget>[
                          SizedBox(height: 30),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                colors: index % 2 == 0 ? sweet : blue,
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: index % 2 == 0
                                        ? Colors.deepOrange[300]
                                        : Colors.blue[200],
                                    blurRadius: 20.0,
                                    spreadRadius: 0.1,
                                    offset: Offset.fromDirection(4.0, -10.0))
                              ],
                            ),
                            child: Center(
                                child: Column(
                              children: <Widget>[
                                Text(
                                  "Ration: " +
                                      content[index]["rashan"].toString(),
                                  style: TextStyle(fontSize: 25.0),
                                  textAlign: TextAlign.start,
                                ),
                                Divider(),
                                Text(
                                  "Gas: " + content[index]["gas"].toString(),
                                  style: TextStyle(fontSize: 25.0),
                                  textAlign: TextAlign.start,
                                ),
                                Divider(),
                                Text(
                                  "Medical: " +
                                      content[index]["medical"].toString(),
                                  style: TextStyle(fontSize: 25.0),
                                  textAlign: TextAlign.start,
                                ),
                                Divider(),
                                Text(
                                  "Remarks: " +
                                      content[index]["remarks"].toString(),
                                  style: TextStyle(fontSize: 25.0),
                                  textAlign: TextAlign.start,
                                ),
                                Divider(),
                                Text(
                                  "Emergency: " +
                                      content[index]["emergency"].toString(),
                                  style: TextStyle(fontSize: 25.0),
                                  textAlign: TextAlign.start,
                                ),
                                Divider(),
                                Text(
                                  "Colony: " +
                                      "   " +
                                      content[index]["colony"].toString(),
                                  style: TextStyle(fontSize: 25.0),
                                  textAlign: TextAlign.start,
                                ),
                                Divider(),
                                Text(
                                  "State: " +
                                      content[index]["state"].toString(),
                                  style: TextStyle(fontSize: 25.0),
                                  textAlign: TextAlign.start,
                                ),
                                Divider(),
                                Text(
                                  "District: " +
                                      content[index]["district"].toString(),
                                  style: TextStyle(fontSize: 25.0),
                                  textAlign: TextAlign.start,
                                ),
                                Divider(),
                                Text(
                                  "House: " +
                                      content[index]["house"].toString(),
                                  style: TextStyle(fontSize: 25.0),
                                  textAlign: TextAlign.start,
                                ),
                                Divider(),
                                Text(
                                  "Phone: " +
                                      content[index]["mobile"].toString(),
                                  style: TextStyle(fontSize: 25.0),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            )),
                          ),
                        ]));
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  strokeWidth: 5.0,
                ),
              );
            }
          },
        )),
  );
}
