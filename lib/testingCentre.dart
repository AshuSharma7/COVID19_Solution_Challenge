import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'getLangCode.dart' as lang;

class TestingCentre extends StatefulWidget {
  @override
  _TestingCentreState createState() => _TestingCentreState();
}

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/testing-center";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

List<Color> color1 = [
  Color(0xFF11998e),
  Color(0xFF38ef7d),
];
List<Color> color2 = [
  Color(0xFFFF5F6D),
  Color(0xFFFFC371),
];

double width;
double height;
List<String> states = [];
List<int> centres = [];

class _TestingCentreState extends State<TestingCentre> {
  List<String> translatedState = [];
  void translate() async {
    String langCode = await lang.prefs();
    for (int i = 0; i < states.length; i++) {
      String text = states[i];
      String url =
          "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$text";
      http.Response response = await http.get(url);
      Map content = json.decode(response.body);
      if (!translatedState
          .contains(content["data"]["translations"][0]["translatedText"])) {
        translatedState
            .add(content["data"]["translations"][0]["translatedText"]);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Testing Centre",
          style: TextStyle(fontSize: 32.0, color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: FutureBuilder(
            future: getUri(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List content = snapshot.data;
                for (int i = 0; i < content.length; i++) {
                  if (!states.contains(content[i]["state"])) {
                    states.add(content[i]["state"]);
                  }
                }
                states.sort((a, b) => a.toString().compareTo(b.toString()));
                translate();
                if (true) {
                  return ListView.builder(
                    itemCount: states.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        duration: Duration(milliseconds: 600),
                        position: index,
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            testingCentresDetails(
                                                states[index])));
                              },
                              child: Container(
                                height: 60,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: index % 2 == 0 ? color1 : color2,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black45,
                                        blurRadius: 15.0,
                                        offset: Offset.fromDirection(1.0, 10.0))
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  states[index],
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: SpinKitChasingDots(
                      color: Colors.black,
                    ),
                  );
                }
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: SpinKitChasingDots(
                      color: Colors.black,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}

Widget testingCentresDetails(String state) {
  void translate() async {
    String langCode = await lang.prefs();
    String title;
  }

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text(
        state,
        style: TextStyle(fontSize: 30.0, color: Colors.black),
      ),
      elevation: 0.0,
      automaticallyImplyLeading: false,
    ),
    body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: FutureBuilder(
          future: getUri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List content = snapshot.data;
              return ListView.builder(
                itemCount: content.length,
                itemBuilder: (BuildContext context, int index) {
                  if (content[index]["state"] == state) {
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      //height: 100.0,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: index % 2 == 0 ? color1 : color2,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45,
                              blurRadius: 5.0,
                              offset: Offset.fromDirection(1.0, 3.0))
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            content[index]["name"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            content[index]["detail"],
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return Center(
                child: SpinKitChasingDots(
                  color: Colors.black,
                ),
              );
            }
          },
        )),
  );
}
