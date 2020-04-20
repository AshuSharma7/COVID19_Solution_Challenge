import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization_master/localization/language_constants.dart';
import 'package:flutter_localization_master/pages/DailyBasis.dart';
import 'package:flutter_localization_master/pages/audiodata.dart';
import 'package:flutter_localization_master/pages/info.dart';
import 'package:flutter_localization_master/pages/selfchecker.dart';
import 'package:flutter_localization_master/pages/userrequire.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

List<Color> orange = [Color(0xFFff9966), Color(0xFFff5e62)];
List<Color> blue = [Color(0xFF36D1DC), Color(0xFF5B86E5)];
List<Color> sweet = [Color(0xFFFF5F6D), Color(0xFFFFC371)];
List<Color> purple = [
  Color(0xFFf80759),
  Color(0xFFbc4e9c),
];

class UserSupport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Support",
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
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => checker()));
                    },
                    child: boards(
                        context,
                        getTranslated(context, 'self_checker'),
                        blue,
                        Colors.blue[300],
                        Icon(
                          LineIcons.arrow_circle_up,
                          size: 60.0,
                        )),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => userReq()));
                    },
                    child: boards(
                        context,
                        getTranslated(context, 'user_requrirement'),
                        purple,
                        Colors.pink[300],
                        Icon(
                          LineIcons.users,
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
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => Info()));
                    },
                    child: boards(
                        context,
                        getTranslated(context, 'people_info'),
                        sweet,
                        Colors.deepOrange[300],
                        Icon(
                          LineIcons.list,
                          size: 60.0,
                        )),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => audiodata()));
                    },
                    child: boards(
                        context,
                        getTranslated(context, 'audio_sample'),
                        orange,
                        Colors.deepOrange[200],
                        Icon(
                          LineIcons.microphone,
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
                              builder: (context) => DailyBasis()));
                    },
                    child: boards(
                        context,
                        "Daily Basis",
                        purple,
                        Colors.pink[300],
                        Icon(
                          FontAwesomeIcons.carrot,
                          size: 60.0,
                        )),
                  ),
                ),
                Expanded(
                    child: Container(
                  color: Colors.white,
                )),
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
