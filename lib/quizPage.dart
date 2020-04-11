import 'dart:convert';

import 'package:translator/translator.dart';

import 'googleMap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/quiz/quiz";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

GoogleTranslator translator = new GoogleTranslator();
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

Color shadowColor = Colors.black45;
List<Color> color3 = [Color(0xFFEECDA3), Color(0xFFEF629F)];

class _QuizState extends State<Quiz> {
  List<String> que = [];
  String text;
  void translate(List data) async {
    for (int i = 0; i < data.length; i++) {
      String title = data[i]["title"];
      String url =
          "https://translation.googleapis.com/language/translate/v2?target=hi&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$title";
      http.Response response = await http.get(url);
      Map content = json.decode(response.body);
      que.add(content["data"]["translations"][0]["translatedText"]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Quiz",
          style: TextStyle(color: Colors.black, fontSize: 30.0),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: getUri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List content = snapshot.data;
              translate(content);
              if (que.isNotEmpty) {
                return ListView.builder(
                  itemCount: content.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 800),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                shadow[index] = Colors.black87;
                              });
                              Navigator.of(context).push(createRoute(QuizPage(
                                index: index,
                                content: content,
                                length: content[index]["questions"].length,
                              )));
                            },
                            child: AnimatedContainer(
                              onEnd: () {
                                shadow[index] = Colors.black45;
                              },
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: index % 2 == 0 ? color1 : color2,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: shadow[index],
                                      blurRadius: blur,
                                      offset: Offset.fromDirection(1.0, 10.0))
                                ],
                              ),
                              margin: EdgeInsets.all(15.0),
                              width: 300,
                              height: 150,
                              child: Center(
                                  child: Text(
                                que[index],
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                      ),
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
            } else {
              return Center(
                child: SpinKitChasingDots(
                  color: Colors.black,
                  size: 50.0,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  int index;
  List content;
  int length;
  QuizPage(
      {Key key,
      @required this.index,
      @required this.content,
      @required this.length})
      : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState();
}

List<Color> shadow = [Colors.black45, Colors.black45, Colors.black45];
double blur = 15.0;
double width = 300;
double height = 150;
bool a = true;
List<String> answers = [];

class _QuizPageState extends State<QuizPage> {
  List<String> title = [];
  List<List<String>> options = [];
  void translate() async {
    for (int i = 0; i < widget.length; i++) {
      List data = widget.content;
      String temp = data[widget.index]["questions"][i]["question"];
      String url =
          "https://translation.googleapis.com/language/translate/v2?target=hi&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$temp";
      http.Response response = await http.get(url);
      Map content = json.decode(response.body);
      title.add(content["data"]["translations"][0]["translatedText"]);
      // for (int j = 0; j < widget.length; j++) {
      //   String opta = data[i]["questions"][j]["choice_a"];
      //   String optb = data[i]["questions"][j]["choice_b"];
      //   String optc = data[i]["questions"][j]["choice_c"];
      //   String optd = data[i]["questions"][j]["choice_d"];
      //   String aurl =
      //       "https://translation.googleapis.com/language/translate/v2?target=hi&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$opta";
      //   http.Response aresponse = await http.get(aurl);
      //   Map acontent = json.decode(aresponse.body);
      //   String burl =
      //       "https://translation.googleapis.com/language/translate/v2?target=hi&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$optb";
      //   http.Response bresponse = await http.get(burl);
      //   Map bcontent = json.decode(bresponse.body);
      //   String curl =
      //       "https://translation.googleapis.com/language/translate/v2?target=hi&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$optc";
      //   http.Response cresponse = await http.get(curl);
      //   Map ccontent = json.decode(cresponse.body);
      //   String durl =
      //       "https://translation.googleapis.com/language/translate/v2?target=hi&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$optd";
      //   http.Response dresponse = await http.get(durl);
      //   Map dcontent = json.decode(dresponse.body);
      //   options[j][0] = acontent["data"]["translations"][0]["translatedText"];
      //   options[j][1] = bcontent["data"]["translations"][0]["translatedText"];
      //   options[j][2] = ccontent["data"]["translations"][0]["translatedText"];
      //   options[j][3] = dcontent["data"]["translations"][0]["translatedText"];
      // }
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      answers = [];
    });
    for (int i = 0; i <= widget.length; i++) {
      answers.add("F");
    }
    translate();
  }

  Widget submitButton(int index) {
    if (index == widget.length - 1) {
      return GestureDetector(
        onTap: () {
          int result = 0;
          for (int i = 0; i < widget.length; i++) {
            if (widget.content[widget.index]["questions"][i]["answer"] ==
                answers[i]) {
              result++;
            }
          }
          return showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Quiz Result",
                            style: TextStyle(fontSize: 25.0),
                          ),
                          Text(
                            "Marks: " + result.toString(),
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Ok",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xFF1BC0C5),
                          ),
                        ],
                      )),
                );
              });
        },
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF1488CC), Color(0xFF2B32B2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black45,
                  blurRadius: 15.0,
                  offset: Offset.fromDirection(1.0, 5.0))
            ],
          ),
          child: Center(
              child: Text(
            "Submit",
            style: TextStyle(color: Colors.white, fontSize: 15.0),
          )),
        ),
      );
    } else {
      return SizedBox(
        height: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          widget.content[widget.index]["name"],
          style: TextStyle(color: Colors.black, fontSize: 30.0),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: widget.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 800),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {},
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
                          margin: EdgeInsets.all(15.0),
                          width: width,
                          height: height,
                          child: Center(
                              child: AnimationConfiguration.staggeredList(
                            position: 2,
                            duration: Duration(milliseconds: 1000),
                            child: SlideAnimation(
                              horizontalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      title.isEmpty
                                          ? "Loading..."
                                          : title[index],
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          widget.content[widget.index]
                                              ["questions"][index]["choice_a"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0),
                                        ),
                                        Radio(
                                            activeColor: Colors.white,
                                            focusColor: Colors.black,
                                            value: "A",
                                            groupValue: answers[index],
                                            onChanged: (value) {
                                              setState(() {
                                                answers[index] = value;
                                              });
                                            }),
                                        Text(
                                          widget.content[widget.index]
                                              ["questions"][index]["choice_b"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0),
                                        ),
                                        Radio(
                                            activeColor: Colors.white,
                                            focusColor: Colors.black,
                                            value: "B",
                                            groupValue: answers[index],
                                            onChanged: (value) {
                                              setState(() {
                                                answers[index] = value;
                                              });
                                            }),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          widget.content[widget.index]
                                              ["questions"][index]["choice_c"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0),
                                        ),
                                        Radio(
                                            activeColor: Colors.white,
                                            focusColor: Colors.black,
                                            value: "C",
                                            groupValue: answers[index],
                                            onChanged: (value) {
                                              setState(() {
                                                answers[index] = value;
                                              });
                                            }),
                                        Text(
                                          widget.content[widget.index]
                                              ["questions"][index]["choice_d"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0),
                                        ),
                                        Radio(
                                            activeColor: Colors.white,
                                            focusColor: Colors.black,
                                            value: "D",
                                            groupValue: answers[index],
                                            onChanged: (value) {
                                              setState(() {
                                                answers[index] = value;
                                              });
                                            }),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                submitButton(index)
              ],
            );
          },
        ),
      ),
    );
  }
}
