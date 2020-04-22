import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tracker extends StatefulWidget {
  @override
  _TrackerState createState() => _TrackerState();
}

final databaseReference = FirebaseDatabase.instance.reference();
final auth = FirebaseAuth.instance;
Future<SharedPreferences> getPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

double dist(double userLat, double userLong, double lat1, double long1) {
  double dlat1 = userLat / 57.29577951;
  double dlong1 = userLong / 57.29577951;
  double dlat2 = lat1 / 57.29577951;
  double dlong2 = long1 / 57.29577951;
  double d = 6378.8 *
      math.acos((math.sin(dlat1) * math.sin(dlat2)) +
          math.cos(dlat1) * math.cos(dlat2) * math.cos(dlong1 - dlong2));
  return d;
}

class _TrackerState extends State<Tracker> {
  List content = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.currentUser().then((value) {
      firebaseDatabase.child(value.uid).once().then((value) {
        Map data = value.value;
        print(data);
        lat = data["latitude"];
        long = data["longitude"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Tracker",
            style: TextStyle(fontSize: 30.0, color: Colors.black),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: StreamBuilder(
              stream: databaseReference.onValue,
              builder: (context, snap) {
                if (snap.hasData) {
                  Map data = snap.data.snapshot.value;
                  List item = [];
                  data.forEach(
                      (key, value) => item.add({"index": key, "value": value}));
                  return MapPage(
                    content: item,
                  );
                } else {
                  return SpinKitChasingDots(color: Colors.black);
                }
              })),
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  List content;
  MapPage({Key key, @required this.content}) : super(key: key);
  _MapPageState createState() => _MapPageState();
}

GoogleMapController mapController;
double lat;
double long;
final firebaseDatabase = FirebaseDatabase.instance.reference();

class _MapPageState extends State<MapPage> {
  final Map<String, Marker> markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      for (int i = 0; i < widget.content.length; i++) {
        if (widget.content[i]["value"]["latitude"] != null &&
            widget.content[i]["value"]["latitude"] != 0) {
          if (dist(lat, long, widget.content[i]["value"]["latitude"],
                  widget.content[i]["value"]["longitude"]) <
              1.0) {
            final marker = Marker(
              markerId:
                  MarkerId(widget.content[i]["value"]["username"].toString()),
              position: LatLng(widget.content[i]["value"]["latitude"],
                  widget.content[i]["value"]["longitude"]),
              infoWindow: InfoWindow(),
            );
            markers[widget.content[i]["value"]["username"].toString()] = marker;
          }
        }
      }
      final marker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        markerId: MarkerId("Current User"),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(),
      );
      markers["user"] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(lat, long), zoom: 16.0),
        onMapCreated: _onMapCreated,
        markers: markers.values.toSet(),
        // markers: ,
      ),
    );
  }
}
