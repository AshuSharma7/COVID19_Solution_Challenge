import 'dart:convert';

import 'package:covid19/googleMap.dart';
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

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            print(snapshot.hasData);
            if (snapshot.hasData) {
              List content = snapshot.data;
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
                            Navigator.of(context).push(createRoute(QuizPage(
                              index: index,
                              content: content,
                              length: content[index]["questions"].length,
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
                            margin: EdgeInsets.all(15.0),
                            width: 300,
                            height: 150,
                            child: Center(
                                child: Text(
                              content[index]["title"],
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

class _QuizPageState extends State<QuizPage> {
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: widget.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 800),
              child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
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
                    width: 300,
                    height: 150,
                    child: Center(
                        child: Text(
                      widget.content[widget.index]["questions"][index]
                          .toString(),
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    )),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
