import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';

class userReq extends StatefulWidget {
  @override
  _userReq createState() => _userReq();
}

void makePost2(String a, String b, String c, String d, String e, double f,
    double g, String m, String h, String i, String j, String k, var l) async {
  String url = "https://covid-mitrc.herokuapp.com/apis/requirements/create";
  var body = {
    "rashan": a,
    "gas": b,
    "medical": c,
    "remarks": d,
    "emergency": e,
    "latitude": f,
    "longitude": g,
    "feedback": m,
    "colony": h,
    "state": i,
    "district": j,
    "house": k,
    "mobile": l
  };
  Response r = await post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );
  print(r.body);
}

List<Map<String, dynamic>> animCont = [
  {"color": color5, "shadow": Colors.deepOrange[300]},
  {"color": color5, "shadow": Colors.deepOrange[300]},
  {"color": color5, "shadow": Colors.deepOrange[300]},
  {"color": color5, "shadow": Colors.black54},
  {"color": color6, "shadow": Colors.black54},
  {"color": color6, "shadow": Colors.black54},
];

List<Color> color6 = [
  Color(0xFFf80759),
  Color(0xFFbc4e9c),
];

List<Color> color3 = [
  Color(0xFF8E2DE2),
  Color(0xFF4A00E0),
];
List<Color> color1 = [
  Color(0xFF00b09b),
  Color(0xFF00b09b),
];
List<Color> color5 = [Color(0xFFFF5F6D), Color(0xFFFFC371)];
List<Color> color2 = [
  Color(0xFFff9966),
  Color(0xFFff5e62),
];
List<Color> color4 = [Color(0xFF36D1DC), Color(0xFF5B86E5)];

bool _value1 = false,
    _value2 = false,
    _value3 = false,
    _value4 = false,
    _value5 = false,
    _value6 = false,
    _value7 = false,
    _value8 = false;

class _userReq extends State<userReq> {
  List<String> dRajasthan = [
    "alwar",
    "jaipur",
    "bikaner",
    "jaisalmer",
    "bhilwara",
    "kota"
  ];
  String lat, long = '';
  Position position;
  StreamSubscription<Position> positionStream;
  TextEditingController remarkEditor = new TextEditingController();
  TextEditingController mobEditor = new TextEditingController();
  TextEditingController colnyEditor = new TextEditingController();
  TextEditingController hnumberEditor = new TextEditingController();
  TextEditingController feedbackEditor = new TextEditingController();
  String ration, gas, medical, emergency;
  String selectedState;
  List<String> states = ["Rajasthan", "up", "Gujrat"];
  String selectedDistrict;

  getLocation() async {
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);

    positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      if (position != null) {
        setState(() {
          lat = position.latitude.toString();
          long = position.longitude.toString();
        });
      } else {
        setState(() {
          lat = 'लैट्इटयूड';
          long = 'लोंगीटूड ';
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lat = 'लैट्इटयूड';
    long = 'लोंगीटूड ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 80),
                    Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                            height: 150,
                            child: Card(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation: 10,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Ration Details:",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                            onTap: () {
                                              ration = "yes";
                                              if (_value2 == false) {
                                                setState(() {
                                                  _value1 = true;
                                                });
                                              } else {
                                                setState(() {
                                                  _value1 = true;
                                                  _value2 = false;
                                                });
                                              }
                                            },
                                            child: _value1 == false
                                                ? AnimatedContainer(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.bounceInOut,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      gradient: LinearGradient(
                                                        colors: animCont[1]
                                                            ["color"],
                                                        begin: Alignment
                                                            .bottomRight,
                                                        end: Alignment.topLeft,
                                                      ),
                                                    ),
                                                    height: 80,
                                                    width: 80,
                                                    child: Center(
                                                      child: Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ))
                                                : AnimatedContainer(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.bounceInOut,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      gradient: LinearGradient(
                                                        colors: animCont[5]
                                                            ["color"],
                                                        begin: Alignment
                                                            .bottomRight,
                                                        end: Alignment.topLeft,
                                                      ),
                                                    ),
                                                    height: 80,
                                                    width: 80,
                                                    child: Icon(Icons.done),
                                                  )),
                                        GestureDetector(
                                            onTap: () {
                                              ration = "no";
                                              if (_value1 == false) {
                                                setState(() {
                                                  _value2 = true;
                                                });
                                              } else {
                                                setState(() {
                                                  _value2 = true;
                                                  _value1 = false;
                                                });
                                              }
                                            },
                                            child: _value2 == false
                                                ? Center(
                                                    child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve:
                                                            Curves.bounceInOut,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                          gradient:
                                                              LinearGradient(
                                                            colors: animCont[1]
                                                                ["color"],
                                                            begin: Alignment
                                                                .bottomRight,
                                                            end: Alignment
                                                                .topLeft,
                                                          ),
                                                        ),
                                                        height: 80,
                                                        width: 80,
                                                        child: Center(
                                                          child: Text("No",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        )),
                                                  )
                                                : Center(
                                                    child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve:
                                                            Curves.bounceInOut,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                          gradient:
                                                              LinearGradient(
                                                            colors: animCont[5]
                                                                ["color"],
                                                            begin: Alignment
                                                                .bottomRight,
                                                            end: Alignment
                                                                .topLeft,
                                                          ),
                                                        ),
                                                        height: 80,
                                                        width: 80,
                                                        child: Center(
                                                          child:
                                                              Icon(Icons.done),
                                                        )),
                                                  ))
                                      ],
                                    ),
                                  ],
                                )))),
                    SizedBox(height: 30),
                    Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                            height: 150,
                            child: Card(
                                elevation: 10,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Gas Details:",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                            onTap: () {
                                              gas = "yes";
                                              if (_value4 == false) {
                                                setState(() {
                                                  _value3 = true;
                                                });
                                              } else {
                                                setState(() {
                                                  _value3 = true;
                                                  _value4 = false;
                                                });
                                              }
                                            },
                                            child: _value3 == false
                                                ? AnimatedContainer(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.bounceInOut,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      gradient: LinearGradient(
                                                        colors: animCont[1]
                                                            ["color"],
                                                        begin: Alignment
                                                            .bottomRight,
                                                        end: Alignment.topLeft,
                                                      ),
                                                    ),
                                                    height: 80,
                                                    width: 80,
                                                    child: Center(
                                                      child: Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ))
                                                : AnimatedContainer(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.bounceInOut,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      gradient: LinearGradient(
                                                        colors: animCont[5]
                                                            ["color"],
                                                        begin: Alignment
                                                            .bottomRight,
                                                        end: Alignment.topLeft,
                                                      ),
                                                    ),
                                                    height: 80,
                                                    width: 80,
                                                    child: Icon(Icons.done),
                                                  )),
                                        GestureDetector(
                                            onTap: () {
                                              gas = "no";
                                              if (_value3 == false) {
                                                setState(() {
                                                  _value4 = true;
                                                });
                                              } else {
                                                setState(() {
                                                  _value4 = true;
                                                  _value3 = false;
                                                });
                                              }
                                            },
                                            child: _value4 == false
                                                ? Center(
                                                    child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve:
                                                            Curves.bounceInOut,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                          gradient:
                                                              LinearGradient(
                                                            colors: animCont[1]
                                                                ["color"],
                                                            begin: Alignment
                                                                .bottomRight,
                                                            end: Alignment
                                                                .topLeft,
                                                          ),
                                                        ),
                                                        height: 80,
                                                        width: 80,
                                                        child: Center(
                                                          child: Text("No",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        )),
                                                  )
                                                : Center(
                                                    child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve:
                                                            Curves.bounceInOut,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                          gradient:
                                                              LinearGradient(
                                                            colors: animCont[5]
                                                                ["color"],
                                                            begin: Alignment
                                                                .bottomRight,
                                                            end: Alignment
                                                                .topLeft,
                                                          ),
                                                        ),
                                                        height: 80,
                                                        width: 80,
                                                        child: Center(
                                                          child:
                                                              Icon(Icons.done),
                                                        )),
                                                  ))
                                      ],
                                    ),
                                  ],
                                )))),
                    SizedBox(height: 30),
                    Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                            height: 150,
                            child: Card(
                                elevation: 10,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Emergency Details:",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                            onTap: () {
                                              emergency = "yes";

                                              if (_value8 == false) {
                                                setState(() {
                                                  _value7 = true;
                                                });
                                              } else {
                                                setState(() {
                                                  _value7 = true;
                                                  _value8 = false;
                                                });
                                              }
                                            },
                                            child: _value7 == false
                                                ? AnimatedContainer(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.bounceInOut,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      gradient: LinearGradient(
                                                        colors: animCont[1]
                                                            ["color"],
                                                        begin: Alignment
                                                            .bottomRight,
                                                        end: Alignment.topLeft,
                                                      ),
                                                    ),
                                                    height: 80,
                                                    width: 80,
                                                    child: Center(
                                                      child: Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ))
                                                : AnimatedContainer(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.bounceInOut,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      gradient: LinearGradient(
                                                        colors: animCont[5]
                                                            ["color"],
                                                        begin: Alignment
                                                            .bottomRight,
                                                        end: Alignment.topLeft,
                                                      ),
                                                    ),
                                                    height: 80,
                                                    width: 80,
                                                    child: Icon(Icons.done),
                                                  )),
                                        GestureDetector(
                                            onTap: () {
                                              emergency = "no";
                                              if (_value7 == false) {
                                                setState(() {
                                                  _value8 = true;
                                                });
                                              } else {
                                                setState(() {
                                                  _value8 = true;
                                                  _value7 = false;
                                                });
                                              }
                                            },
                                            child: _value8 == false
                                                ? Center(
                                                    child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve:
                                                            Curves.bounceInOut,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                          gradient:
                                                              LinearGradient(
                                                            colors: animCont[1]
                                                                ["color"],
                                                            begin: Alignment
                                                                .bottomRight,
                                                            end: Alignment
                                                                .topLeft,
                                                          ),
                                                        ),
                                                        height: 80,
                                                        width: 80,
                                                        child: Center(
                                                          child: Text("No",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        )),
                                                  )
                                                : Center(
                                                    child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve:
                                                            Curves.bounceInOut,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                          gradient:
                                                              LinearGradient(
                                                            colors: animCont[5]
                                                                ["color"],
                                                            begin: Alignment
                                                                .bottomRight,
                                                            end: Alignment
                                                                .topLeft,
                                                          ),
                                                        ),
                                                        height: 80,
                                                        width: 80,
                                                        child: Center(
                                                          child:
                                                              Icon(Icons.done),
                                                        )),
                                                  ))
                                      ],
                                    ),
                                  ],
                                )))),
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 100,
                                  height: 30.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 10.0),
                                      ]),
                                  child: Text(
                                    long,
                                    // "jhjhn",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                  width: 100,
                                  height: 30.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 10.0),
                                      ]),
                                  child: Text(
                                    lat,
                                    // "jhjhn",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 10.0),
                                      ]),
                                  child: MaterialButton(
                                    onPressed: getLocation,
                                    child: Text(
                                        // getTranslated(context, 'fetch'),
                                        "स्थान प्राप्त करें"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    SizedBox(height: 20),
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                // border: Border.all(
                                //     color: Colors.white,
                                //     style: BorderStyle.solid,
                                //     width: 0.80),
                              ),
                              child: DropdownButton(
                                iconDisabledColor: Colors.black,
                                hint: Text(
                                  // getTranslated(context, 'select_state'),
                                  'अपना राज्य चुनें',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                ),
                                value: selectedState,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedState = newValue;
                                  });
                                },
                                items: states.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location,
                                        style: TextStyle(color: Colors.black)),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: DropdownButton(
                                hint: Text(
                                    // getTranslated(context, 'select_district'),
                                    'अपने जिले का चयन करें',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15.0)),
                                value: selectedDistrict,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedDistrict = newValue;
                                  });
                                },
                                items: dRajasthan.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location,
                                        style: TextStyle(color: Colors.black)),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 30),
                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: remarkEditor,
                          decoration: InputDecoration(
                            labelText: "Remarks",
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                        )),
                    SizedBox(height: 30),
                    Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: AnimatedContainer(
                            curve: Curves.bounceInOut,
                            duration: Duration(milliseconds: 500),
                            height: 150,
                            child: Card(
                                elevation: 10,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Medical Facility:",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                            onTap: () {
                                              medical = "yes";
                                              if (_value6 == false) {
                                                setState(() {
                                                  _value5 = true;
                                                });
                                              } else {
                                                setState(() {
                                                  _value5 = true;
                                                  _value6 = false;
                                                });
                                              }
                                            },
                                            child: _value5 == false
                                                ? AnimatedContainer(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.bounceInOut,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      gradient: LinearGradient(
                                                        colors: animCont[1]
                                                            ["color"],
                                                        begin: Alignment
                                                            .bottomRight,
                                                        end: Alignment.topLeft,
                                                      ),
                                                    ),
                                                    height: 80,
                                                    width: 80,
                                                    child: Center(
                                                      child: Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ))
                                                : AnimatedContainer(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.easeInOut,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      gradient: LinearGradient(
                                                        colors: animCont[5]
                                                            ["color"],
                                                        begin: Alignment
                                                            .bottomRight,
                                                        end: Alignment.topLeft,
                                                      ),
                                                    ),
                                                    height: 80,
                                                    width: 80,
                                                    child: Icon(Icons.done),
                                                  )),
                                        GestureDetector(
                                            onTap: () {
                                              medical = "no";
                                              if (_value5 == false) {
                                                setState(() {
                                                  _value6 = true;
                                                });
                                              } else {
                                                setState(() {
                                                  _value6 = true;
                                                  _value5 = false;
                                                });
                                              }
                                            },
                                            child: _value6 == false
                                                ? Center(
                                                    child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve: Curves.easeInOut,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                          gradient:
                                                              LinearGradient(
                                                            colors: animCont[1]
                                                                ["color"],
                                                            begin: Alignment
                                                                .bottomRight,
                                                            end: Alignment
                                                                .topLeft,
                                                          ),
                                                        ),
                                                        height: 80,
                                                        width: 80,
                                                        child: Center(
                                                          child: Text("No",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        )),
                                                  )
                                                : Center(
                                                    child: AnimatedContainer(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.easeInOut,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      gradient: LinearGradient(
                                                        colors: animCont[5]
                                                            ["color"],
                                                        begin: Alignment
                                                            .bottomRight,
                                                        end: Alignment.topLeft,
                                                      ),
                                                    ),
                                                    height: 80,
                                                    width: 80,
                                                    child: Icon(Icons.done),
                                                  )))
                                      ],
                                    ),
                                  ],
                                )))),
                    SizedBox(height: 30),
                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: mobEditor,
                          decoration: InputDecoration(
                            labelText: "Mobile Number",
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                        )),
                    SizedBox(height: 30),
                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: colnyEditor,
                          decoration: InputDecoration(
                            labelText: "Colony",
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                        )),
                    SizedBox(height: 30),
                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: hnumberEditor,
                          decoration: InputDecoration(
                            labelText: "House Number",
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                        )),
                    SizedBox(height: 30),
                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: feedbackEditor,
                          decoration: InputDecoration(
                            labelText: "Feedback",
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Container(
                        width: 200,
                        child: RaisedButton(
                          color: Color(0xFF57bbd8),
                          highlightElevation: 10,
                          onPressed: () {
                            var mob = int.parse(mobEditor.text);
                            var latu = double.parse(lat.toString());
                            var longu = double.parse(long.toString());
                            makePost2(
                                ration.toString(),
                                gas.toString(),
                                medical.toString(),
                                remarkEditor.text,
                                emergency.toString(),
                                latu,
                                longu,
                                feedbackEditor.text,
                                colnyEditor.text,
                                selectedState.toString(),
                                selectedDistrict.toString(),
                                hnumberEditor.text,
                                mob);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: Text(
                            "Submit",
                            // getTranslated(context, 'login'),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}
