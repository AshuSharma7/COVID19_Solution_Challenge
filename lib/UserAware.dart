import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization_master/localization/language_constants.dart';
import 'package:flutter_localization_master/pages/awareness.dart';
import 'package:flutter_localization_master/pages/faqPage.dart';
import 'package:flutter_localization_master/pages/precaution.dart';
import 'package:flutter_localization_master/pages/youtube.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

List<Color> orange = [Color(0xFFff9966), Color(0xFFff5e62)];
List<Color> blue = [Color(0xFF36D1DC), Color(0xFF5B86E5)];
List<Color> sweet = [Color(0xFFFF5F6D), Color(0xFFFFC371)];
List<Color> purple = [
  Color(0xFFf80759),
  Color(0xFFbc4e9c),
];

class UserAware extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Awareness",
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Precaution()));
                    },
                    child: boards(
                        context,
                        getTranslated(context, 'precaution'),
                        blue,
                        Colors.blue[300],
                        Icon(
                          LineIcons.shield,
                          size: 60.0,
                        )),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => Vid()));
                    },
                    child: boards(
                        context,
                        getTranslated(context, 'video'),
                        purple,
                        Colors.pink[300],
                        Icon(
                          LineIcons.youtube_play,
                          size: 60.0,
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Awareness()));
                    },
                    child: boards(
                        context,
                        getTranslated(context, 'awareness'),
                        sweet,
                        Colors.deepOrange[300],
                        Icon(
                          LineIcons.warning,
                          size: 60.0,
                        )),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => FAQPage()));
                    },
                    child: boards(
                        context,
                        getTranslated(context, 'faq'),
                        orange,
                        Colors.deepOrange[200],
                        Icon(
                          LineIcons.question_circle,
                          size: 60.0,
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget boards(BuildContext context, String title, List<Color> color,
    Color shadow, Icon icon) {
  return Container(
    decoration: decorate(color, shadow),
    height: MediaQuery.of(context).size.height / 5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon,
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        )
      ],
    ),
    margin: EdgeInsets.all(10.0),
  );
}

BoxDecoration decorate(List<Color> color, Color shadow) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    gradient: LinearGradient(
      colors: color,
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
    ),
    boxShadow: [
      BoxShadow(
          color: shadow,
          blurRadius: 20.0,
          spreadRadius: 0.1,
          offset: Offset.fromDirection(4.0, -10.0))
    ],
  );
}
