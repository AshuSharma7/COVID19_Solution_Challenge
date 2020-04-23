import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<List<dynamic>> getUri(String a) async {
  String url = 'https://covid-mitrc.herokuapp.com/apis/daily-basis?search=${a}';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

Future<List<dynamic>> getUri2() async {
  String url = 'https://covid-mitrc.herokuapp.com/apis/daily-basis';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

// BuildContext context;
List<String> state = [];
String abs;

List<Color> color1 = [
  Color(0xFF11998e),
  Color(0xFF38ef7d),
];
List<Color> blue = [Color(0xFF36D1DC), Color(0xFF5B86E5)];
List<Color> sweet = [Color(0xFFFF5F6D), Color(0xFFFFC371)];

class DailyBasis extends StatefulWidget {
  @override
  _DailyBasis createState() => _DailyBasis();
}

class _DailyBasis extends State<DailyBasis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daily Requirements",
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
            future: getUri2(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List content = snapshot.data;
                for (int i = 0; i < content.length; i++) {
                  if (!state.contains(content[i]["state"])) {
                    state.add(content[i]["state"]);
                  }
                }
                return ListView.builder(
                  itemCount: state.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => getDaily(state[index])));
                      },
                      child: Container(
                        height: 65,
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                            colors: index % 2 == 0 ? blue : sweet,
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: index % 2 == 0
                                    ? Colors.blue[300]
                                    : Colors.deepOrange[300],
                                blurRadius: 10.0,
                                spreadRadius: 0.1,
                                offset: Offset.fromDirection(4.0, -6.0))
                          ],
                        ),
                        child: Center(
                            child: Text(
                          state[index],
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        )),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: SpinKitChasingDots(color: Colors.black),
                );
              }
            }),
      ),
    );
  }
}

Widget getDaily(String data) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        data,
        style: TextStyle(fontSize: 30.0, color: Colors.black),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
    ),
    body: Container(
        color: Colors.white,
        child: FutureBuilder(
            future: getUri2(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List content = snapshot.data;
                print(snapshot.data);
                return ListView.builder(
                    itemCount: content.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (content[index]["state"] == data) {
                        return Column(
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: color1,
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
                                // width: 300,
                                // height: 110,
                                child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tState:\t" +
                                                  content[index]["state"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tDistrict:\t" +
                                                  content[index]["district"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tArea:\t" +
                                                  content[index]["area"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "\tWard:\t" +
                                                content[index]["ward"],
                                            style: TextStyle(
                                              fontSize: 20.0,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tDate:\t" +
                                                  content[index]["date"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tAuthority:\t" +
                                                  content[index]["authority"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tContact:\t" +
                                                  content[index]["contact"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tPost:\t" +
                                                  content[index]["post"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tFood:\t" +
                                                  content[index]["food"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tVegetable:\t" +
                                                  content[index]["vegetable"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tRation:\t" +
                                                  content[index]["ration"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tFarmer:\t" +
                                                  content[index]["farmer"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                "\tMilk:\t" +
                                                    content[index]["milk"],
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                ),
                                                textAlign: TextAlign.right)),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tOther:\t" +
                                                  content[index]["other"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.left,
                                            )),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tAnnouncement:\t" +
                                                  content[index]
                                                      ["announcement"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(height: 10),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "\tRemarks:\t" +
                                                  content[index]["remarks"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                      ],
                                    )))
                          ],
                        );
                      } else {
                        return Container();
                      }
                    });
              } else {
                return Container();
              }
            })),
  );
}
