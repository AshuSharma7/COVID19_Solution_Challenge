import 'dart:convert';

import 'package:covid19/dashBoardGoogleMap.dart' as dash;
import 'package:covid19/familyDeclaration.dart';
import 'package:covid19/ministrystate.dart';
import 'dashBoardStates.dart' as dash;
import 'package:covid19/selfchecker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'adviceinner.dart';
import 'audiodata.dart';
import 'awareness.dart';
import 'deathgrid.dart';
import 'faqPage.dart';
import 'googleMap.dart';
import 'package:http/http.dart' as http;
import 'helpLine.dart';
import 'hospitalinner.dart';
import 'info.dart';
import 'ministry.dart';
import 'testinggrid.dart';
import 'tracker.dart';
import 'userrequire.dart';
import 'videoPage.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("कोविड-19"),
            ),
            body: LogoApp()));
  }
}

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

Future<Map> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/aggregates";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation, animation2;
  AnimationController _controller, _controller2;
  String i;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(_controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation objects value
          i = animation.value.toStringAsFixed(0);
        });
      });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFFFF9933),
              Color(0xFFFFFFFF),
              Color(0xFF138808),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: FutureBuilder(
              future: getUri(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  Map content = snapshot.data;
                  return ListView(children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  elevation: 10.0,
                                  color: Color(0xFFFFFFFF),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          content["registered"].toString(),
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontSize: 50,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Center(
                                          child: Text(
                                            "कुल उपयोगकर्ता रजिस्टर",
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  margin: EdgeInsets.only(left: 10),
                                )),
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              content["infected"].toString(),
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Center(
                                              child: Text(
                                                "कुल संक्रमित व्यक्ति",
                                                textDirection:
                                                    TextDirection.ltr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                dash.stateList(
                                                    para: "is_infected")),
                                      );
                                    },
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              content["symptoms"].toString(),
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Center(
                                              child: Text(
                                                "संदिग्ध मामला",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                dash.stateList(
                                                  para: "symptoms",
                                                )),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              content["recovered"].toString(),
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Center(
                                              child: Text(
                                                "कुल व्यक्ति ठीक हो गया",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => secondgrid()),
                                      );
                                    },
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '$i',
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontSize: 50,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Center(
                                                child: Text(
                                                  "कुल मौत",
                                                  textAlign: TextAlign.center,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                      margin: EdgeInsets.only(left: 10),
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
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '$i',
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Center(
                                              child: Text(
                                                "कुल लोगों को अलग कर दिया",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => secondgrid()),
                                      );
                                    },
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '$i',
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Center(
                                              child: Text(
                                                "कुल लोग बरामद",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
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
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/hospital.png')),
                                            Center(
                                              child: Text(
                                                "\nअस्पताल",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                hospitalgrid()),
                                      );
                                    },
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/headset.png')),
                                            Center(
                                              child: Text(
                                                "\nहेल्पलाइन",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => helpgrid()),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/lab_items.png')),
                                            Center(
                                              child: Text(
                                                "\nपरीक्षण प्रयोगशाला",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => labgrid()),
                                      );
                                    },
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/blackspot.png')),
                                            Center(
                                              child: Text(
                                                "मानचित्र ",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => blackgrid(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                              image: AssetImage(
                                                  'images/youtube.png'),
                                            ),
                                            Center(
                                              child: Text(
                                                "\nवीडियो",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => videogrid()),
                                      );
                                    },
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/ministry.png')),
                                            Center(
                                              child: Text(
                                                "स्वास्थ्य मंत्रालय",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => stateList()),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/warning.png')),
                                            Center(
                                              child: Text(
                                                "\nसावधानियां",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => secondgrid()),
                                      );
                                    },
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/aware.png')),
                                            Center(
                                              child: Text(
                                                "जागरूकता",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => awaregrid()),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/advice.png')),
                                            Center(
                                              child: Text(
                                                "\nसलाहकार",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => advicegrid()),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/faq.png')),
                                            Center(
                                              child: Text(
                                                "\nसामान्य प्रश्न",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => faqgrid()),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/audio.png')),
                                            Center(
                                              child: Text(
                                                "ऑडियो नमूना",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => audiogrid()),
                                      );
                                    },
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/selfcheck.png')),
                                            Center(
                                              child: Text(
                                                "स्वयं जाँचकर्ता",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => selfcheck2()),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/virus.png')),
                                            Center(
                                              child: Text(
                                                "\nकोरोना ट्रैकर",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Tracker()),
                                      );
                                    },
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/require.png')),
                                            Center(
                                              child: Text(
                                                "लोगों की जरुरत",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => usergrid()),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      elevation: 10.0,
                                      color: Color(0xFFFFFFFF),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                                image: AssetImage(
                                                    'images/inform.png')),
                                            Center(
                                              child: Text(
                                                "\nअन्य व्यक्ति की जानकारी",
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => infogrid()),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ))
                      ],
                    )
                  ]);
                } else {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 10.0,
                      ),
                    ),
                  );
                }
              },
            )));
  }
}

class secondgrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: deathgrid());
  }
}

class hospitalgrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: hospitalinner());
  }
}

class videogrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: VideoPage());
  }
}

class faqgrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: FAQPage());
  }
}

class precautiongrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: deathgrid());
  }
}

class awaregrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: Awareness());
  }
}

class advicegrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: AdviceInner());
  }
}

class helpgrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HelpLine());
  }
}

class labgrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: testinggrid1());
  }
}

class blackgrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: MapPage());
  }
}

class ministrygrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: Ministry());
  }
}

class audiogrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: audiodata());
  }
}

class usergrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: userReq());
  }
}

class infogrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: Info());
  }
}
