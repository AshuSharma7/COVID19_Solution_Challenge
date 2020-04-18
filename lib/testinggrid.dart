import 'package:flutter/material.dart';
import 'package:flutter_localization_master/localization/language_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'depart.dart';
import 'testingCentre.dart';

class testinggrid1 extends StatefulWidget {
  @override
  _testinggrid1 createState() => _testinggrid1();
}

class _testinggrid1 extends State<testinggrid1>
    with SingleTickerProviderStateMixin {
  String i;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.white),
        child: Align(
          alignment: Alignment.center,
          child: ListView(children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TestingCentre(
                                          para: "TC",
                                        )),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              elevation: 10.0,
                              color: Color(0xFFFFFFFF),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFff9966),
                                      Color(0xFFff5e62)
                                    ],
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.deepOrange[300],
                                        blurRadius: 20.0,
                                        spreadRadius: 0.1,
                                        offset:
                                            Offset.fromDirection(4.0, -10.0))
                                  ],
                                ),
                                height: MediaQuery.of(context).size.height / 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.stethoscope,
                                        size: 60.0),
                                    Center(
                                      child: Text(
                                        getTranslated(
                                            context, 'testing_center'),
                                        // "परीक्षण केंद्र",
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              margin: EdgeInsets.all(10.0),
                            ))),
                    Expanded(
                      child: GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 10.0,
                          color: Color(0xFFFFFFFF),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                colors: [Color(0xFFff9966), Color(0xFFff5e62)],
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.deepOrange[300],
                                    blurRadius: 20.0,
                                    spreadRadius: 0.1,
                                    offset: Offset.fromDirection(4.0, -10.0))
                              ],
                            ),
                            height: MediaQuery.of(context).size.height / 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.allergies,
                                  size: 60.0,
                                ),
                                Center(
                                  child: Text(
                                    getTranslated(context, 'pcr'),
                                    // "पीसीआर मशीन",
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          margin: EdgeInsets.all(10.0),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TestingCentre(
                                      para: "PR",
                                    )),
                          );
                        },
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 15.0,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TestingCentre(
                                    para: "SC",
                                  )),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 10.0,
                        color: Color(0xFFFFFFFF),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: LinearGradient(
                              colors: [Color(0xFFff9966), Color(0xFFff5e62)],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.deepOrange[300],
                                  blurRadius: 20.0,
                                  spreadRadius: 0.1,
                                  offset: Offset.fromDirection(4.0, -10.0))
                            ],
                          ),
                          height: MediaQuery.of(context).size.height / 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                LineIcons.flask,
                                size: 60.0,
                              ),
                              Center(
                                child: Text(
                                  getTranslated(context, 'sample_coll'),
                                  // "नमूना संग्रह",
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black87,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        margin: EdgeInsets.all(10.0),
                      ),
                    )),
                    Expanded(
                      child: GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 10.0,
                          color: Color(0xFFFFFFFF),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                colors: [Color(0xFFff9966), Color(0xFFff5e62)],
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.deepOrange[300],
                                    blurRadius: 20.0,
                                    spreadRadius: 0.1,
                                    offset: Offset.fromDirection(4.0, -10.0))
                              ],
                            ),
                            height: MediaQuery.of(context).size.height / 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  LineIcons.info_circle,
                                  size: 60.0,
                                ),
                                Center(
                                  child: Text(
                                    getTranslated(context, 'guidlines'),
                                    // "\nदिशा निर्देशों",
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          margin: EdgeInsets.all(10.0),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => secondgrid()),
                          );
                        },
                      ),
                    ),
                  ],
                ))
          ]),
        ));
  }
}
