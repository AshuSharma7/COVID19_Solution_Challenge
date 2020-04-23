import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
import 'registerVariables.dart' as declaration;
import 'dart:async';

class userReq extends StatefulWidget {
  @override
  _userReq createState() => _userReq();
}

List<Map<String, dynamic>> animCont = [
  {"color": sweet, "shadow": Colors.deepOrange[300]},
  {"color": sweet, "shadow": Colors.deepOrange[300]},
  {"color": color5, "shadow": Colors.deepOrange[300]},
  {"color": color5, "shadow": Colors.black54},
  {"color": color6, "shadow": Colors.black54},
  {"color": color6, "shadow": Colors.black54},
];
int id = 0;
String state, district;
bool stateWidget = false;
bool medical = false;
void makePost2(String a, String b, String c, String d, bool e, double f,
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

bool _value5, _value6 = false;
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
List<Color> orange = [Color(0xFFff9966), Color(0xFFff5e62)];
List<Color> blue = [Color(0xFF36D1DC), Color(0xFF5B86E5)];
List<Color> sweet = [Color(0xFFFF5F6D), Color(0xFFFFC371)];
List<Color> purple = [
  Color(0xFFbc4e9c),
  Color(0xFFf80759),
];

class _userReq extends State<userReq> {
  List<String> dRajasthan = [
    "alwar",
    "jaipur",
    "bikaner",
    "jaisalmer",
    "bhilwara",
    "kota"
  ];
  double lat, long;
  Position position;
  StreamSubscription<Position> positionStream;
  TextEditingController rationEditor = new TextEditingController();
  TextEditingController gasEditor = new TextEditingController();
  TextEditingController emegrencyEditor = new TextEditingController();
  TextEditingController remarkEditor = new TextEditingController();
  TextEditingController mobEditor = new TextEditingController();
  TextEditingController colnyEditor = new TextEditingController();
  TextEditingController hnumberEditor = new TextEditingController();
  TextEditingController feedbackEditor = new TextEditingController();
  String selectedState;
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
          lat = position.latitude;
          long = position.longitude;
        });
      } else {
        setState(() {
          lat = 0.0;
          long = 0.0;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lat = 0.0;
    long = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 80),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        gradient: LinearGradient(
                            colors: blue,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue[400],
                              blurRadius: 20.0,
                              offset: Offset.fromDirection(4.0, -10.0))
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          controller: rationEditor,
                          cursorColor: Colors.white,
                          focusNode: FocusNode(canRequestFocus: false),
                          textCapitalization: TextCapitalization.sentences,
                          style:
                              TextStyle(color: Colors.white60, fontSize: 20.0),
                          decoration: InputDecoration(
                              hintText: "Enter Ration details",
                              hintStyle: TextStyle(
                                fontSize: 20.0,
                              ),
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        gradient: LinearGradient(
                            colors: sweet,
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.deepOrange[300],
                              blurRadius: 20.0,
                              offset: Offset.fromDirection(4.0, -10.0))
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: gasEditor,
                          cursorColor: Colors.white,
                          focusNode: FocusNode(canRequestFocus: false),
                          textCapitalization: TextCapitalization.sentences,
                          style:
                              TextStyle(color: Colors.white60, fontSize: 20.0),
                          decoration: InputDecoration(
                              hintText: "Enter Gas details",
                              hintStyle: TextStyle(
                                fontSize: 20.0,
                              ),
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        gradient: LinearGradient(
                            colors: orange,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.deepOrange[300],
                              blurRadius: 20.0,
                              offset: Offset.fromDirection(4.0, -10.0))
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          controller: emegrencyEditor,
                          cursorColor: Colors.white,
                          focusNode: FocusNode(canRequestFocus: false),
                          textCapitalization: TextCapitalization.sentences,
                          style:
                              TextStyle(color: Colors.white60, fontSize: 20.0),
                          decoration: InputDecoration(
                              hintText: "Enter Medical Emergency details",
                              hintStyle: TextStyle(
                                fontSize: 20.0,
                              ),
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          width: 100,
                          height: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            gradient: LinearGradient(
                              colors: animCont[2]["color"],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: animCont[2]["shadow"],
                                  blurRadius: 14.0,
                                  spreadRadius: 0.1,
                                  offset: Offset.fromDirection(4.0, -5.0))
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                getLocation();
                                if (medical == true) {
                                  setState(
                                    () {
                                      medical = false;
                                      animCont[2]["color"] = blue;
                                      animCont[2]["shadow"] = Colors.blue[300];
                                    },
                                  );
                                } else if (medical == false) {
                                  setState(
                                    () {
                                      medical = true;
                                      animCont[2]["color"] = purple;
                                      animCont[2]["shadow"] = Colors.pink[600];
                                    },
                                  );
                                }
                              },
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Need Medical Facility?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black54),
                                  ),
                                  Text((medical == true) ? "Yes" : "No")
                                ],
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          width: 100,
                          height: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            gradient: LinearGradient(
                              colors: animCont[1]["color"],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: lat == 0.0
                                      ? animCont[1]["shadow"]
                                      : Colors.blue[800],
                                  blurRadius: 14.0,
                                  spreadRadius: 0.1,
                                  offset: Offset.fromDirection(4.0, -5.0))
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                getLocation();
                                setState(
                                  () {
                                    animCont[1]["color"] = [
                                      Color(0xFF005C97),
                                      Color(0xFF363795)
                                    ];
                                  },
                                );
                              },
                              child: Center(
                                  child: lat == 0.0
                                      ? Text(
                                          "Get location",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54),
                                        )
                                      : Icon(Icons.done,
                                          color: lat == 0.0
                                              ? Colors.black
                                              : Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          width: 100,
                          height: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            gradient: LinearGradient(
                              colors: animCont[3]["color"],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: animCont[3]["shadow"],
                                  blurRadius: 20.0,
                                  spreadRadius: 0.1,
                                  offset: Offset.fromDirection(4.0, -10.0))
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Container(
                                            height: 200,
                                            child: Column(
                                              children: <Widget>[
                                                DropdownButton(
                                                  iconDisabledColor:
                                                      Colors.black,
                                                  hint: Text(
                                                    "Select State",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15.0),
                                                  ),
                                                  value: selectedState,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      district = "";
                                                      id = declaration
                                                          .statesID[newValue];
                                                      selectedState = newValue;
                                                    });
                                                  },
                                                  items: declaration.stateList
                                                      .map((location) {
                                                    return DropdownMenuItem(
                                                      child: new Text(location,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                      value: location,
                                                    );
                                                  }).toList(),
                                                ),
                                                DropdownButton(
                                                  iconDisabledColor:
                                                      Colors.black,
                                                  hint: Text(
                                                    "Select District",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15.0),
                                                  ),
                                                  value: selectedDistrict,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      selectedDistrict =
                                                          newValue;
                                                      district = newValue;
                                                    });
                                                  },
                                                  items: declaration
                                                      .districtList[id]
                                                      .map((location) {
                                                    return DropdownMenuItem(
                                                      child: new Text(location,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                      value: location,
                                                    );
                                                  }).toList(),
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                MaterialButton(
                                                  color: Colors.teal,
                                                  onPressed: () {
                                                    if (district != "" ||
                                                        state !=
                                                            "Select State") {
                                                      setState(() {
                                                        stateWidget = true;
                                                        animCont[3]["color"] =
                                                            blue;
                                                        animCont[3]["shadow"] =
                                                            Colors.blue[300];
                                                      });
                                                    }
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Submit"),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              },
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Select State & District",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white70),
                                  ),
                                  stateWidget == true
                                      ? Icon(Icons.done, color: Colors.white)
                                      : Text(""),
                                ],
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
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
                      padding: EdgeInsets.only(top: 10),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            var mob = int.parse(mobEditor.text);
                            makePost2(
                                rationEditor.text,
                                gasEditor.text,
                                emegrencyEditor.text,
                                remarkEditor.text,
                                medical,
                                lat,
                                long,
                                feedbackEditor.text,
                                colnyEditor.text,
                                selectedState.toString(),
                                selectedDistrict.toString(),
                                hnumberEditor.text,
                                mob);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF1488CC),
                                      Color(0xFF2B32B2)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blue[800],
                                      blurRadius: 20.0,
                                      offset: Offset.fromDirection(4.5, -10.0))
                                ],
                              ),
                              padding: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 20.0,
                                  right: 20.0),
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}
