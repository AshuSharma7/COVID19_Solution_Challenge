import 'package:covid19/searchPage.dart';
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

double width;
double height;
List<String> states = [];
List<int> centres = [];
String searchQuery;
TextEditingController queryEditor = new TextEditingController();

class _HelpLineState extends State<HelpLine> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help Line no.",
          style: TextStyle(fontSize: 32.0),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      elevation: 20.0,
                      //context: context,
                      title: Text("data"),
                      content: TextField(onSubmitted: (value) {
                        if (states.contains(value)) {
                          searchQuery = value.toUpperCase();
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage()));
                        } else {
                          Navigator.pop(context);
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Wrong query"),
                                  content: Text("Please check keyword"),
                                  actions: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.done),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                );
                              });
                        }
                      }),
                      actions: <Widget>[
                        IconButton(icon: Icon(Icons.done), onPressed: () {})
                      ],
                    );
                  },
                );
              })
        ],
        elevation: 0.0,
        backgroundColor: Color(0xFF3180e4),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF3180e4),
            Color(0xFF564dc2),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
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
                return ListView.builder(
                  itemCount: states.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    helpLineDetails(states[index])));
                      },
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 10.0)
                            ]),
                        child: Center(
                            child: Text(
                          states[index],
                          style: TextStyle(fontSize: 20.0),
                        )),
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      strokeWidth: 10,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}

Widget helpLineDetails(String state) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xFF3180e4),
      title: Text(
        state,
        style: TextStyle(fontSize: 30.0),
      ),
      elevation: 0.0,
      automaticallyImplyLeading: false,
    ),
    body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF3180e4),
            Color(0xFF564dc2),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 10.0)
                          ]),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Phone: " + content[index]["contact"].toString(),
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email: " + content[index]["email"],
                              style: TextStyle(fontSize: 16.0),
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
