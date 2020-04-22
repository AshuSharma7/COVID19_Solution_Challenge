import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localization_master/blackSpot.dart';
import 'package:flutter_localization_master/pages/AppData.dart';
import 'package:flutter_localization_master/pages/UserAware.dart';
import 'package:flutter_localization_master/pages/externalSoc.dart';
import 'package:flutter_localization_master/pages/userSupport.dart';
import 'package:flutter_localization_master/pages/volunteer.dart';
import 'CoronaTracker.dart';
import 'package:flutter_localization_master/pages/developerPage.dart';
import 'package:flutter_localization_master/pages/helpLine.dart';
import 'package:flutter_localization_master/pages/testinggrid.dart';
import 'package:flutter_localization_master/pages/vrdlCenter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'ministrystate.dart';
import 'package:flutter_localization_master/localization/language_constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}
final databse = FirebaseDatabase.instance.reference();
String user;
String apiKey = "a051a6e786msheabdb117530fe36p133d27jsn3c2846d089cd";
Future<dynamic> getUri() async {
  String url =
      "https://coronavirus-monitor.p.rapidapi.com/coronavirus/cases_by_country.php";
  Map<String, String> headers = {
    "content-type": "application/json",
    "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
    "x-rapidapi-key": apiKey,
  };
  http.Response response = await http.get(url, headers: headers);
  return json.decode(response.body);
}

List<Color> orange = [Color(0xFFff9966), Color(0xFFff5e62)];
List<Color> blue = [Color(0xFF36D1DC), Color(0xFF5B86E5)];
List<Color> sweet = [Color(0xFFFF5F6D), Color(0xFFFFC371)];
List<Color> purple = [
  Color(0xFFbc4e9c),
  Color(0xFFf80759),
];
int india;

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {

  void userType() {
    auth.currentUser().then((value) {
      databse.child(value.uid).once().then((value) {
        Map data = value.value;
        setState(() {
          user = data["user"];
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    userType();
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DashBoard",
          style: TextStyle(fontSize: 30.0, color: Colors.black87),
        ),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFFC371),
      ),
      body: Center(
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                      children: <Widget>[
                        AnimationConfiguration.staggeredList(
                          position: 1,
                          duration: const Duration(milliseconds: 875),
                          child: SlideAnimation(
                            verticalOffset: 150.0,
                            child: FadeInAnimation(
                              child: ListView(children: <Widget>[
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      decoration: decorate(blue,
                                                          Colors.blue[300]),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            LineIcons.user,
                                                            size: 60.0,
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              "User Awareness",
                                                              // "\nवीडियो",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      margin:
                                                          EdgeInsets.all(10.0),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder: (context) =>
                                                                UserAware()),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      decoration: decorate(
                                                          purple,
                                                          Colors.pink[300]),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            LineIcons
                                                                .user_secret,
                                                            size: 60.0,
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              "User Surveyed data",
                                                              // "\nसावधानियां",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      margin:
                                                          EdgeInsets.all(10.0),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    UserData()),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      decoration: decorate(
                                                          sweet,
                                                          Colors
                                                              .deepOrange[300]),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                              LineIcons.heart_o,
                                                              size: 60.0),
                                                          Center(
                                                            child: Text(
                                                              getTranslated(
                                                                  context,
                                                                  'health_ministry'),
                                                              // "स्वास्थ्य मंत्रालय",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      margin:
                                                          EdgeInsets.all(10.0),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder: (context) =>
                                                                stateList()),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      decoration: decorate(
                                                          orange,
                                                          Colors
                                                              .deepOrange[200]),
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            5,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                                LineIcons
                                                                    .hospital_o,
                                                                size: 60),
                                                            Center(
                                                              child: Text(
                                                                getTranslated(
                                                                    context,
                                                                    'hospital'),
                                                                // "\nअस्पताल",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                textDirection:
                                                                    TextDirection
                                                                        .ltr,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black87),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    vrdl()),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, left: 20, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: GestureDetector(
                                                    child: Container(
                                                        decoration: decorate(
                                                            blue,
                                                            Colors.blue[300]),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            5,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                              LineIcons.phone,
                                                              size: 60,
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                // "\nहेल्पलाइन",
                                                                getTranslated(
                                                                    context,
                                                                    'helpline'),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                textDirection:
                                                                    TextDirection
                                                                        .ltr,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        margin: EdgeInsets.all(
                                                            10.0)),
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          CupertinoPageRoute(
                                                              builder: (context) =>
                                                                  HelpLine()));
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      decoration: decorate(
                                                          sweet,
                                                          Colors
                                                              .deepOrange[300]),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            LineIcons.flask,
                                                            size: 60.0,
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              getTranslated(
                                                                  context,
                                                                  'testing_labs'),
                                                              // "\nपरीक्षण प्रयोगशाला",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      margin:
                                                          EdgeInsets.all(10.0),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder: (context) =>
                                                                testinggrid1()),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, left: 20, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      decoration: decorate(
                                                          sweet,
                                                          Colors
                                                              .deepOrange[300]),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Image(
                                                              image: AssetImage(
                                                                  'images/virus.png')),
                                                          Center(
                                                            child: Text(
                                                              getTranslated(
                                                                  context,
                                                                  'corona_tracker'),
                                                              // "\nकोरोना ट्रैकर",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      margin:
                                                          EdgeInsets.all(10.0),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Tracker()),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      decoration: decorate(
                                                          purple,
                                                          Colors.pink[300]),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            LineIcons
                                                                .map_marker,
                                                            size: 60.0,
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              getTranslated(
                                                                  context,
                                                                  'blackspot'),
                                                              // "मानचित्र ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      margin:
                                                          EdgeInsets.all(10.0),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          CupertinoPageRoute(
                                                              builder: (context) =>
                                                                  BlackSpot()));
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, left: 20, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      decoration: decorate(blue,
                                                          Colors.blue[200]),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .externalLinkAlt,
                                                            size: 50.0,
                                                          ),
                                                          SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              "External Sources",
                                                              // "लोगों की जरुरत",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      margin:
                                                          EdgeInsets.all(10.0),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder: (context) =>
                                                                ExternalSources()),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      decoration: decorate(
                                                          sweet,
                                                          Colors
                                                              .deepOrange[300]),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            LineIcons.user_plus,
                                                            size: 60.0,
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              "User Support",
                                                              // "\nअन्य व्यक्ति की जानकारी",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      margin:
                                                          EdgeInsets.all(10.0),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder: (context) =>
                                                                UserSupport()),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, left: 20, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                    child: GestureDetector(
                                                      onTap: user == "volunteer" ? () {
                                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => Volunteer()));
                                                      } : () {},
                                                                                                          child: Container(
                                                  decoration: decorate(
                                                        blue, Colors.blue[200]),
                                                  height: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        5,
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Center(
                                                          child: Text(
                                                           user == "volunteer" ? "Volunteer Page" : "Stay Home\nStay Safe",
                                                            textAlign:
                                                                TextAlign.center,
                                                            textDirection:
                                                                TextDirection.ltr,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 18.0,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                  ),
                                                  margin: EdgeInsets.all(10.0),
                                                ),
                                                    )),
                                                Expanded(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      decoration: decorate(
                                                          sweet,
                                                          Colors
                                                              .deepOrange[300]),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                              LineIcons
                                                                  .info_circle,
                                                              size: 60.0),
                                                          Center(
                                                            child: Text(
                                                              "About App",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      margin:
                                                          EdgeInsets.all(10.0),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder: (context) =>
                                                                AboutPage()),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                          height: 20.0,
                                        )
                                      ],
                                    )
                                  ]),
                                
                            ),
                          ),
                        ),
                        Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Container(
                                padding: EdgeInsets.only(bottom: 10.0),
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height / 5.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0)),
                                  gradient: LinearGradient(
                                    colors: sweet,
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black38,
                                        blurRadius: 18.0,
                                        spreadRadius: 0.1,
                                        offset: Offset.fromDirection(4.8, -15.0))
                                  ],
                                ),
                                child: Center(
                                  child: FutureBuilder(
                                    future: getUri(),
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      if(snapshot.hasData) {
                                        Map content = snapshot.data;

                    for (int i = 0; i < content["countries_stat"].length; i++) {
                      if (content["countries_stat"][i]["country_name"]
                              .toString()
                              .toLowerCase() ==
                          "india") {
                        india = i;
                        break;
                      }
                    }
                                      return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  content["countries_stat"][india]
                                                      ["cases"],
                                                  style: TextStyle(
                                                      fontSize: 25.0,
                                                      color: Colors.black54),
                                                ),
                                                Text("Total Cases",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black87,
                                                    )),
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  content["countries_stat"][india]
                                                      ["active_cases"],
                                                  style: TextStyle(
                                                      fontSize: 25.0,
                                                      color: Colors.black54),
                                                ),
                                                Text("Active cases",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black87,
                                                    ))
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  content["countries_stat"][india]
                                                      ["total_recovered"],
                                                  style: TextStyle(
                                                      fontSize: 25.0,
                                                      color: Colors.black54),
                                                ),
                                                Text("Total recovered",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black87,
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  content["countries_stat"][india]
                                                      ["deaths"],
                                                  style: TextStyle(
                                                      fontSize: 25.0,
                                                      color: Colors.black54),
                                                ),
                                                Text("Total Deaths",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black87,
                                                    )),
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  content["countries_stat"][india]
                                                      ["new_cases"],
                                                  style: TextStyle(
                                                      fontSize: 25.0,
                                                      color: Colors.black54),
                                                ),
                                                Text("New Cases",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black87,
                                                    ))
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  content["countries_stat"][india]
                                                      ["new_deaths"],
                                                  style: TextStyle(
                                                      fontSize: 25.0,
                                                      color: Colors.black54),
                                                ),
                                                Text("New Deaths",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black87,
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                      } else {
                                        return Center(
                                          child: SpinKitWave(color: Colors.black),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ))
                  
                      ],
                    )
                  
                )),
    );
  }
}

class Cont extends StatefulWidget {
  final double end;
  final String text;
  final Widget page;

  const Cont({Key key, this.end, this.text, this.page}) : super(key: key);

  @override
  _ContState createState() => _ContState();
}

class _ContState extends State<Cont> with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController _controller;
  String i = "0";

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animation = Tween<double>(begin: 0, end: widget.end).animate(_controller)
      ..addListener(() {
        setState(() {
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
    return Expanded(
        child: GestureDetector(
      onTap: widget.page == null
          ? () {}
          : () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => widget.page));
            },
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: LinearGradient(colors: [
            Color(0xFFff6a00),
            Colors.orange[100],
            Color(0xFF56ab2f)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black45,
                blurRadius: 10.0,
                offset: Offset.fromDirection(4.5, -5.0))
          ],
        ),
        height: MediaQuery.of(context).size.height / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$i',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: Text(
                '${widget.text}',
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
    ));
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
