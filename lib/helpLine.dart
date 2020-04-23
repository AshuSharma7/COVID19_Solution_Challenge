import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'getLangCode.dart' as lang;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HelpLine extends StatefulWidget {
  @override
  _HelpLineState createState() => _HelpLineState();
}

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/helpline";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

List<Color> blue = [Color(0xFF36D1DC), Color(0xFF5B86E5)];
List<Color> sweet = [Color(0xFFFF5F6D), Color(0xFFFFC371)];
double width;
double height;
List<String> states = [];
List<int> centres = [];
String searchQuery;
TextEditingController queryEditor = new TextEditingController();

class _HelpLineState extends State<HelpLine> {
  List<String> data = [];
  void translate(
    List list,
  ) async {
    String langCode = await lang.prefs();
    for (int i = 0; i < list.length; i++) {
      String text = list[i];
      String url =
          "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$text";
      http.Response response = await http.get(url);
      Map content = json.decode(response.body);
      if (!data
          .contains(content["data"]["translations"][0]["translatedText"])) {
        data.add(content["data"]["translations"][0]["translatedText"]);
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
          "Help Line no.",
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(Icons.search),
        //       onPressed: () {
        //         showDialog(
        //           context: context,
        //           builder: (BuildContext context) {
        //             return AlertDialog(
        //               elevation: 20.0,
        //               //context: context,
        //               title: Text("data"),
        //               content: TextField(onSubmitted: (value) {
        //                 if (states.contains(value)) {
        //                   searchQuery = value.toUpperCase();
        //                   Navigator.pop(context);
        //                   Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => SearchPage()));
        //                 } else {
        //                   Navigator.pop(context);
        //                   return showDialog(
        //                       context: context,
        //                       builder: (BuildContext context) {
        //                         return AlertDialog(
        //                           title: Text("Wrong query"),
        //                           content: Text("Please check keyword"),
        //                           actions: <Widget>[
        //                             IconButton(
        //                                 icon: Icon(Icons.done),
        //                                 onPressed: () {
        //                                   Navigator.pop(context);
        //                                 })
        //                           ],
        //                         );
        //                       });
        //                 }
        //               }),
        //               actions: <Widget>[
        //                 IconButton(
        //                     icon: Icon(
        //                       Icons.done,
        //                       color: Colors.black,
        //                     ),
        //                     onPressed: () {})
        //               ],
        //             );
        //           },
        //         );
        //       })
        // ],
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
                for (int i = 0; i < content.length; i++) {
                  if (!states.contains(content[i]["state"])) {
                    states.add(content[i]["state"]);
                  }
                }
                states.sort((a, b) => a.toString().compareTo(b.toString()));
                translate(states);
                if (data.isNotEmpty) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: states.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      helpLineDetails(states[index], index)));
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
                            data[index],
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
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

Widget helpLineDetails(String state, int i) {
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
                      margin: EdgeInsets.all(5.0),
                      //height: 100.0,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                          colors: i % 2 == 0 ? blue : sweet,
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: i % 2 == 0
                                  ? Colors.blue[300]
                                  : Colors.deepOrange[300],
                              blurRadius: 10.0,
                              spreadRadius: 0.1,
                              offset: Offset.fromDirection(4.0, -6.0))
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Phone: " + content[index]["contact"].toString(),
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email: " + content[index]["email"],
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
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
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  strokeWidth: 20.0,
                ),
              );
            }
          },
        )),
  );
}
