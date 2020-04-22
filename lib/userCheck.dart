import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_localization_master/pages/LanguagePage.dart';
import 'package:flutter_localization_master/pages/bottomNavBar.dart';
import 'package:flutter_localization_master/pages/coronaMonitor.dart';
import 'package:flutter_localization_master/pages/homePage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'newDeclaration.dart';

class CheckUser extends StatefulWidget {
  @override
  _CheckUserState createState() => _CheckUserState();
}

Future<SharedPreferences> getPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

final auth = FirebaseAuth.instance;
final reference = FirebaseDatabase.instance.reference();

class _CheckUserState extends State<CheckUser> {
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
    if (lat != 0.0 || lat != null) {
      auth.currentUser().then((value) {
        reference.child(value.uid).update({
          'latitude': lat,
          'longitude': long,
        });
      });
    }
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, check);
  }

  void check() {
    auth.currentUser().then((value) {
      if (value != null) {
        reference.child(value.uid).once().then((value) {
          if (value.value["declaration"] == true) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomnavBar()),
                (_) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CoronaMonitor()),
                (_) => false);
          }
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LanguagePage()),
            (_) => false);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("assets/images/splash.jpg"))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: SpinKitFadingCube(
                  color: Colors.black,
                  size: 30.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage(
                      "assets/images/indcovid.jpg",
                    ),
                    width: 55,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "ANGEL\nGUDIA'S\nCOVID19\nWARRIOR",
                    style: TextStyle(fontSize: 10.0),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          )),
    );
  }
}
