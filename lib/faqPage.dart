import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'registerVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globalVar.dart' as global;
import 'getLangCode.dart' as lang;

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

List<Color> color1 = [
  Color(0xFF11998e),
  Color(0xFF38ef7d),
];
List<Color> color2 = [
  Color(0xFF8E2DE2),
  Color(0xFF4A00E0),
];
List<String> que = [];
List<String> ans = [];

class _FAQPageState extends State<FAQPage> {
  String text = "Loading...";
  void translate(String q, String a) async {
    String langCode = lang.langCode;
    String question = q;
    String answer = a;
    String qurl =
        "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$question";
    http.Response qresponse = await http.post(qurl);
    Map qcontent = json.decode(qresponse.body);
    String aurl =
        "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$answer";
    http.Response aresponse = await http.post(aurl);
    Map acontent = json.decode(aresponse.body);
    // if (!data.contains(content["data"]["translations"][0]["translatedText"])) {
    if (!que.contains(qcontent["data"]["translations"][0]["translatedText"]) &&
        qcontent["data"] != null) {
      que.add(qcontent["data"]["translations"][0]["translatedText"]);
    }
    if (!ans.contains(acontent["data"]["translations"][0]["translatedText"]) &&
        acontent["data"] != null) {
      ans.add(acontent["data"]["translations"][0]["translatedText"]);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lang.prefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FAQ PAGE",
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: global.getUri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List content = snapshot.data;
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: content.length,
                itemBuilder: (BuildContext context, int index) {
                  translate(content[index]["que"], content[index]["ans"]);
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 700),
                    child: SlideAnimation(
                      horizontalOffset: 70.0,
                      verticalOffset: 70.0,
                      child: FadeInAnimation(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(10.0),
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
                          child: que.isEmpty && ans.isEmpty
                              ? Shimmer.fromColors(
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          height: 15.0,
                                          color: Colors.white54,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 15.0,
                                          color: Colors.white54,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                        Container(
                                          width: 40.0,
                                          height: 15.0,
                                          color: Colors.white54,
                                        ),
                                      ],
                                    ),
                                  ),
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[50])
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      (index + 1).toString() +
                                          ". " +
                                          (que.isEmpty
                                              ? "Loading..."
                                              : que[index]),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        ans.isEmpty
                                            ? "Loading...."
                                            : ans[index],
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
