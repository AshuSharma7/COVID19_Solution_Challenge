import 'dart:io';

import 'package:flutter/material.dart';
import 'registerVariables.dart' as declaration;

class Declaration extends StatefulWidget {
  @override
  _DeclarationState createState() => _DeclarationState();
}

int members;
List<Color> color3 = [
  Color(0xFF8E2DE2),
  Color(0xFF4A00E0),
];
List<Color> color1 = [
  Color(0xFF00b09b),
  Color(0xFF00b09b),
];
List<Color> color2 = [
  Color(0xFFff9966),
  Color(0xFFff5e62),
];
List<Color> color4 = [Color(0xFF36D1DC), Color(0xFF5B86E5)];
TextEditingController temp = new TextEditingController();

class _DeclarationState extends State<Declaration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Declaration Form",
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.black87,
            )),
        backgroundColor: Colors.white,
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
                      child: Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          cursorColor: Colors.white,
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
                      child: Expanded(
                        child: TextField(
                          cursorColor: Colors.white,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          controller: temp,
                          style: TextStyle(color: Colors.white, fontSize: 28.0),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              hintText: "Enter Aadhar No.",
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
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      gradient: LinearGradient(colors: [
                        Color(0xFF0F2027),
                        Color(0xFF203A43),
                        Color(0xFF2C5364)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey[600],
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
                            "Gender",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.white54),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Male",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.white),
                              ),
                              Text(
                                "Female",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.white54),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      gradient: LinearGradient(colors: [
                        Color(0xFF0F2027),
                        Color(0xFF203A43),
                        Color(0xFF2C5364)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey[600],
                            blurRadius: 20.0,
                            offset: Offset.fromDirection(4.0, -10.0))
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Get location",
                        style: TextStyle(fontSize: 14.0, color: Colors.white54),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      gradient: LinearGradient(colors: [
                        Color(0xFF0F2027),
                        Color(0xFF203A43),
                        Color(0xFF2C5364)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey[600],
                            blurRadius: 20.0,
                            offset: Offset.fromDirection(4.0, -10.0))
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Select State & District",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14.0, color: Colors.white54),
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
                  Container(
                    width: 100,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      gradient: LinearGradient(colors: [
                        Color(0xFF0F2027),
                        Color(0xFF203A43),
                        Color(0xFF2C5364)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey[600],
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
                                fontSize: 18.0, color: Colors.white54),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Yes",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                              Text(
                                "No",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white54),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      gradient: LinearGradient(colors: [
                        Color(0xFF0F2027),
                        Color(0xFF203A43),
                        Color(0xFF2C5364)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey[600],
                            blurRadius: 20.0,
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
                                fontSize: 18.0, color: Colors.white54),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Yes",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                              Text(
                                "No",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white54),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      gradient: LinearGradient(colors: [
                        Color(0xFF0F2027),
                        Color(0xFF203A43),
                        Color(0xFF2C5364)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey[600],
                            blurRadius: 20.0,
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
                                fontSize: 15.0, color: Colors.white54),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Yes",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                              Text(
                                "No",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white54),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
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
                        sleep(Duration(milliseconds: 500));
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                child: Expanded(
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
                                      width: MediaQuery.of(context).size.width -
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
                                                      color: Colors.white70),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: true,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: false,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  "Cough?",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: true,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: false,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  "Short Breath?",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: true,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: false,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  "Running \nNose?",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: true,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: false,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  "Dizziness?",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: true,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: false,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  "Difficulty\nin\npronounciation?",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: true,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: false,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  "Chest/Throat\nPain?",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: true,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: false,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  "Diarrhea?",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: true,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: false,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  "Attended \njamat?",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: true,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: false,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  "Met\nany\njamati?",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: true,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: false,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  "Met someone\nwho\nvisited\nabroad?",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: true,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: false,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  "Visited any\ncorona\noutbreak\nplace?",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: true,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                ),
                                                Radio(
                                                    value: false,
                                                    groupValue: null,
                                                    onChanged: (value) {}),
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
                                              color: const Color(0xFF1BC0C5),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              );
                            });
                      },
                      child: Center(
                        child: Text(
                          "Select Options which Satisfies You",
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white70),
                        ),
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
                    onTap: () {},
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
                            c1 = Colors.black87;
                            c2 = Colors.white;
                            c3 = Colors.white;
                            c4 = Colors.white;
                            c5 = Colors.white;
                          });
                        },
                        child: Text(
                          "1",
                          style: TextStyle(color: c1, fontSize: 35.0),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            c1 = Colors.white;
                            c2 = Colors.black87;
                            c3 = Colors.white;
                            c4 = Colors.white;
                            c5 = Colors.white;
                          });
                        },
                        child: Text(
                          "2",
                          style: TextStyle(color: c2, fontSize: 35.0),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        c1 = Colors.white;
                        c2 = Colors.white;
                        c3 = Colors.white;
                        c4 = Colors.white;
                        c5 = Colors.black87;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          "5",
                          style: TextStyle(color: c5, fontSize: 35.0),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            c1 = Colors.white;
                            ;
                            c2 = Colors.white;
                            c3 = Colors.black87;
                            c4 = Colors.white;
                            c5 = Colors.white;
                          });
                        },
                        child: Text(
                          "3",
                          style: TextStyle(color: c3, fontSize: 35.0),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            c1 = Colors.white;

                            c2 = Colors.white;
                            c3 = Colors.white;
                            c4 = Colors.black87;
                            c5 = Colors.white;
                          });
                        },
                        child: Text(
                          "4",
                          style: TextStyle(color: c4, fontSize: 35.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Declaration()));
                    },
                    child: Container(
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
                              color: Colors.blue[900],
                              blurRadius: 10.0,
                              offset: Offset.fromDirection(1.0, 4.0))
                        ],
                      ),
                      child: Center(
                          child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
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
