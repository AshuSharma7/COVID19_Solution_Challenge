import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'getLangCode.dart' as lang;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<List<dynamic>> getPrec() async {
  String url = "https://covid-mitrc.herokuapp.com/apis/precaution";
  http.Response response = await http.get(url);
  print(response.statusCode);
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

class Precaution extends StatefulWidget {
  @override
  _Precaution createState() => _Precaution();
}

class _Precaution extends State<Precaution> {
  List<Map<String, String>> precaution = [];
  void translate(List content) async {
    String langCode = await lang.prefs();
    for (int i = 0; i < content.length; i++) {
      String title = content[i]["title"];
      String detail = content[i]["details"];
      String turl =
          "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$title";
      String durl =
          "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$detail";
      http.Response tresponse = await http.get(turl);
      http.Response dresponse = await http.get(durl);
      Map dc = json.decode(dresponse.body);
      Map tc = json.decode(tresponse.body);
      if (!precaution.contains({
        "title": tc["data"]["translations"][0]["translatedText"],
        "detail": dc["data"]["translations"][0]["translatedText"]
      })) {
        precaution.add({
          "title": tc["data"]["translations"][0]["translatedText"],
          "detail": dc["data"]["translations"][0]["translatedText"]
        });
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Precaution",
          style: TextStyle(color: Colors.black, fontSize: 30.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
            future: getPrec(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List content = snapshot.data;
                translate(content);
                if (precaution.isNotEmpty) {
                  return ListView.builder(
                      itemCount: content.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 800),
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => newsDetails(
                                  //             content['articles'][index]
                                  //                 ["title"])));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors:
                                            index % 2 == 0 ? color1 : color2,
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight),
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 15.0,
                                          offset:
                                              Offset.fromDirection(1.0, 10.0))
                                    ],
                                  ),
                                  margin: EdgeInsets.all(20.0),
                                  child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                precaution[index]["title"],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22.0,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                precaution[index]["detail"],
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ))),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: SpinKitChasingDots(
                      color: Colors.black,
                      size: 50.0,
                    ),
                  );
                }
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
