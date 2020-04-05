import 'package:covid19/familyDeclaration.dart';
import 'package:covid19/familyRadio.dart';
import 'package:covid19/helpLine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'globalVar.dart' as global;
import 'package:location_permissions/location_permissions.dart';

class SelfDeclaration extends StatefulWidget {
  @override
  _SelfDeclarationState createState() => _SelfDeclarationState();
}

class _SelfDeclarationState extends State<SelfDeclaration> {
  List<String> eng = [
    "select travelled country",
    "from",
    "to",
    "Select your State",
    "Select your District",
    "Get Location",
    "Submit"
  ];
  List<String> hin = [
    "यात्रा देश का चयन करें",
    "से",
    "तक",
    "अपना राज्य चुनें",
    "अपने जिले का चयन करें",
    "स्थान प्राप्त करें",
    "प्रस्तुत"
  ];
  List<String> pun = [
    "ਯਾਤਰਾ ਦੇਸ਼ ਦੀ ਚੋਣ ਕਰੋ",
    "ਤੋਂ",
    "ਨੂੰ",
    "ਆਪਣੇ ਰਾਜ ਦੀ ਚੋਣ ਕਰੋ",
    "ਆਪਣੇ ਜ਼ਿਲ੍ਹੇ ਦੀ ਚੋਣ ਕਰੋ",
    "ਸਥਾਨ ਪ੍ਰਾਪਤ ਕਰੋ",
    "ਜਮ੍ਹਾਂ ਕਰੋ"
  ];
  List<String> kan = [
    "ಪ್ರಯಾಣ ದೇಶವನ್ನು ಆಯ್ಕೆಮಾಡಿ",
    "ಇಂದ",
    "ಗೆ",
    "ನಿಮ್ಮ ರಾಜ್ಯವನ್ನು ಆಯ್ಕೆಮಾಡಿ",
    "ನಿಮ್ಮ ಜಿಲ್ಲೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ",
    "ಸ್ಥಳ ಪಡೆಯಿರಿ",
    "ಸಲ್ಲಿಸು"
  ];
  List<String> mar = [
    "प्रवासी देश निवडा",
    "पासून",
    "ते",
    "आपले राज्य निवडा",
    "आपला जिल्हा निवडा",
    "स्थान मिळवा",
    "प्रस्तुत करणे"
  ];
  List<String> odi = [
    "ଭ୍ରମଣକାରୀ ଦେଶ ଚୟନ କରନ୍ତୁ",
    "ରୁ",
    "to",
    "ଆପଣଙ୍କର ରାଜ୍ୟ ଚୟନ କରନ୍ତୁ",
    "ଆପଣଙ୍କର ଜିଲ୍ଲା ଚୟନ କରନ୍ତୁ",
    "ସ୍ଥାନ ପାଆନ୍ତୁ",
    "ଦାଖଲ"
  ];
  List<String> tel = [
    "ప్రయాణించిన దేశాన్ని ఎంచుకోండి",
    "నుండి",
    "టు",
    "మీ రాష్ట్రాన్ని ఎంచుకోండి",
    "మీ జిల్లాను ఎంచుకోండి",
    "స్థానం పొందండి",
    "సమర్పించు"
  ];
  List<String> tam = [
    "பயண நாட்டைத் தேர்ந்தெடுக்கவும்",
    "from",
    "to",
    "உங்கள் மாநிலத்தைத் தேர்ந்தெடுக்கவும்",
    "உங்கள் மாவட்டத்தைத் தேர்ந்தெடுக்கவும்",
    "இருப்பிடத்தைப் பெறு",
    "சமர்ப்பி"
  ];
  List<String> uiVar = [];
  void uiLang() {
    switch (global.lang) {
      case "hindi":
        {
          uiVar = hin;
          break;
        }
      case "english":
        {
          uiVar = eng;
          break;
        }
      case "odiya":
        {
          uiVar = odi;
          break;
        }
      case "marathi":
        {
          uiVar = mar;
          break;
        }
      case "tamil":
        {
          uiVar = tam;
          break;
        }
      case "telegu":
        {
          uiVar = tel;
          break;
        }
      case "kannada":
        {
          uiVar = kan;
          break;
        }
    }
  }

  int isInfected;
  int gender;
  int travelled = 0;
  TextEditingController nameEditor = new TextEditingController();
  TextEditingController fnameEditor = new TextEditingController();

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
          lat = 'Latitude';
          long = 'Longitude';
        });
      }
    });
  }

  Widget travel(List<int> travelled, int i) {
    if (travelled[i] == 1) {
      return Text("");
    } else if (travelled[i] == 0) {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: DropdownButton(
              hint: Text(uiVar[0],
                  style: TextStyle(color: Colors.black, fontSize: 15.0)),
              value: selectedDistrict,
              onChanged: (newValue) {
                setState(() {
                  selectedDistrict = newValue;
                });
              },
              items: dRajasthan.map((location) {
                return DropdownMenuItem(
                  child:
                      new Text(location, style: TextStyle(color: Colors.black)),
                  value: location,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20.0),
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
                    }
                  },
                  child: Text(uiVar[1]),
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
                    }
                  },
                  child: Text(uiVar[2]),
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

  String selectedState;
  List<String> states = ["Rajasthan", "up", "Gujrat"];
  List<String> country = ["India", "China", "Italy"];
  String selectedDistrict;
  List<String> dRajasthan = [
    "alwar",
    "jaipur",
    "bikaner",
    "jaisalmer",
    "bhilwara",
    "kota"
  ];
  List<String> dUP = ["kanpur", "lucknow"];
  List<String> def = ["Select your district"];
  DateTime dateTime;
  Duration duration;
  @override
  void initState() {
    uiLang();
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
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFF3180e4),
          Color(0xFF564dc2),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Image(
                    width: 300, image: AssetImage("assets/images/covid19.png")),
                //FamilyDeclaration(),
                //travel(),
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
                          uiVar[3],
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
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
                    SizedBox(width: 20.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: DropdownButton(
                        hint: Text(uiVar[4],
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0)),
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
                ),
                SizedBox(height: 15.0),
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
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 150.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFF3180e4),
                            Color(0xFF564dc2),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10.0),
                      ]),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HelpLine()));
                    },
                    child: Text(
                      uiVar[6],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
