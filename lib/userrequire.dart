import 'package:flutter/material.dart';
//import 'fluttertoast.dart';
import 'familyDeclaration.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';

void makePost2(String a, String b, String c, String d, String e, double f,
    double g, String h, String i, String j, String k, var l) async {
  String url = "https://covid-mitrc.herokuapp.com/apis/requirements/create";
  var body = {
    "rashan": a,
    "gas": b,
    "medical": c,
    "remarks": d,
    "emergency": e,
    "latitude": f,
    "longitude": g,
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

class userReq extends StatefulWidget {
  @override
  _userReq createState() => _userReq();
}

class _userReq extends State<userReq> {
  List<String> dRajasthan = [
    "alwar",
    "jaipur",
    "bikaner",
    "jaisalmer",
    "bhilwara",
    "kota"
  ];

  var value1, value2, value3, value4;
  bool boolv1 = false,
      boolv2 = false,
      boolv3 = false,
      boolv4 = false,
      boolv5 = false,
      boolv6 = false,
      boolv7 = false,
      boolv8 = false;
  String selectedState;
  List<String> states = ["Rajasthan", "up", "Gujrat"];
  String selectedDistrict;
  TextEditingController remarkEditor = new TextEditingController();
  TextEditingController mobEditor = new TextEditingController();
  TextEditingController colnyEditor = new TextEditingController();
  TextEditingController hnumberEditor = new TextEditingController();
  Position position;
  StreamSubscription<Position> positionStream;
  String lat, long = '';

  getLocation() async {
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);

    positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      // print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
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
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFFFF9933),
            Color(0xFFFFFFFF),
            Color(0xFF138808),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "उपयोगकर्ता की आवश्यकता के लिए आपका स्वागत है5",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            children: <Widget>[
                              Text("राशन:"),
                              Checkbox(
                                value: boolv1,
                                onChanged: (bool value) {
                                  setState(() {
                                    value1 = "हाँ";
                                    boolv1 = value;
                                  });
                                },
                              ),
                              Text("हाँ"),
                              Checkbox(
                                value: boolv2,
                                onChanged: (bool value) {
                                  setState(() {
                                    value1 = "नहीं";
                                    boolv2 = value;
                                  });
                                },
                              ),
                              Text("नहीं")
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Text("गैस:"),
                            Checkbox(
                              value: boolv3,
                              onChanged: (bool value) {
                                setState(() {
                                  value2 = "हाँ";
                                  boolv3 = value;
                                });
                              },
                            ),
                            Text("हाँ"),
                            Checkbox(
                              value: boolv4,
                              onChanged: (bool value) {
                                setState(() {
                                  value2 = "नहीं";
                                  boolv4 = value;
                                });
                              },
                            ),
                            Text("नहीं")
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Text("मेडिकल:"),
                            Checkbox(
                              value: boolv5,
                              onChanged: (bool value) {
                                setState(() {
                                  value3 = "हाँ";
                                  boolv5 = value;
                                });
                              },
                            ),
                            Text("हाँ"),
                            Checkbox(
                              value: boolv6,
                              onChanged: (bool value) {
                                setState(() {
                                  value3 = "नहीं";
                                  boolv6 = value;
                                });
                              },
                            ),
                            Text("नहीं")
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: remarkEditor,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          // controller: passEditor,
                          decoration: InputDecoration(
                            labelText: "टिप्पणी",
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Text("आपातकालीन:"),
                            Checkbox(
                              value: boolv7,
                              onChanged: (bool value) {
                                setState(() {
                                  value4 = "हाँ";
                                  boolv7 = value;
                                });
                              },
                            ),
                            Text("हाँ"),
                            Checkbox(
                              value: boolv8,
                              onChanged: (bool value) {
                                setState(() {
                                  value4 = "नहीं";
                                  boolv8 = value;
                                });
                              },
                            ),
                            Text("नहीं")
                          ],
                        ),
                      ),
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 10.0),
                                        ]),
                                    child: Text(
                                      long,
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 10.0),
                                        ]),
                                    child: Text(
                                      lat,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 10.0),
                                        ]),
                                    child: MaterialButton(
                                      onPressed: getLocation,
                                      child: Text("स्थान प्राप्त करें"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
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
                                          style:
                                              TextStyle(color: Colors.black)),
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
                                  hint: Text('अपने जिले का चयन करें',
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
                                          style:
                                              TextStyle(color: Colors.black)),
                                      value: location,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          obscureText: false,
                          controller: mobEditor,
                          keyboardType: TextInputType.number,
                          // controller: passEditor,
                          decoration: InputDecoration(
                            labelText: "मोबाइल नंबर",
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          obscureText: false,
                          controller: colnyEditor,
                          keyboardType: TextInputType.text,
                          // controller: passEditor,
                          decoration: InputDecoration(
                            labelText: "कालोनी",
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          controller: hnumberEditor,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          // controller: passEditor,
                          decoration: InputDecoration(
                            labelText: "घर का नंबर",
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Center(
                              child: RaisedButton(
                            onPressed: () {
                              var mob = int.parse(mobEditor.text);
                              var latu = double.parse(lat.toString());
                              var longu = double.parse(long.toString());
                              makePost2(
                                  value1.toString(),
                                  value2.toString(),
                                  value3.toString(),
                                  remarkEditor.text,
                                  value4.toString(),
                                  latu,
                                  longu,
                                  colnyEditor.text,
                                  selectedState.toString(),
                                  selectedDistrict.toString(),
                                  hnumberEditor.text,
                                  mob);
                            },
                            //   Fluttertoast.showToast(
                            //       msg: valu2.toString(),
                            //       toastLength: Toast.LENGTH_SHORT);
                            // },
                            child: Text("Submit"),
                          )))
                    ],
                  ))
            ],
          )),
    );
  }
}
