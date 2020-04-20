import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tracker extends StatefulWidget {
  @override
  _TrackerState createState() => _TrackerState();
}

final databaseReference = FirebaseDatabase.instance.reference();

Future<SharedPreferences> getPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

class _TrackerState extends State<Tracker> {
  List content = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs().then((value) {
      String user = value.getString('aadhar');
      print(user);
      firebaseDatabase.child(user).once().then((value) {
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
        if ((widget.content[i]["value"]["latitude"] - lat) <= 4.0) {
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
            CameraPosition(target: LatLng(lat, long), zoom: 15.0),
        onMapCreated: _onMapCreated,
        markers: markers.values.toSet(),
        // markers: ,
      ),
    );
  }
}
