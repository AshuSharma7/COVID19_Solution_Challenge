import 'package:flutter/cupertino.dart';

import 'searchPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class TimeSeries extends StatefulWidget {
  @override
  _TimeSeries createState() => _TimeSeries();
}

Future<Map> getUri() async {
  String url = "https://api.covid19india.org/data.json";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

List<Color> color1 = [
  Color(0xFF11998e),
  Color(0xFF38ef7d),
];
List<Color> color2 = [
  Color(0xFFff9966),
  Color(0xFFff5e62),
];

Route createRoute(Widget name) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => name,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOutQuad;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      });
}

double width;
double height;

class _TimeSeries extends State<TimeSeries> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dates",
          style: TextStyle(color: Colors.black, fontSize: 30.0),
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
                Map content = snapshot.data;

                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: content['cases_time_series'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 200),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => timeDetails(
                                          content['cases_time_series'][index]
                                              ["date"])));
                            },
                            child: Container(
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
                              margin: EdgeInsets.all(15.0),
                              width: 300,
                              height: 70,
                              child: Center(
                                  child: Text(
                                content['cases_time_series'][index]["date"],
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
                    size: 50.0,
                  ),
                );
              }
            }),
      ),
    );
  }
}

Widget timeDetails(var date) {
  return Scaffold(
    body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: getUri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map content = snapshot.data;
              return ListView.builder(
                itemCount: content['cases_time_series'].length,
                itemBuilder: (BuildContext context, int index) {
                  if (content['cases_time_series'][index]["date"] == date) {
                    return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            "Data on:- " + date,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: color2,
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
                            margin: EdgeInsets.all(15.0),
                            width: 350,
                            child: Center(
                                child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "\nDaily Confirmed Cases: " +
                                            "\t\t" +
                                            content['cases_time_series'][index]
                                                    ["dailyconfirmed"]
                                                .toString(),
                                        style: TextStyle(fontSize: 20.0),
                                        textAlign: TextAlign.left,
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "\nDaily Deceased: " +
                                          "\t\t" +
                                          content['cases_time_series'][index]
                                                  ["dailydeceased"]
                                              .toString(),
                                      style: TextStyle(fontSize: 20.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "\nDaily Recovered Cases: " +
                                          "\t\t" +
                                          content['cases_time_series'][index]
                                                  ["dailyrecovered"]
                                              .toString(),
                                      style: TextStyle(fontSize: 20.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "\nDate: " +
                                          "\t\t" +
                                          content['cases_time_series'][index]
                                                  ["date"]
                                              .toString(),
                                      style: TextStyle(fontSize: 20.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\nTotal Confirmed Cases: " +
                                              "\t\t" +
                                              content['cases_time_series']
                                                      [index]["totalconfirmed"]
                                                  .toString(),
                                          style: TextStyle(fontSize: 20.0),
                                          textAlign: TextAlign.start,
                                        ))),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "\nTotal Deceased Cases: " +
                                          "\t\t" +
                                          content['cases_time_series'][index]
                                                  ["totaldeceased"]
                                              .toString(),
                                      style: TextStyle(fontSize: 20.0),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "\nTotal Recovered Cases: " +
                                            "\t\t" +
                                            content['cases_time_series'][index]
                                                    ["totalrecovered"]
                                                .toString() +
                                            "\n",
                                        style: TextStyle(fontSize: 20.0),
                                        textAlign: TextAlign.start,
                                      )),
                                ),
                              ],
                            )),
                          )
                        ]));
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return Center(
                child: SpinKitChasingDots(
                  color: Colors.black,
                  size: 50.0,
                ),
              );
            }
          },
        )),
  );
}
