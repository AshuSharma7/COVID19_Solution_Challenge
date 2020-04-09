import 'dart:async';
import 'dart:convert';
import 'package:covid19/grid.dart';
import 'package:covid19/slefDeclaration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globalVar.dart' as global;
import 'registerVariables.dart' as declaration;
import 'slefDeclaration.dart' as self;

class FamilyDeclaration extends StatefulWidget {
  @override
  _FamilyDeclarationState createState() => _FamilyDeclarationState();
}
ScrollController scroll = new ScrollController();
AsyncSnapshot<Map<String, dynamic>> snapshot;
String data;
Map content;
int id = 0;
TextEditingController nameEditor = new TextEditingController();
TextEditingController fnameEditor = new TextEditingController();
int members = 1;
int tempMembers = 0;
double height = 20;
String submitText = "next";
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
String selectedAge;
class _FamilyDeclarationState extends State<FamilyDeclaration> {
  double lat, long;
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

  Widget submit(int index) {
    if(index == members-1) {
      return Container(
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
                 bool error=false;
                   for(int i = 0; i < members; i++) {
                     if(declaration.editor[i].text == "" || declaration.editor[i].text == null || declaration.adhharEditor[i].text == "" || declaration.adhharEditor[i].text == null) {
                       error = true;
                     }
                   }
                   SharedPreferences prefs =
                       await SharedPreferences.getInstance();
                       if(error == false) {
                         for (int i = 0; i < members; i++) {
                      if(declaration.symptoms[i]["attendJamat"] == true || declaration.symptoms[i]["metJamatis"] == true || declaration.symptoms[i]["metSomeoneAbroad"] || declaration.symptoms[i]["outbreakPlaceVisit"]) {
                        declaration.haveSymptoms[i] = true;
                      } else if(declaration.symptoms[i]["dizziness"]==true || declaration.symptoms[i]["cough"] == true && declaration.symptoms[i]["nose"]== true && declaration.symptoms[i]["fever"] == true) {
                        declaration.haveSymptoms[i] = true;
                      } else if(declaration.symptoms[i]["cough"] == true && declaration.symptoms[i]["nose"] == true && declaration.symptoms[i]["fever"] == true && declaration.symptoms[i]["throatchest"] == true) {
                        declaration.haveSymptoms[i] = true;
                      } else if(declaration.symptoms[i]["cough"] == true && declaration.symptoms[i]["nose"] == true && (declaration.symptoms[i]["pronounciation"] == true || declaration.symptoms[i]["breathing"] == true || declaration.symptoms[i]["diarrhea"] == true)) {
                        declaration.haveSymptoms[i] = true;
                      } else {
                        declaration.haveSymptoms[i] = false;
                      }
                      if(members != 1) {
                        Map content = await declaration.geoCoding(declaration.addressEditor[i].text);
                        lat = content["results"][0]["geometry"]["location"]["lat"];
                        long = content["results"][0]["geometry"]["location"]["lng"];

                      }
                      print(prefs.getString('aadhar'));
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
                          long
                          );
                    }
                       }  else {
                         return showDialog(context: (context),
                         builder: (context) {
                           return AlertDialog(
                             title: Text("Error"),
                             content: Text("Any Field is missing"),
                             actions: <Widget>[
                               IconButton(icon: Icon(Icons.done), onPressed: () {
                                 Navigator.pop(context);
                               })
                             ],
                           );
                         }
                         );
                       }
                    
                  if (declaration.error == false) {
                    prefs.setBool('declared', true);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => DashBoard()),
                        (_) => false);
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
    } else {
      return SizedBox(
        height: 0.0,
      );
    }
  
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
              long.toString(),
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
              lat.toString(),
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
              controller: declaration.addressEditor[i],
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
    if (true) {
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
                        groupValue: declaration.symptoms[i]["fever"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["fever"] = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: declaration.symptoms[i]["fever"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["fever"] = value;
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
                "Cough?",
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
                        groupValue: declaration.symptoms[i]["cough"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["cough"] = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: declaration.symptoms[i]["cough"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["cough"] = value;
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
                "Short Breathing?",
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
                        groupValue: declaration.symptoms[i]["breathing"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["breathing"] = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: declaration.symptoms[i]["breathing"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["breathing"] = value;
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
                "Running Nose?",
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
                        groupValue: declaration.symptoms[i]["nose"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["nose"] = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: declaration.symptoms[i]["nose"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["nose"] = value;
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
                "Have Dizziness?",
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
                        groupValue: declaration.symptoms[i]["dizziness"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["dizziness"] = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: declaration.symptoms[i]["dizziness"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["dizziness"] = value;
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
                "Difficulty in Pronounciation?",
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
                        groupValue: declaration.symptoms[i]["pronounciation"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["pronounciation"] = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: declaration.symptoms[i]["pronounciation"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["pronounciation"] = value;
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
                "Chest/Throat Pain?",
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
                        groupValue: declaration.symptoms[i]["throatchest"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["throatchest"] = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: declaration.symptoms[i]["throatchest"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["throatchest"] = value;
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
                "Have Diarrhea?",
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
                        groupValue: declaration.symptoms[i]["diarrhea"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["diarrhea"] = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: declaration.symptoms[i]["diarrhea"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["diarrhea"] = value;
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
                "Attended Jamat?",
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
                        groupValue: declaration.symptoms[i]["attendJamat"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["attendJamat"] = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: declaration.symptoms[i]["attendJamat"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["attendJamat"] = value;
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
                "Met any Jamati?",
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
                        groupValue: declaration.symptoms[i]["metJamatis"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["metJamatis"] = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: declaration.symptoms[i]["metJamatis"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["metJamatis"] = value;
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
                "Met someone \nwho visited abroad?",
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
                        groupValue: declaration.symptoms[i]["metSomeoneAbroad"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["metSomeoneAbroad"] = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: declaration.symptoms[i]["metSomeoneAbroad"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["metSomeoneAbroad"] = value;
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
                "Visited Corona Outbreak Place?",
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
                        groupValue: declaration.symptoms[i]["outbreakPlaceVisit"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["outbreakPlaceVisit"] = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: declaration.symptoms[i]["outbreakPlaceVisit"],
                        onChanged: (value) {
                          setState(() {
                            declaration.symptoms[i]["outbreakPlaceVisit"] = value;
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

  Widget form(int index) {
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
                          maxLength: 12,
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
                                  declaration.district[index] = "";
                                  id = declaration.statesID[newValue];
                                  selectedState = newValue;
                                  declaration.state[index] = newValue;
                                });
                              },
                              items: declaration.stateList.map((location) {
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
                              items:
                                  declaration.districtList[id].map((location) {
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
                      SizedBox(height: 15.0,),
                      Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: DropdownButton(
                              iconDisabledColor: Colors.black,
                              hint: Text(
                                "Select Age group",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              ),
                              value: selectedAge,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedAge = newValue;
                                  declaration.ageGroup[index] = newValue;
                                });
                              },
                              items:
                                  declaration.ageGroupList.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location,
                                      style: TextStyle(color: Colors.black)),
                                  value: location,
                                );
                              }).toList(),
                            ),
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
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Is Cured?",
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
                                    groupValue: declaration.isCured[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.isCured[index] = value;
                                      });
                                    }),
                                Text("No"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: false,
                                    groupValue: declaration.isCured[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.isCured[index] = value;
                                      });
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Is Hospitalised?",
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
                                    groupValue: declaration.hospitalised[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.hospitalised[index] = value;
                                      });
                                    }),
                                Text("No"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: false,
                                    groupValue: declaration.hospitalised[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.hospitalised[index] = value;
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
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Is Alive?",
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
                                    value: false,
                                    groupValue: declaration.isInfected[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.isDead[index] = value;
                                      });
                                    }),
                                Text("No"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: true,
                                    groupValue: declaration.isInfected[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.isDead[index] = value;
                                      });
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15.0),
                      symptoms(index),
                      
                      SizedBox(height: 15.0),
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
                      SizedBox(height: 20.0),
                      submit(index),
                      SizedBox(height: 20.0),
                    ],
                  );
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
    lat = 0.0;
    long = 0.0;
    dateTime = DateTime.now();
    duration = Duration(minutes: 10);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(color: Colors.black45, blurRadius: 15.0),
                      ]
        ),
        
        child: IconButton(icon: Icon(Icons.skip_next), onPressed: () {
          tempMembers++;
          scroll.animateTo(MediaQuery.of(context).size.width*tempMembers, duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);
         
          
        }),
      ),
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
                              tempMembers=0;
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
                              tempMembers=0;
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
                              tempMembers=0;
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
                              tempMembers=0;
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
                              tempMembers=0;
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
                  scrollDirection: Axis.horizontal,
                  itemCount: members,
                  controller: scroll,
                  itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(child: form(index));
                })
                                  ),
            
            
          ],
        ),
      ),
    );
  }
}
