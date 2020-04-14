import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DistrictList extends StatefulWidget {
  @override
  String state;
  String para;
  DistrictList({Key key, @required this.state, @required this.para})
      : super(key: key);
  _DistrictListState createState() => _DistrictListState();
}

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/member";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class _DistrictListState extends State<DistrictList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFFF9933),
            Color(0xFFFFFFFF),
            Color(0xFF138808),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: getUri(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List content = snapshot.data;
                return ListView.builder(
                    itemCount: content.length,
                    itemBuilder: (BuildContextcontext, int index) {
                      print(content[index]["state"]);
                      if (content[index]["state"] == widget.state &&
                          content[index][widget.para] == true) {
                        return Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white),
                          child: Text(
                            content[index]["district"],
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 0.0,
                        );
                      }
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 10.0,
                  ),
                );
              }
            }),
      ),
    );
  }
}