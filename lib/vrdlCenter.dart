import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localization_master/pages/DeclarationForm.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/hospital";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

var string;
List<String> states = [];
List<String> district = [];

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
                return ListView.builder(
                    itemCount: states.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => vrdlList(
                                      state: states[index], content: content)));
                        },
                        child: Container(
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
                              states[index],
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: widget.content.length,
          itemBuilder: (BuildContext context, int index) {
            if (widget.content[index]["state"] == widget.state) {
              return Container(
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
                    widget.content[index]["district"],
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: 0.0,
              );
            }
          },
        ),
      ),
    );
  }
}
