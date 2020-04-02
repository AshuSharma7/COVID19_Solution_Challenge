import 'dart:async';
import 'dart:convert';
import 'package:covid19/slefDeclaration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globalVar.dart' as global;
import 'registerVariables.dart' as declaration;
import 'slefDeclaration.dart' as self;

class FamilyDeclaration extends StatefulWidget {
  @override
  _FamilyDeclarationState createState() => _FamilyDeclarationState();
}

AsyncSnapshot<Map<String, dynamic>> snapshot;
String data;
Map content;

TextEditingController nameEditor = new TextEditingController();
TextEditingController fnameEditor = new TextEditingController();
int members = 1;
double height = 20;

List<String> country = ["india", "china", "usa", "russia", "japan", "italy"];
List<String> district = ["Alwar"];
String selectedCountry;
String selectedDistrict;
String selectedState;
List<String> states = [
  "Rajasthan",
  "Uttar Pradesh",
  "Gujrat",
  "Haryana",
  "Delhi",
  "Punjab",
  "Bihar",
  "TamilNadu"
];

class _FamilyDeclarationState extends State<FamilyDeclaration> {
  String lat, long = '';
  Position position;
  StreamSubscription<Position> positionStream;
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
          lat = 'Latitude';
          long = 'Longitude';
        });
      }
    });
  }

  Widget GetLocation(int i) {
    if (members == 1) {
      return Row(
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
                  BoxShadow(color: Colors.black26, blurRadius: 10.0),
                ]),
            child: Text(
              long,
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Container(
            width: 100,
            height: 30.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10.0),
                ]),
            child: Text(
              lat,
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10.0),
                ]),
            child: MaterialButton(
              onPressed: () {
                getLocation();
                setState(() {});
              },
              child: Text("Get Location"),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Address",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10.0),
                ]),
            child: TextField(
              controller: declaration.editor[i],
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      );
    }
  }

  void getJson() async {
    data = await DefaultAssetBundle.of(context)
        .loadString("assets/files/language.json");
    snapshot = await json.decode(data);
    print(snapshot.data);
    content = snapshot.data;
  }

  Widget symptoms(int i) {
    if (declaration.haveSymptoms[i] == true) {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Fever?",
                style: TextStyle(color: Colors.white),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10.0),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Yes"),
                    new Radio(
                        activeColor: Colors.black,
                        value: true,
                        groupValue: declaration.symptoms["fever"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms["fever"] = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: declaration.symptoms["fever"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms["fever"] = value;
                          });
                        }),
                  ],
                ),
              )
            ],
          ),
        ],
      );
    } else {
      return SizedBox(height: 0.0);
    }
  }

  Widget travel(List<bool> travelled, int i) {
    if (travelled[i] == false) {
      return SizedBox(height: 0.0);
    } else if (travelled[i] == true) {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: DropdownButton(
              hint: Text("Select Travelled country",
                  style: TextStyle(color: Colors.black, fontSize: 15.0)),
              value: selectedCountry,
              onChanged: (newValue) {
                setState(() {
                  selectedCountry = newValue;
                });
              },
              items: country.map((location) {
                return DropdownMenuItem(
                  child:
                      new Text(location, style: TextStyle(color: Colors.black)),
                  value: location,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10.0),
                    ]),
                child: MaterialButton(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      borderRadius: 2,
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                      declaration.from[i] = dateTime.toString();
                    }
                  },
                  child: Text("from"),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10.0),
                    ]),
                child: MaterialButton(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      borderRadius: 2,
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                      declaration.to[i] = dateTime.toString();
                    }
                  },
                  child: Text("to"),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      );
    }
  }

  DateTime dateTime;
  Duration duration;
  @override
  void initState() {
    getJson();
    lat = 'Latitude';
    long = 'Longitude';
    dateTime = DateTime.now();
    duration = Duration(minutes: 10);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Family Declaration",
          style: TextStyle(fontSize: 30.0),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xFF3180e4),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFF3180e4),
          Color(0xFF564dc2),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          children: <Widget>[
            Text(
              "Family Members",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50.0,
                  //padding: EdgeInsets.only(left: 10.0, right: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10.0),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Self"),
                      new Radio(
                          activeColor: Colors.black,
                          value: 1,
                          groupValue: members,
                          onChanged: (value) {
                            setState(() {
                              members = value;
                            });
                          }),
                      Text("2"),
                      new Radio(
                          activeColor: Colors.black,
                          value: 2,
                          groupValue: members,
                          onChanged: (value) {
                            setState(() {
                              members = value;
                            });
                          }),
                      Text("3"),
                      new Radio(
                          activeColor: Colors.black,
                          value: 3,
                          groupValue: members,
                          onChanged: (value) {
                            setState(() {
                              members = value;
                            });
                          }),
                      Text("4"),
                      new Radio(
                          activeColor: Colors.black,
                          value: 4,
                          groupValue: members,
                          onChanged: (value) {
                            setState(() {
                              members = value;
                            });
                          }),
                      Text("5"),
                      new Radio(
                          activeColor: Colors.black,
                          value: 5,
                          groupValue: members,
                          onChanged: (value) {
                            setState(() {
                              members = value;
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: members,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Member " + (index + 1).toString() + " name",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26, blurRadius: 10.0),
                            ]),
                        child: TextField(
                          controller: declaration.editor[index],
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Adhhar No.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26, blurRadius: 10.0),
                            ]),
                        child: TextField(
                          controller: declaration.adhharEditor[index],
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      GetLocation(index),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
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
                                "Select State",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              ),
                              value: selectedState,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedState = newValue;
                                  declaration.state[index] = newValue;
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
                          SizedBox(
                            width: 15.0,
                          ),
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
                                "Select District",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              ),
                              value: selectedDistrict,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedDistrict = newValue;
                                  declaration.district[index] = newValue;
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
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Gender",
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 10.0),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Male"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: "Male",
                                    groupValue: declaration.gender[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.gender[index] = value;
                                      });
                                    }),
                                Text("Female"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: "Female",
                                    groupValue: declaration.gender[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.gender[index] = value;
                                      });
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Are you infected?",
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 10.0),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Yes"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: true,
                                    groupValue: declaration.isInfected[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.isInfected[index] = value;
                                      });
                                    }),
                                Text("No"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: false,
                                    groupValue: declaration.isInfected[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.isInfected[index] = value;
                                      });
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Have Symptoms?",
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 10.0),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Yes"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: true,
                                    groupValue: declaration.haveSymptoms[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.haveSymptoms[index] = value;
                                      });
                                    }),
                                Text("No"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: false,
                                    groupValue: declaration.haveSymptoms[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.haveSymptoms[index] = value;
                                      });
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15.0),
                      symptoms(index),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Have Travelled?",
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 10.0),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Yes"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: true,
                                    groupValue:
                                        declaration.haveTravelled[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.haveTravelled[index] =
                                            value;
                                      });
                                    }),
                                Text("No"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: false,
                                    groupValue:
                                        declaration.haveTravelled[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.haveTravelled[index] =
                                            value;
                                      });
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5.0),
                      travel(declaration.haveTravelled, index),
                      SizedBox(height: 20.0)
                    ],
                  );
                },
              ),
            ),
            Container(
              width: 150.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFF3180e4),
                    Color(0xFF564dc2),
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10.0),
                  ]),
              child: MaterialButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  for (int i = 0; i < members; i++) {
                    declaration.makePost(
                        prefs.getString('username'),
                        declaration.editor[i].text,
                        declaration.gender[i],
                        declaration.adhharEditor[i].text,
                        declaration.isInfected[i],
                        declaration.haveSymptoms[i],
                        declaration.haveTravelled[i],
                        declaration.from[i],
                        declaration.to[i]);
                  }
                  if (declaration.error != true) {
                    prefs.setBool('declaration', true);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelfDeclaration()));
                  }
                },
                child: Text(
                  "submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
