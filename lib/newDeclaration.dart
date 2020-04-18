import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization_master/pages/bottomNavBar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'registerVariables.dart' as declaration;

class Declaration extends StatefulWidget {
  int memberIndex;
  Declaration({Key key, @required this.memberIndex}) : super(key: key);
  @override
  _DeclarationState createState() => _DeclarationState();
}

bool onTapped = true;
double width = 150;
double height = 50;
int members;
int tempIndex = 0;

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
TextEditingController temp = new TextEditingController();

Future<bool> _exitApp(BuildContext context) {
  return showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text('Do you want to go back to previous page?'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            new FlatButton(
              onPressed: () {
                tempIndex--;
                return Navigator.of(context).pop(true);
              },
              child: new Text('Yes'),
            ),
          ],
        ),
      ) ??
      false;
}

class _DeclarationState extends State<Declaration>
    with SingleTickerProviderStateMixin {
  double lat = 0.0, long = 0.0;
  Position position;
  StreamSubscription<Position> positionStream;
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

  int id = 0;
  String selectedState;
  String selectedDistrict;
  List<Map<String, dynamic>> animCont = [
    {"color": color5, "shadow": Colors.deepOrange[300]},
    {"color": color5, "shadow": Colors.deepOrange[300]},
    {"color": color5, "shadow": Colors.deepOrange[300]},
    {"color": color5, "shadow": Colors.black54},
    {"color": color6, "shadow": Colors.black54},
    {"color": color6, "shadow": Colors.black54},
  ];
  void initState() {
    super.initState();
    lat = 0.0;
    long = 0.0;
    onTapped = true;
    if (declaration.gender[widget.memberIndex] == "Male") {
      setState(() {
        animCont[0]["color"] = color4;
        animCont[0]["shadow"] = Colors.blue[400];
      });
    } else if (declaration.gender[widget.memberIndex] == "Female") {
      setState(() {
        animCont[0]["color"] = [
          Color(0xFFf80759),
          Color(0xFFbc4e9c),
        ];
        animCont[0]["shadow"] = Colors.pink[400];
      });
    }
    width = 150;
    height = 50;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Center(
            child: Text("Form " + (widget.memberIndex + 1).toString(),
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black87,
                )),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        gradient: LinearGradient(
                            colors: color4,
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
                          maxLines: 2,
                          controller: declaration.editor[widget.memberIndex],
                          cursorColor: Colors.white,
                          focusNode: FocusNode(canRequestFocus: false),
                          textCapitalization: TextCapitalization.sentences,
                          style:
                              TextStyle(color: Colors.white60, fontSize: 30.0),
                          decoration: InputDecoration(
                              hintText: "Enter Name",
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
                      height: 20.0,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        gradient: LinearGradient(
                            colors: [Color(0xFFEECDA3), Color(0xFFEF629F)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.pinkAccent[100],
                              blurRadius: 20.0,
                              spreadRadius: 0.1,
                              offset: Offset.fromDirection(4.0, -10.0))
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          cursorColor: Colors.white,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          maxLength: 12,
                          focusNode: FocusNode(canRequestFocus: false),
                          keyboardType:
                              TextInputType.numberWithOptions(signed: false),
                          controller:
                              declaration.adhharEditor[widget.memberIndex],
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              hintText: "Enter Aadhar No.",
                              counterText: "",
                              hintStyle: TextStyle(
                                fontSize: 20.0,
                              ),
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      width: 100,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        gradient: LinearGradient(
                          colors: animCont[0]["color"],
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: animCont[0]["shadow"],
                              blurRadius: 20.0,
                              spreadRadius: 0.1,
                              offset: Offset.fromDirection(4.0, -10.0))
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (declaration.gender[widget.memberIndex] ==
                                "Male") {
                              setState(() {
                                animCont[0]["color"] = [
                                  Color(0xFFf80759),
                                  Color(0xFFbc4e9c),
                                ];
                                animCont[0]["shadow"] = Colors.pink[400];
                                declaration.gender[widget.memberIndex] =
                                    "Female";
                              });
                            } else if (declaration.gender[widget.memberIndex] ==
                                "Female") {
                              setState(() {
                                animCont[0]["color"] = color4;
                                animCont[0]["shadow"] = Colors.blue[400];
                                declaration.gender[widget.memberIndex] = "Male";
                              });
                            }
                            if (declaration.gender[widget.memberIndex] == "g") {
                              setState(() {
                                animCont[0]["color"] = color4;
                                animCont[0]["shadow"] = Colors.blue[400];
                                declaration.gender[widget.memberIndex] = "Male";
                              });
                            }
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Gender",
                                  style: TextStyle(
                                      fontSize: 23.0, color: Colors.black54),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                declaration.gender[widget.memberIndex] == ""
                                    ? Text("")
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            declaration.gender[
                                                        widget.memberIndex] ==
                                                    "g"
                                                ? ""
                                                : declaration
                                                    .gender[widget.memberIndex],
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black87),
                                          ),
                                        ],
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
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
                                  : Colors.blue[900],
                              blurRadius: 20.0,
                              spreadRadius: 0.1,
                              offset: Offset.fromDirection(4.0, -10.0))
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (widget.memberIndex == 0) {
                              getLocation();
                            } else {}
                            setState(() {
                              animCont[1]["color"] = [
                                Color(0xFF005C97),
                                Color(0xFF363795)
                              ];
                            });
                          },
                          child: Center(
                            child: widget.memberIndex == 0
                                ? (lat == 0.0
                                    ? Text(
                                        "Get location",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54),
                                      )
                                    : Icon(Icons.done,
                                        color: lat == 0.0
                                            ? Colors.black
                                            : Colors.white))
                                : Text(
                                    "Select Address",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black54),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        gradient: LinearGradient(
                          colors: color5,
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
                                              iconDisabledColor: Colors.black,
                                              hint: Text(
                                                "Select State",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.0),
                                              ),
                                              value: selectedState,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  declaration.district[
                                                      widget.memberIndex] = "";
                                                  id = declaration
                                                      .statesID[newValue];
                                                  selectedState = newValue;
                                                  declaration.state[widget
                                                      .memberIndex] = newValue;
                                                });
                                              },
                                              items: declaration.stateList
                                                  .map((location) {
                                                return DropdownMenuItem(
                                                  child: new Text(location,
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                  value: location,
                                                );
                                              }).toList(),
                                            ),
                                            DropdownButton(
                                              iconDisabledColor: Colors.black,
                                              hint: Text(
                                                "Select District",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.0),
                                              ),
                                              value: selectedDistrict,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedDistrict = newValue;
                                                  declaration.district[widget
                                                      .memberIndex] = newValue;
                                                });
                                              },
                                              items: declaration
                                                  .districtList[id]
                                                  .map((location) {
                                                return DropdownMenuItem(
                                                  child: new Text(location,
                                                      style: TextStyle(
                                                          color: Colors.black)),
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
                              child: Text(
                            "Select State & District",
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.black54),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (declaration.isInfected[widget.memberIndex] ==
                            true) {
                          setState(() {
                            declaration.isInfected[widget.memberIndex] = false;
                            animCont[3]["color"] = color4;
                            animCont[3]["shadow"] = Colors.black54;
                          });
                        } else if (declaration.isInfected[widget.memberIndex] ==
                            false) {
                          setState(() {
                            declaration.isInfected[widget.memberIndex] = true;
                            animCont[3]["color"] = color6;
                            animCont[3]["shadow"] = Colors.black54;
                          });
                        }
                      },
                      child: AnimatedContainer(
                        onEnd: () {
                          if (declaration.isInfected[widget.memberIndex] ==
                              true) {
                            setState(() {
                              animCont[3]["shadow"] = Colors.pink[400];
                            });
                          } else if (declaration
                                  .isInfected[widget.memberIndex] ==
                              false) {
                            setState(() {
                              animCont[3]["shadow"] = Colors.blue[400];
                            });
                          }
                        },
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                        width: 100,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          gradient: LinearGradient(
                            colors: animCont[3]["color"],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: animCont[3]["shadow"],
                                blurRadius: 20.0,
                                spreadRadius: 0.1,
                                offset: Offset.fromDirection(4.0, -10.0))
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Is Infected?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black54),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    declaration.isInfected[
                                                widget.memberIndex] ==
                                            true
                                        ? "Yes"
                                        : "No",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black87),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (declaration.isCured[widget.memberIndex] == false) {
                          setState(() {
                            declaration.isCured[widget.memberIndex] = true;
                            animCont[4]["color"] = color4;
                            animCont[4]["shadow"] = Colors.black54;
                          });
                        } else if (declaration.isCured[widget.memberIndex] ==
                            true) {
                          setState(() {
                            declaration.isCured[widget.memberIndex] = false;
                            animCont[4]["color"] = color6;
                            animCont[4]["shadow"] = Colors.black54;
                          });
                        }
                      },
                      child: AnimatedContainer(
                        onEnd: () {
                          if (declaration.isCured[widget.memberIndex] ==
                              false) {
                            setState(() {
                              animCont[4]["shadow"] = Colors.pink[400];
                            });
                          } else if (declaration.isCured[widget.memberIndex] ==
                              true) {
                            setState(() {
                              animCont[4]["shadow"] = Colors.blue[400];
                            });
                          }
                        },
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                        width: 100,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          gradient: LinearGradient(
                            colors: animCont[4]["color"],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: animCont[4]["shadow"],
                                blurRadius: 20.0,
                                spreadRadius: 0.1,
                                offset: Offset.fromDirection(4.0, -10.0))
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Is Cured?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black54),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    declaration.isCured[widget.memberIndex] ==
                                            true
                                        ? "Yes"
                                        : "No",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black87),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (declaration.hospitalised[widget.memberIndex] ==
                            false) {
                          setState(() {
                            declaration.hospitalised[widget.memberIndex] = true;
                            animCont[5]["color"] = color4;
                            animCont[5]["shadow"] = Colors.black54;
                          });
                        } else if (declaration
                                .hospitalised[widget.memberIndex] ==
                            true) {
                          setState(() {
                            declaration.hospitalised[widget.memberIndex] =
                                false;
                            animCont[5]["color"] = color6;
                            animCont[5]["shadow"] = Colors.black54;
                          });
                        }
                      },
                      child: AnimatedContainer(
                        onEnd: () {
                          if (declaration.hospitalised[widget.memberIndex] ==
                              false) {
                            setState(() {
                              animCont[5]["shadow"] = Colors.pink[400];
                            });
                          } else if (declaration
                                  .hospitalised[widget.memberIndex] ==
                              true) {
                            setState(() {
                              animCont[5]["shadow"] = Colors.blue[400];
                            });
                          }
                        },
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                        width: 100,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          gradient: LinearGradient(
                            colors: animCont[5]["color"],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: animCont[5]["shadow"],
                                blurRadius: 20.0,
                                spreadRadius: 0.1,
                                offset: Offset.fromDirection(4.0, -10.0))
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Is Hospitalised?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black54),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    declaration.hospitalised[
                                                widget.memberIndex] ==
                                            true
                                        ? "Yes"
                                        : "No",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black87),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  onEnd: () {},
                  margin: EdgeInsets.all(15.0),
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    gradient: LinearGradient(colors: [
                      Color(0xFF8E2DE2),
                      Color(0xFF4A00E0),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.deepPurple[300],
                          blurRadius: 20.0,
                          offset: Offset.fromDirection(4.5, -10.0))
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          width = MediaQuery.of(context).size.width;
                          height = 100;
                        });
                        onTapped == true
                            ? onTapped = false
                            : showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF0F2027),
                                                  Color(0xFF203A43),
                                                  Color(0xFF2C5364)
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight),
                                          ),
                                          margin: EdgeInsets.all(10.0),
                                          padding: EdgeInsets.all(10.0),
                                          height: 400,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "Select Options",
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 20.0),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "Fever?",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: true,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["fever"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "fever"] = value;
                                                            ;
                                                          });
                                                        }),
                                                    Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: false,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["fever"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "fever"] = value;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "Cough?",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: true,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["cough"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "cough"] = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: false,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["cough"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "cough"] = value;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "Short Breath?",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: true,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["breathing"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "breathing"] = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: false,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["breathing"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "breathing"] = value;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "Running \nNose?",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: true,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["nose"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "nose"] = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: false,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["nose"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "nose"] = value;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "Dizziness?",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: true,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["dizziness"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "dizziness"] = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: false,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["dizziness"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "dizziness"] = value;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "Difficulty\nin\npronounciation?",
                                                      style: TextStyle(
                                                          color: Colors.white70,
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: true,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["pronounciation"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "pronounciation"] = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: false,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["pronounciation"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "pronounciation"] = value;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "Chest/Throat\nPain?",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: true,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["throatchest"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "throatchest"] = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: false,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["throatchest"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "throatchest"] = value;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "Diarrhea?",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: true,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["diarrhea"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "diarrhea"] = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: false,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["diarrhea"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "diarrhea"] = value;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "Attended \njamat?",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: true,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["attendJamat"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "attendJamat"] = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: false,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["attendJamat"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "attendJamat"] = value;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "Met\nany\njamati?",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: true,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["metJamatis"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "metJamatis"] = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: false,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            ["metJamatis"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "metJamatis"] = value;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "Met someone\nwho\nvisited\nabroad?",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: true,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            [
                                                            "metSomeoneAbroad"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "metSomeoneAbroad"] = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: false,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            [
                                                            "metSomeoneAbroad"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "metSomeoneAbroad"] = value;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "Visited any\ncorona\noutbreak\nplace?",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: true,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            [
                                                            "outbreakPlaceVisit"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "outbreakPlaceVisit"] = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    Radio(
                                                        value: false,
                                                        groupValue: declaration
                                                                    .symptoms[
                                                                widget
                                                                    .memberIndex]
                                                            [
                                                            "outbreakPlaceVisit"],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            declaration.symptoms[
                                                                    widget
                                                                        .memberIndex]
                                                                [
                                                                "outbreakPlaceVisit"] = value;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Ok",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  color:
                                                      const Color(0xFF1BC0C5),
                                                ),
                                              ],
                                            ),
                                          )),
                                    );
                                  });
                                });
                      },
                      child: Center(
                        child: Text(
                          onTapped == true
                              ? "Tap"
                              : "Select options which satisfies you",
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF1488CC), Color(0xFF2B32B2)],
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
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        if (declaration.editor[widget.memberIndex].text ==
                                    null ||
                                declaration.editor[widget.memberIndex].text ==
                                    "" ||
                                declaration.adhharEditor[widget.memberIndex]
                                        .text ==
                                    null ||
                                declaration.adhharEditor[widget.memberIndex]
                                        .text ==
                                    "" ||
                                widget.memberIndex == 0
                            ? false
                            : (declaration.addressEditor[widget.memberIndex]
                                        .text ==
                                    null ||
                                declaration.addressEditor[widget.memberIndex]
                                        .text ==
                                    "")) {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("One or More fields are Empty"),
                                  actions: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.done),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                );
                              });
                        } else {
                          if (tempIndex < (members - 1)) {
                            setState(() {
                              tempIndex = tempIndex + 1;
                            });
                            print(tempIndex);
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        Declaration(memberIndex: tempIndex)));
                          } else {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            for (int i = 0; i < members; i++) {
                              if (declaration.symptoms[i]["attendJamat"] ==
                                      true ||
                                  declaration.symptoms[i]["metJamatis"] ==
                                      true ||
                                  declaration.symptoms[i]["metSomeoneAbroad"] ||
                                  declaration.symptoms[i]
                                      ["outbreakPlaceVisit"]) {
                                declaration.haveSymptoms[i] = true;
                              } else if (declaration.symptoms[i]["dizziness"] ==
                                      true ||
                                  declaration.symptoms[i]["cough"] == true &&
                                      declaration.symptoms[i]["nose"] == true &&
                                      declaration.symptoms[i]["fever"] ==
                                          true) {
                                declaration.haveSymptoms[i] = true;
                              } else if (declaration.symptoms[i]["cough"] ==
                                      true &&
                                  declaration.symptoms[i]["nose"] == true &&
                                  declaration.symptoms[i]["fever"] == true &&
                                  declaration.symptoms[i]["throatchest"] ==
                                      true) {
                                declaration.haveSymptoms[i] = true;
                              } else if (declaration.symptoms[i]["cough"] ==
                                      true &&
                                  declaration.symptoms[i]["nose"] == true &&
                                  (declaration.symptoms[i]["pronounciation"] ==
                                          true ||
                                      declaration.symptoms[i]["breathing"] ==
                                          true ||
                                      declaration.symptoms[i]["diarrhea"] ==
                                          true)) {
                                declaration.haveSymptoms[i] = true;
                              } else {
                                declaration.haveSymptoms[i] = false;
                              }
                              if (members != 1) {
                                Map content = await declaration.geoCoding(
                                    declaration.addressEditor[i].text);
                                lat = content["results"][0]["geometry"]
                                    ["location"]["lat"];
                                long = content["results"][0]["geometry"]
                                    ["location"]["lng"];
                              }
                              declaration.makePost(
                                  int.parse(prefs.getString('aadhar')),
                                  declaration.editor[i].text,
                                  declaration.gender[i],
                                  declaration.adhharEditor[i].text,
                                  declaration.isInfected[i],
                                  declaration.haveSymptoms[i],
                                  declaration.isCured[i],
                                  declaration.district[i],
                                  declaration.state[i],
                                  declaration.haveTravelled[i],
                                  declaration.from[i],
                                  declaration.to[i],
                                  declaration.addressEditor[i].text,
                                  lat,
                                  long);
                            }
                            if (declaration.error == false) {
                              prefs.setBool('declared', true);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => BottomnavBar()),
                                  (_) => false);
                            }
                          }
                        }
                      },
                      child: Center(
                          child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectMembers extends StatefulWidget {
  @override
  _SelectMembersState createState() => _SelectMembersState();
}

class _SelectMembersState extends State<SelectMembers> {
  Color c1 = Colors.white;
  Color c2 = Colors.white;
  Color c3 = Colors.white;
  Color c4 = Colors.white;
  Color c5 = Colors.white;
  Color sc1 = Color(0xFF00b09b);
  Color sc2 = Color(0xFF00b09b);
  Color sc3 = Color(0xFF00b09b);
  Color sc4 = Color(0xFF00b09b);
  Color sc5 = Color(0xFF00b09b);
  Color c6 = Colors.white;
  Color sc6 = Color(0xFF00b09b);
  Color c7 = Colors.white;
  Color sc7 = Color(0xFF00b09b);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Members",
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Center(
          child: Container(
              margin: EdgeInsets.all(16.0),
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                    colors: color1,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                      color: Colors.teal[700],
                      blurRadius: 20.0,
                      offset: Offset.fromDirection(4.5, -10.0))
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "How many family members?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white60, fontSize: 35.0),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            members = 1;
                            sc1 = Colors.black45;
                            sc3 = Color(0xFF00b09b);
                            sc4 = Color(0xFF00b09b);
                            sc5 = Color(0xFF00b09b);
                            sc2 = Color(0xFF00b09b);
                            sc6 = Color(0xFF00b09b);
                            sc7 = Color(0xFF00b09b);
                            c6 = Colors.white;
                            c7 = Colors.white;
                            c1 = Colors.black54;
                            c2 = Colors.white;

                            c3 = Colors.white;
                            c4 = Colors.white;
                            c5 = Colors.white;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeIn,
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color(0xFF00b09b),
                              boxShadow: [
                                BoxShadow(
                                    color: sc1,
                                    blurRadius: 20.0,
                                    offset: Offset.fromDirection(4.5, -10.0))
                              ]),
                          child: Center(
                            child: Text(
                              "1",
                              style: TextStyle(color: c1, fontSize: 35.0),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            members = 2;
                            sc2 = Colors.black45;
                            sc3 = Color(0xFF00b09b);
                            sc4 = Color(0xFF00b09b);
                            sc5 = Color(0xFF00b09b);
                            sc1 = Color(0xFF00b09b);
                            sc6 = Color(0xFF00b09b);
                            sc7 = Color(0xFF00b09b);
                            c6 = Colors.white;
                            c7 = Colors.white;
                            c1 = Colors.white;
                            c2 = Colors.black54;
                            c3 = Colors.white;
                            c4 = Colors.white;
                            c5 = Colors.white;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeIn,
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color(0xFF00b09b),
                              boxShadow: [
                                BoxShadow(
                                    color: sc2,
                                    blurRadius: 20.0,
                                    offset: Offset.fromDirection(4.5, -10.0))
                              ]),
                          child: Center(
                            child: Text(
                              "2",
                              style: TextStyle(color: c2, fontSize: 35.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            members = 5;
                            sc5 = Colors.black45;
                            sc3 = Color(0xFF00b09b);
                            sc4 = Color(0xFF00b09b);
                            sc1 = Color(0xFF00b09b);
                            sc2 = Color(0xFF00b09b);
                            sc6 = Color(0xFF00b09b);
                            sc7 = Color(0xFF00b09b);
                            c6 = Colors.white;
                            c7 = Colors.white;
                            c1 = Colors.white;
                            c2 = Colors.white;
                            c3 = Colors.white;
                            c4 = Colors.white;
                            c5 = Colors.black54;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeIn,
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color(0xFF00b09b),
                              boxShadow: [
                                BoxShadow(
                                    color: sc5,
                                    blurRadius: 20.0,
                                    offset: Offset.fromDirection(4.5, -10.0))
                              ]),
                          margin: EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              "5",
                              style: TextStyle(color: c5, fontSize: 35.0),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            members = 6;
                            sc6 = Colors.black45;
                            sc3 = Color(0xFF00b09b);
                            sc4 = Color(0xFF00b09b);
                            sc1 = Color(0xFF00b09b);
                            sc2 = Color(0xFF00b09b);
                            sc5 = Color(0xFF00b09b);
                            sc7 = Color(0xFF00b09b);
                            c5 = Colors.white;
                            c7 = Colors.white;
                            c1 = Colors.white;
                            c2 = Colors.white;
                            c3 = Colors.white;
                            c4 = Colors.white;
                            c6 = Colors.black54;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeIn,
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color(0xFF00b09b),
                              boxShadow: [
                                BoxShadow(
                                    color: sc6,
                                    blurRadius: 20.0,
                                    offset: Offset.fromDirection(4.5, -10.0))
                              ]),
                          margin: EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              "6",
                              style: TextStyle(color: c6, fontSize: 35.0),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            members = 7;
                            sc7 = Colors.black45;
                            sc3 = Color(0xFF00b09b);
                            sc4 = Color(0xFF00b09b);
                            sc1 = Color(0xFF00b09b);
                            sc2 = Color(0xFF00b09b);
                            sc6 = Color(0xFF00b09b);
                            sc5 = Color(0xFF00b09b);
                            c6 = Colors.white;
                            c5 = Colors.white;
                            c1 = Colors.white;
                            c2 = Colors.white;
                            c3 = Colors.white;
                            c4 = Colors.white;
                            c7 = Colors.black54;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeIn,
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color(0xFF00b09b),
                              boxShadow: [
                                BoxShadow(
                                    color: sc7,
                                    blurRadius: 20.0,
                                    offset: Offset.fromDirection(4.5, -10.0))
                              ]),
                          margin: EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              "7",
                              style: TextStyle(color: c7, fontSize: 35.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            members = 3;
                            sc3 = Colors.black45;
                            sc1 = Color(0xFF00b09b);
                            sc4 = Color(0xFF00b09b);
                            sc5 = Color(0xFF00b09b);
                            sc6 = Color(0xFF00b09b);
                            sc7 = Color(0xFF00b09b);
                            c6 = Colors.white;
                            c7 = Colors.white;
                            sc2 = Color(0xFF00b09b);
                            c1 = Colors.white;
                            c2 = Colors.white;
                            c3 = Colors.black54;
                            c4 = Colors.white;
                            c5 = Colors.white;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeIn,
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color(0xFF00b09b),
                              boxShadow: [
                                BoxShadow(
                                    color: sc3,
                                    blurRadius: 20.0,
                                    offset: Offset.fromDirection(4.5, -10.0))
                              ]),
                          child: Center(
                            child: Text(
                              "3",
                              style: TextStyle(color: c3, fontSize: 35.0),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            members = 4;
                            sc4 = Colors.black45;
                            sc3 = Color(0xFF00b09b);
                            sc1 = Color(0xFF00b09b);
                            sc5 = Color(0xFF00b09b);
                            sc2 = Color(0xFF00b09b);
                            sc6 = Color(0xFF00b09b);
                            sc7 = Color(0xFF00b09b);
                            c6 = Colors.white;
                            c7 = Colors.white;
                            c1 = Colors.white;

                            c2 = Colors.white;
                            c3 = Colors.white;
                            c4 = Colors.black54;
                            c5 = Colors.white;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeIn,
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color(0xFF00b09b),
                              boxShadow: [
                                BoxShadow(
                                    color: sc4,
                                    blurRadius: 20.0,
                                    offset: Offset.fromDirection(4.5, -10.0))
                              ]),
                          child: Center(
                            child: Text(
                              "4",
                              style: TextStyle(color: c4, fontSize: 35.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tempIndex = 0;
                      });
                      Navigator.push(
                          context,
                          SlideRightRoute(
                              page: Declaration(
                            memberIndex: tempIndex,
                          )));
                      print(tempIndex);
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      // decoration: BoxDecoration(
                      //   gradient: LinearGradient(
                      //       colors: [Color(0xFF1488CC), Color(0xFF2B32B2)],
                      //       begin: Alignment.topLeft,
                      //       end: Alignment.bottomRight),
                      //   borderRadius: BorderRadius.circular(15.0),
                      //   boxShadow: [
                      //     BoxShadow(
                      //         color: Colors.blue[900],
                      //         blurRadius: 10.0,
                      //         offset: Offset.fromDirection(1.0, 4.0))
                      //   ],
                      // ),
                      child: Center(
                          child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white70, fontSize: 30.0),
                      )),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
