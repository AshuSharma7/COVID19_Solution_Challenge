import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:translator/translator.dart';
import 'getLangCode.dart' as lang;

class AdvisoryPage extends StatefulWidget {
  @override
  _AdvisoryPageState createState() => _AdvisoryPageState();
}

GoogleTranslator translator = new GoogleTranslator();
Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/apis/advisory";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

String text;
String textOriginal;

class _AdvisoryPageState extends State<AdvisoryPage> {
  List<Map<String, String>> advisory = [];
  void translate(List content) async {
    String langCode = await lang.prefs();
    for (int i = 0; i < content.length - 15; i++) {
      String title = content[i]["title"];
      String detail = content[i]["detail"];
      String turl =
          "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$title";
      String durl =
          "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$detail";
      http.Response tresponse = await http.get(turl);
      http.Response dresponse = await http.get(durl);
      Map dc = json.decode(dresponse.body);
      Map tc = json.decode(tresponse.body);
      if (!advisory.contains({
        "title": tc["data"]["translations"][0]["translatedText"],
        "detail": dc["data"]["translations"][0]["translatedText"]
      })) {
        advisory.add({
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: FutureBuilder(
          future: getUri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List content = snapshot.data;
              translate(content);
              if (advisory.isNotEmpty) {
                return ListView.builder(
                  itemCount: content.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 10.0)
                          ]),
                      child: Column(
                        children: <Widget>[
                          Text(
                            advisory[index]["title"],
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            advisory[index]["detail"],
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
