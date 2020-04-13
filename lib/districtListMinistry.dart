import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'getLangCode.dart' as lang;

class DistrictList extends StatefulWidget {
  @override
  String state;
  DistrictList({Key key, @required this.state}) : super(key: key);
  _DistrictListState createState() => _DistrictListState();
}

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/apis/govt";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

List<Color> color1 = [
  Color(0xFF11998e),
  Color(0xFF38ef7d),
];
List<Color> color2 = [
  Color(0xFF8E2DE2),
  Color(0xFF4A00E0),
];

bool flag = true;
List<Map<String, dynamic>> district = [];

class _DistrictListState extends State<DistrictList> {
  void translate(
    List content,
  ) async {
    String langCode = await lang.prefs();
    for (int i = 0; i < content.length; i++) {
      if (content[i]["state"] == widget.state &&
          content[i]["is_state"] == false) {
        String text = content[i]["district"];
        String url =
            "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$text";
        http.Response response = await http.get(url);
        Map data = json.decode(response.body);
        if (!district.contains(
            {"district": data["data"]["translations"][0]["translatedText"]})) {
          district.add(
              {"district": data["data"]["translations"][0]["translatedText"]});
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: getUri(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                //print(widget.state.toLowerCase());
                List content = snapshot.data;
                translate(content);
                if (district.isNotEmpty) {
                  return ListView.builder(
                      itemCount: district.length,
                      itemBuilder: (BuildContextcontext, int index) {
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
                          child: Text(
                            district[index]["district"],
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
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
