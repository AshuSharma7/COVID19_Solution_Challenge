import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dashBoardStates.dart' as dash;

class UserData extends StatefulWidget {
  @override
  _UserDataState createState() => _UserDataState();
}

List<Color> orange = [Color(0xFFff9966), Color(0xFFff5e62)];
List<Color> blue = [Color(0xFF36D1DC), Color(0xFF5B86E5)];
List<Color> sweet = [Color(0xFFFF5F6D), Color(0xFFFFC371)];
List<Color> purple = [
  Color(0xFFf80759),
  Color(0xFFbc4e9c),
];

Future<Map> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/aggregates";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Data",
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: FutureBuilder(
          future: getUri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map content = snapshot.data;
              return ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: decorate(blue, Colors.blue[200]),
                          height: MediaQuery.of(context).size.height / 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  content["registered"].toString(),
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Text(
                                "Total registered",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20.0),
                              )
                            ],
                          ),
                          margin: EdgeInsets.all(10.0),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => dash.stateList(
                                    para: "is_infected",
                                  ),
                                ));
                          },
                          child: Container(
                            decoration:
                                decorate(orange, Colors.deepOrange[200]),
                            height: MediaQuery.of(context).size.height / 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    content["infected"].toString(),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      fontSize: 40.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Total Infected",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20.0),
                                )
                              ],
                            ),
                            margin: EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => dash.stateList(
                                    para: "symptoms",
                                  ),
                                ));
                          },
                          child: Container(
                            decoration: decorate(sweet, Colors.deepOrange[300]),
                            height: MediaQuery.of(context).size.height / 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    content["symptoms"].toString(),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      fontSize: 40.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Total Suspected",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20.0),
                                )
                              ],
                            ),
                            margin: EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => dash.stateList(
                                    para: "cured",
                                  ),
                                ));
                          },
                          child: Container(
                            decoration: decorate(purple, Colors.pink[300]),
                            height: MediaQuery.of(context).size.height / 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    content["recovered"].toString(),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      fontSize: 40.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Total Recovered",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20.0),
                                )
                              ],
                            ),
                            margin: EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            } else {
              return Center(
                child: SpinKitChasingDots(color: Colors.black),
              );
            }
          },
        ),
      ),
    );
  }
}

BoxDecoration decorate(List<Color> color, Color shadow) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    gradient: LinearGradient(
      colors: color,
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
    ),
    boxShadow: [
      BoxShadow(
          color: shadow,
          blurRadius: 20.0,
          spreadRadius: 0.1,
          offset: Offset.fromDirection(4.0, -10.0))
    ],
  );
}
