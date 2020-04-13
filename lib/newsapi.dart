import 'package:shimmer/shimmer.dart';

import 'searchPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'getLangCode.dart' as lang;

class NewsApi extends StatefulWidget {
  @override
  _NewsApi createState() => _NewsApi();
}

Future<Map> getUri() async {
  String url =
      "http://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=5bbdcdbc1f614c4e9651df00dd38ee47";
  http.Response response = await http.get(url);
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

Route createRoute(Widget name) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => name,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOutQuad;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      });
}

double width;
double height;
List<String> states = [];
List<int> centres = [];
String searchQuery;
TextEditingController queryEditor = new TextEditingController();

class _NewsApi extends State<NewsApi> {
  List<String> news = [];
  void translate(Map data) async {
    String langCode = lang.langCode;
    for (int i = 0; i < data['articles'].length; i++) {
      String text = data['articles'][i]["title"];
      String url =
          "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$text";
      http.Response response = await http.get(url);
      Map content = json.decode(response.body);
      if (!news
          .contains(content["data"]["translations"][0]["translatedText"])) {
        news.add(content["data"]["translations"][0]["translatedText"]);
      }
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
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "News",
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: FutureBuilder(
            future: getUri(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Map content = snapshot.data;
                translate(content);
                // for (int i = 0; i < content.length; i++) {
                //   if (!states.contains(content[i]["state"])) {
                //     states.add(content[i]["state"]);
                //   }
                // }
                // states.sort((a, b) => a.toString().compareTo(b.toString()));
                return ListView.builder(
                  itemCount: content['articles'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 800),
                      child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => newsDetails(
                                            content['articles'][index]
                                                ["title"])));
                              },
                              child: Container(
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
                                margin: EdgeInsets.all(10.0),
                                width: 300,
                                height: 100,
                                child: Center(
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: news.isEmpty
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 15.0,
                                                      color: Colors.white54,
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
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
                                          : Text(
                                              news[index],
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white),
                                            )),
                                ),
                              ),
                            ),
                          )),
                    );
                  },
                );
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

Future<void> _onOpen(LinkableElement link) async {
  if (await canLaunch(link.url)) {
    await launch(link.url);
  } else {
    throw 'Could not launch $link';
  }
}

Widget newsDetails(String title) {
  return Scaffold(
    appBar: AppBar(
      title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
    ),
    body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFFF9933),
            Color(0xFFFFFFFF),
            Color(0xFF138808),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: FutureBuilder(
          future: getUri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map content = snapshot.data;
              return ListView.builder(
                itemCount: content['articles'].length,
                itemBuilder: (BuildContext context, int index) {
                  if (content['articles'][index]["title"] == title) {
                    return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(children: <Widget>[
                          SizedBox(height: 30),
                          Text(
                            content['articles'][index]["title"].toString(),
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30),
                          Card(
                              elevation: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                    child: Column(
                                  children: <Widget>[
                                    Image.network(
                                        '${content['articles'][index]["urlToImage"]}'),
                                  ],
                                )),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Linkify(
                            textScaleFactor: 1.1,
                            onOpen: _onOpen,
                            text: "${content['articles'][index]["url"]}",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              content['articles'][index]["description"]
                                  .toString(),
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Published Time:" +
                                  content['articles'][index]["publishedAt"]
                                      .toString(),
                              style: TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          // Card(
                          //     elevation: 10,
                          //     child: Container(
                          //       height: 90,
                          //       child:
                          //     ))
                        ]));
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return Center(
                child: SpinKitChasingDots(
                  color: Colors.black,
                  size: 50.0,
                ),
              );
            }
          },
        )),
  );
}
