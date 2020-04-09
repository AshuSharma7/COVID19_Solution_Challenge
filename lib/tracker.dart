import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Tracker extends StatefulWidget {
  Tracker({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Tracker createState() => _Tracker();
}

class _Tracker extends State<Tracker> {
  var name = "", bug = "";
  SharedPreferences prefs;
  Geolocator geolocator = Geolocator();
  static var data;
  bool val = false, val2 = false;
  var result;
  var databaseReference;
  static var selected;
  Completer<GoogleMapController> _controller = Completer();

//  static final CameraPosition _myLocation = CameraPosition(
//    target: LatLng(0, 0),
//    bearing: 15.0,
//    tilt: 75.0,
//    zoom: 12,
//  );
  static LatLng _center = LatLng(0, 0);
  var _markers = {
    Marker(
      markerId: MarkerId("1"),
      position: _center,
      icon: BitmapDescriptor.defaultMarker,
    ),
  };
  SharedPreferences preferences;
  void _handleChange(namee) {
    setState(() {
      bug = namee;
    });
  }

  // void _handleSubmit() {
  //   prefs.setString('name', bug);
  //   name = bug;
  //   myInit();
  // }
  String userName;
  @override
  void initState() {
    super.initState();
    _sPref().then((val) {
      setState(() {
        prefs = val;
        name = val.getString('aadhar');
        userName = val.get('name');
      });
      if (userName != null) {
        myInit();
      }
    });
  }

  TextEditingController editor = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: getView(),
    );
  }

  Widget getView() {
    if (userName == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                obscureText: false,
                controller: editor,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Enter Infected Person Name:",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),
            ),
            // TextField(
            //   onChanged: _handleChange,
            //   decoration: InputDecoration(
            //     labelText:  '',
            //     contentPadding: EdgeInsets.all(20.0)),
            // ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: <Widget>[
                Text("Are you infected"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Yes"),
                    new Radio(
                        activeColor: Colors.black,
                        value: true,
                        groupValue: result,
                        onChanged: (value) {
                          setState(() {
                            result = value;
                          });
                        }),
                    Text("No"),
                    new Radio(
                        activeColor: Colors.black,
                        value: false,
                        groupValue: result,
                        onChanged: (value) {
                          setState(() {
                            result = value;
                          });
                        }),
                  ],
                ),
              ],
            ),
            RaisedButton(
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString('name', editor.text);
                setState(() {
                  userName = editor.text;
                });
                editor.clear();
                if (result == true) {
                  Fluttertoast.showToast(
                      msg: "Done", toastLength: Toast.LENGTH_SHORT);
                  myInit();
                } else {
                  Fluttertoast.showToast(
                      msg: "Unavle", toastLength: Toast.LENGTH_SHORT);
                }
              },
              child: Text("Submit"),
            ),
          ],
        ),
      );
    } else {
      if (data != null) {
        var keys = data.keys.toList();
        var vals = data.values.toList();
        return Column(
          children: <Widget>[
            Container(
              height: 250.0,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, position) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = keys[position];
                        _center = LatLng(data[selected]['latitude'],
                            data[selected]['longitude']);
                      });
                      _markers.removeWhere((m) => m.markerId.value == '1');
                      _markers.add(
                        Marker(
                          markerId: MarkerId("1"),
                          position: _center,
                          icon: BitmapDescriptor.defaultMarker,
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              vals[position]['name'],
                              style: TextStyle(fontSize: 22.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Latitude : ${vals[position]['latitude']}, Longitude : ${vals[position]['longitude']}',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: GoogleMap(
                key: Key("${Random().nextInt(100)}"),
                padding: EdgeInsets.all(20.0),
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 15.0,
                ),
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _markers,
              ),
            ),
          ],
        );
      }
      return Center(
          child: CircularProgressIndicator(
        strokeWidth: 3,
      ));
    }
  }

  Future<LocationOptions> _locationOptions() async {
    return LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 10);
  }

  Future<SharedPreferences> _sPref() async {
    return SharedPreferences.getInstance();
  }

  Future<DatabaseReference> _dataRef() async {
    return FirebaseDatabase.instance.reference();
  }

  void write(lat, lon, name, userName) {
    databaseReference
        .child(name)
        .set({'name': userName, 'latitude': lat, 'longitude': lon});
  }

  Future<dynamic> read() {
    var data = databaseReference.once().then((DataSnapshot snapshot) {
      return snapshot.value;
    });
    return data;
  }

  void myInit() {
    _dataRef().then((val) {
      setState(() {
        databaseReference = val;
        selected = name;
      });
      read().then((snap) {
        setState(() {
          data = snap;
          _center =
              LatLng(snap[selected]['latitude'], snap[selected]['longitude']);
        });
        _markers.removeWhere((m) => m.markerId.value == '1');
        _markers.add(
          Marker(
            markerId: MarkerId("1"),
            position: _center,
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      });
      databaseReference.onChildChanged.listen((event) {
        setState(() {
          data[event.snapshot.key] = event.snapshot.value;
          if (event.snapshot.key == selected) {
            _center = LatLng(event.snapshot.value['latitude'],
                event.snapshot.value['longitude']);
          }
        });
        if (event.snapshot.key == selected) {
          _markers.removeWhere((m) => m.markerId.value == '1');
          _markers.add(
            Marker(
              markerId: MarkerId("1"),
              position: _center,
              icon: BitmapDescriptor.defaultMarker,
            ),
          );
        }
      });
      databaseReference.onChildAdded.listen((event) {
        if (data[event.snapshot.key] == null) {
          setState(() {
            data[event.snapshot.key] = event.snapshot.value;
          });
        }
      });
    });
    _locationOptions().then((locOpt) {
      geolocator.getPositionStream(locOpt).listen((Position position) {
        if (position != null) {
          write(position.latitude, position.longitude, name, userName);
        }
      });
    });
  }
}
