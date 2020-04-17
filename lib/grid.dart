import 'dart:convert';

// import 'package:flutter_localization_master/pages/zkcm.dart';

import 'package:flutter_localization_master/pages/DailyBasis.dart';
import 'package:line_icons/line_icons.dart';
import 'dashBoardStates.dart' as dash;
import 'ministrystate.dart';
import 'package:flutter_localization_master/localization/language_constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'selfchecker.dart';
import 'package:flutter/foundation.dart';
import 'pointClass.dart' as point;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'tracker.dart';

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

Future<Map> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/aggregates";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

List<Color> orange = [Color(0xFFff9966), Color(0xFFff5e62)];
List<Color> blue = [Color(0xFF36D1DC), Color(0xFF5B86E5)];
List<Color> sweet = [Color(0xFFFF5F6D), Color(0xFFFFC371)];
List<Color> purple = [
  Color(0xFFf80759),
  Color(0xFFbc4e9c),
];

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
            child: FutureBuilder(
              future: getUri(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  Map content = snapshot.data;
                  return AnimationConfiguration.staggeredList(
                    position: 1,
                    duration: const Duration(milliseconds: 875),
                    child: SlideAnimation(
                      verticalOffset: 150.0,
                      child: FadeInAnimation(
                        child: ListView(children: <Widget>[
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
                                    Cont(
                                      end: content['registered'].toDouble(),
                                      text: getTranslated(
                                          context, 'total_register'),

                                      // "कुल उपयोगकर्ता रजिस्टर"
                                    ),
                                    Cont(
                                      end: content['infected'].toDouble(),
                                      text: getTranslated(
                                          context, 'total_infected'),
                                      page: dash.stateList(
                                        para: "is_infected",
                                      ),
                                      //  "कुल संक्रमित व्यक्ति"
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Cont(
                                        end: content['symptoms'].toDouble(),
                                        text:
                                            getTranslated(context, 'suspected'),
                                        page: dash.stateList(
                                          para: "symptoms",
                                        ),
                                        // "संदिग्ध मामलाा"
                                      ),
                                      Cont(
                                        end: 7.0,
                                        text: getTranslated(
                                            context, 'total_cured'),
                                        // "कुल व्यक्ति ठीक हो गया"
                                        page: dash.stateList(
                                          para: "cured",
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
                                      Cont(
                                        end: 3.0,
                                        text: getTranslated(
                                            context, 'total_death'),
                                        page: dash.stateList(
                                          para: "death",
                                        ),
                                        //  "कुल मौत"
                                      ),
                                      Cont(
                                        end: 3.0,
                                        text: getTranslated(
                                            context, 'total_isolated'),
                                        page: dash.stateList(
                                          para: "isolated",
                                        ),
                                        // "कुल लोगों को अलग कर दिया"
                                      )
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Cont(end: 2.0, text: "कुल लोग बरामद"),
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                orange, Colors.deepOrange[200]),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(LineIcons.hospital_o,
                                                      size: 60),
                                                  Center(
                                                    child: Text(
                                                      getTranslated(
                                                          context, 'hospital'),
                                                      // "\nअस्पताल",
                                                      textAlign:
                                                          TextAlign.center,
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color:
                                                              Colors.black87),
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
                                                      point.hospitalgrid()),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                              decoration: decorate(
                                                  blue, Colors.blue[300]),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    LineIcons.phone,
                                                    size: 60,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      // "\nहेल्पलाइन",
                                                      getTranslated(
                                                          context, 'helpline'),
                                                      textAlign:
                                                          TextAlign.center,
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              margin: EdgeInsets.all(10.0)),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        point.helpgrid()));
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                sweet, Colors.deepOrange[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  LineIcons.flask,
                                                  size: 60.0,
                                                ),
                                                Center(
                                                  child: Text(
                                                    getTranslated(context,
                                                        'testing_labs'),
                                                    // "\nपरीक्षण प्रयोगशाला",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      point.labgrid()),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                purple, Colors.pink[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  LineIcons.map_marker,
                                                  size: 60.0,
                                                ),
                                                Center(
                                                  child: Text(
                                                    getTranslated(
                                                        context, 'blackspot'),
                                                    // "मानचित्र ",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            margin: EdgeInsets.all(10.0),
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                blue, Colors.blue[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  LineIcons.youtube_play,
                                                  size: 60.0,
                                                ),
                                                Center(
                                                  child: Text(
                                                    getTranslated(
                                                        context, 'video'),
                                                    // "\nवीडियो",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      point.videogrid()),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                sweet, Colors.deepOrange[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(LineIcons.heart_o,
                                                    size: 60.0),
                                                Center(
                                                  child: Text(
                                                    getTranslated(context,
                                                        'health_ministry'),
                                                    // "स्वास्थ्य मंत्रालय",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
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
                                              MaterialPageRoute(
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
                                                purple, Colors.pink[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  LineIcons.shield,
                                                  size: 60.0,
                                                ),
                                                Center(
                                                  child: Text(
                                                    getTranslated(
                                                        context, 'precaution'),
                                                    // "\nसावधानियां",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      point.secondgrid()),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                blue, Colors.blue[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  LineIcons.warning,
                                                  size: 60.0,
                                                ),
                                                Center(
                                                  child: Text(
                                                    getTranslated(
                                                        context, 'awareness'),
                                                    // "जागरूकता",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      point.awaregrid()),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                sweet, Colors.deepOrange[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  LineIcons.commenting,
                                                  size: 60.0,
                                                ),
                                                Center(
                                                  child: Text(
                                                    getTranslated(
                                                        context, 'advisory'),
                                                    // "\nसलाहकार",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      point.advicegrid()
                                                  // LocalAudio(),
                                                  ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                purple, Colors.pink[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  LineIcons.question_circle,
                                                  size: 60.0,
                                                ),
                                                Center(
                                                  child: Text(
                                                    "\n" +
                                                        getTranslated(
                                                            context, 'faq'),
                                                    // "\nसामान्य प्रश्न",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      point.faqgrid()),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                blue, Colors.blue[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(LineIcons.microphone,
                                                    size: 60.0),
                                                Center(
                                                  child: Text(
                                                    getTranslated(context,
                                                        'audio_sample'),
                                                    // "ऑडियो नमूना",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      point.audiogrid()),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                sweet, Colors.deepOrange[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(LineIcons.arrow_circle_up,
                                                    size: 60.0),
                                                Center(
                                                  child: Text(
                                                    getTranslated(context,
                                                        'self_checker'),
                                                    // "स्वयं जाँचकर्ता",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      checker()),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                purple, Colors.pink[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
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
                                                    getTranslated(context,
                                                        'corona_tracker'),
                                                    // "\nकोरोना ट्रैकर",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Tracker()),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                blue, Colors.blue[200]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  LineIcons.user,
                                                  size: 60.0,
                                                ),
                                                Center(
                                                  child: Text(
                                                    getTranslated(context,
                                                        'user_requrirement'),
                                                    // "लोगों की जरुरत",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      point.usergrid()),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                sweet, Colors.deepOrange[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  LineIcons.list,
                                                  size: 60.0,
                                                ),
                                                Center(
                                                  child: Text(
                                                    getTranslated(
                                                        context, 'people_info'),
                                                    // "\nअन्य व्यक्ति की जानकारी",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      point.infogrid()),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                purple, Colors.pink[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  LineIcons.database,
                                                  size: 60.0,
                                                ),
                                                Center(
                                                  child: Text(
                                                    getTranslated(context,
                                                        'external_soc'),
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      point.outgrid()),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                blue, Colors.blue[200]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image(
                                                    image: AssetImage(
                                                        'images/elab.png')),
                                                Center(
                                                  child: Text(
                                                    // "बाहरी स्रोत से परीक्षण केंद्र डेटा",
                                                    getTranslated(context,
                                                        'external_lab'),
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      point.exterTestgrid()),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                blue, Colors.blue[200]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    "Daily Basis",
                                                    textAlign: TextAlign.center,
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
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DailyBasis()),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: decorate(
                                                sweet, Colors.deepOrange[300]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(LineIcons.info_circle,
                                                    size: 60.0),
                                                Center(
                                                  child: Text(
                                                    "About App",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      point.exterTestgrid()),
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
                  );
                } else {
                  return Container(
                    child: Center(
                      child: SpinKitChasingDots(
                        color: Colors.black,
                        size: 80.0,
                      ),
                    ),
                  );
                }
              },
            )));
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
                  MaterialPageRoute(builder: (context) => widget.page));
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
