import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localization_master/pages/DeclarationForm.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'getLangCode.dart' as lang;

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/hospital";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

var string;
// List<String> states = [];
// List<String> district = [];

List<Color> color1 = [
  Color(0xFF11998e),
  Color(0xFF38ef7d),
];
List<Color> color2 = [
  Color(0xFF8E2DE2),
  Color(0xFF4A00E0),
];

class vrdl extends StatefulWidget {
  @override
  _vrdlState createState() => _vrdlState();
}

class _vrdlState extends State<vrdl> {
  List<String> states = [];
  List<String> translatedStates = [];
  void translate() async {
    String langCode = await lang.prefs();
    for (int i = 0; i < states.length; i++) {
      String state = states[i];
      String url =
          "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$state";
      http.Response response = await http.get(url);
      Map content = json.decode(response.body);
      if (!translatedStates
          .contains(content["data"]["translations"][0]["translatedText"])) {
        translatedStates
            .add(content["data"]["translations"][0]["translatedText"]);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Hospitals",
            style: TextStyle(fontSize: 30.0, color: Colors.black),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFFF9933),
          Color(0xFFFFFFFF),
          Color(0xFF138808),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                translate();
                if (translatedStates.isNotEmpty) {
                  return ListView.builder(
                      itemCount: translatedStates.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => vrdlList(
                                        state: states[index],
                                        content: content)));
                          },
                          child: Container(
                            height: 80,
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width - 100,
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
                            child: Center(
                              child: Text(
                                translatedStates[index],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ),
                          ),
                        );
                      });
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

class vrdlList extends StatefulWidget {
  String state;
  List content;
  vrdlList({Key key, @required this.state, @required this.content})
      : super(key: key);
  @override
  _vrdlListState createState() => _vrdlListState();
}

class _vrdlListState extends State<vrdlList> {
  List<String> districtTranslated = [];
  List<String> district = [];
  void translate() async {
    String langCode = await lang.prefs();

    for (int i = 0; i < widget.content.length; i++) {
      if (widget.content[i]["state"] == widget.state) {
        String data = widget.content[i]["district"];
        String url =
            "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$data";
        http.Response response = await http.get(url);
        Map content = json.decode(response.body);
        if (!districtTranslated
            .contains(content["data"]["translations"][0]["translatedText"])) {
          district.add(content["data"]["translations"][0]["translatedText"]);
          districtTranslated
              .add(content["data"]["translations"][0]["translatedText"]);
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    translate();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.state,
            style: TextStyle(fontSize: 30.0, color: Colors.black),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFFFF9933),
            Color(0xFFFFFFFF),
            Color(0xFF138808),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: districtTranslated.isNotEmpty
              ? ListView.builder(
                  itemCount: districtTranslated.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      detail(district[index])));
                        },
                        child: Container(
                          height: 80,
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width - 100,
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
                          child: Center(
                            child: Text(
                              districtTranslated[index],
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                        ));
                  },
                )
              : Center(
                  child: SpinKitChasingDots(color: Colors.black),
                )),
    );
  }
}

Widget detail(String dis) {
  return Scaffold(
    body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFFF9933),
          Color(0xFFFFFFFF),
          Color(0xFF138808),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: getUri(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List content = snapshot.data;
                return ListView.builder(
                  itemCount: content.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (content[index]["district"] == dis) {
                      return Column(
                        children: <Widget>[
                          Image(image: AssetImage('images/flag.gif')),
                          Container(
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.all(10.0),
                              // width: MediaQuery.of(context).size.width - 100,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: color2,
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
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Name:\t\t\t" + content[index]["name"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      )),
                                  SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Doctor Name:\t\t\t" +
                                          content[index]["doctor_name"],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Hospital Type:\t\t\t" +
                                            content[index]["type"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      )),
                                  SizedBox(height: 10),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Contact Number:\t\t\t" +
                                            content[index]["contact"]
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      )),
                                  SizedBox(height: 10),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "State Name:\t\t\t" +
                                            content[index]["state"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      )),
                                  SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "District Name:\t\t\t" +
                                          content[index]["district"],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Level:\t\t\t" +
                                            content[index]["level"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      )),
                                  SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Email Address:\t\t\t" +
                                          content[index]["email"],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      );
                    } else {
                      return SizedBox(
                        height: 0.0,
                      );
                    }
                  },
                );
              } else {
                return Container(
                  child: Center(
                    child: SpinKitChasingDots(
                      color: Colors.black,
                      size: 80.0,
                    ),
                  ),
                );
              }
            })),
  );
}
