import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization_master/localization/language_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

import 'externaltest.dart';
import 'othersource.dart';

List<Color> blue = [Color(0xFF36D1DC), Color(0xFF5B86E5)];
List<Color> purple = [
  Color(0xFFf80759),
  Color(0xFFbc4e9c),
];

class ExternalSources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                child: Container(
                  decoration: decorate(purple, Colors.pink[300]),
                  height: MediaQuery.of(context).size.height / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        LineIcons.database,
                        size: 60.0,
                      ),
                      Center(
                        child: Text(
                          getTranslated(context, 'external_soc'),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black87,
                          ),
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.all(10.0),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => OtherSource()),
                  );
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  decoration: decorate(blue, Colors.blue[200]),
                  height: MediaQuery.of(context).size.height / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.flask,
                        size: 55.0,
                      ),
                      Center(
                        child: Text(
                          // "बाहरी स्रोत से परीक्षण केंद्र डेटा",
                          getTranslated(context, 'external_lab'),
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
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => ExternalTest()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
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
