import 'package:flutter/gestures.dart';
import 'package:flutter_localization_master/pages/advisory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/translator.dart';

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
String langCode;

class _NewsApi extends State<NewsApi> {
  List<String> news = [];
  void translate(Map data) async {
    langCode = lang.langCode;
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
                                        builder: (context) => NewsDetails(
                                              content: content,
                                              index: index,
                                            )));
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

class NewsDetails extends StatefulWidget {
  Map content;
  int index;
  NewsDetails({Key key, @required this.content, @required this.index})
      : super(key: key);
  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  GoogleTranslator translator = new GoogleTranslator();
  String title = "";
  String detail = "";

  @override
  void initState() {
    translator
        .translate(widget.content["articles"][widget.index]["title"],
            to: langCode)
        .then((value) {
      setState(() {
        title = value;
      });
    });
    translator
        .translate(widget.content["articles"][widget.index]["description"],
            to: langCode)
        .then((value) {
      setState(() {
        detail = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget.content["articles"][widget.index]["source"]["name"]
                  .toString()
                  .toUpperCase(),
              style: TextStyle(color: Colors.black, fontSize: 30.0)),
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: title != ""
            ? Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10.0,
                              offset: Offset.fromDirection(1.0, 4.0))
                        ],
                        image: DecorationImage(
                            image: NetworkImage(
                          widget.content["articles"][widget.index]["urlToImage"]
                              .toString(),
                        )),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Container(
                      child: Image.network(
                        widget.content["articles"][widget.index]["urlToImage"]
                            .toString(),
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                      child: Container(
                          alignment: Alignment.topCenter,
                          child: Text(
                            widget.content["articles"][widget.index]
                                        ["description"] ==
                                    null
                                ? "We didn't find any description"
                                : widget.content["articles"][widget.index]
                                    ["description"],
                            style: TextStyle(fontSize: 18.0),
                          ))),
                  Container(
                    width: 200,
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.blueAccent,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueAccent[100],
                            blurRadius: 10.0,
                            offset: Offset.fromDirection(1.0, 4.0))
                      ],
                    ),
                    child: Center(
                      child: Expanded(
                          child: RichText(
                              text: TextSpan(
                        text: "Click here to Read Full Article",
                        style: TextStyle(fontSize: 15.0),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(widget.content["articles"][widget.index]
                                ["url"]);
                          },
                      ))),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              )
            : Center(
                child: SpinKitChasingDots(color: Colors.black),
              ));
  }
}
