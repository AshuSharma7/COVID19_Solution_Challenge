import 'package:flutter_localization_master/localization/language_constants.dart';

import 'searchPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class OuterState extends StatefulWidget {
  @override
  _OuterState createState() => _OuterState();
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

class _OuterState extends State<OuterState> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                  itemCount: content['statewise'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 800),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => stateDetails(
                                          content['statewise'][index]
                                              ["state"])));
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
                              height: 80,
                              child: Center(
                                  child: Text(
                                content['statewise'][index]["state"],
                                style: TextStyle(
                                    fontSize: 22.0, color: Colors.white),
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

Widget stateDetails(var date) {
  return Scaffold(
    body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: FutureBuilder(
          future: getUri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map content = snapshot.data;
              return ListView.builder(
                itemCount: content['statewise'].length,
                itemBuilder: (BuildContext context, int index) {
                  if (content['statewise'][index]["state"] == date) {
                    return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            date + " Data",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Container(
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
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\n" +
                                              getTranslated(context, 'active') +
                                              content['statewise'][index]
                                                      ["active"]
                                                  .toString(),
                                          style: TextStyle(fontSize: 25.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "\n" +
                                            getTranslated(context, 'confirm') +
                                            content['statewise'][index]
                                                    ["confirmed"]
                                                .toString(),
                                        style: TextStyle(fontSize: 25.0),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\n " +
                                              getTranslated(context, 'death') +
                                              content['statewise'][index]
                                                      ["deaths"]
                                                  .toString(),
                                          style: TextStyle(fontSize: 25.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\n" +
                                              getTranslated(context, 'update') +
                                              "\n" +
                                              content['statewise'][index]
                                                      ["lastupdatedtime"]
                                                  .toString(),
                                          style: TextStyle(fontSize: 25.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\n" +
                                              getTranslated(
                                                  context, 'total_cured') +
                                              ":" +
                                              content['statewise'][index]
                                                      ["recovered"]
                                                  .toString() +
                                              "\n",
                                          style: TextStyle(fontSize: 25.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      )),
                                ],
                              )),
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
