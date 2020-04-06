import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapPage extends StatefulWidget {
  @override
  bool boo;
  MapPage({Key key, @required this.boo}) : super(key: key);
  _MapPageState createState() => _MapPageState();
}

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/apis/govt";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

GoogleMapController mapController;
List content;
int length = 1;

class _MapPageState extends State<MapPage> {
  final Map<String, Marker> markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      markers.clear();
      print(content.length);
      for (int i = 0; i < content.length; i++) {
        if (content[i]["is_state"] == widget.boo) {
          final marker = Marker(
            onTap: () {
              return showDialog(
                  context: (context),
                  builder: (context) {
                    return AlertDialog(
                      title: widget.boo
                          ? Text(content[i]["state"])
                          : Text(content[i]["district"]),
                      content: Text("Total Cases: " +
                          content[i]["cases"].toString() +
                          "\nTotal deaths: " +
                          content[i]["death"].toString() +
                          "\nTotal Cured: " +
                          content[i]["cured"].toString()),
                      actions: <Widget>[
                        IconButton(
                            icon: Icon(Icons.done),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    );
                  });
            },
            markerId: MarkerId(content[i]["id"].toString()),
            position: LatLng(double.parse(content[i]["latitude"]),
                double.parse(content[i]["longitude"])),
            infoWindow: InfoWindow(),
          );
          if (widget.boo == true) {
            markers[content[i]["state"]] = marker;
          } else {
            markers[content[i]["district"]] = marker;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getUri(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          content = snapshot.data;
          if (true) {
            return GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(20.5937, 78.9629)),
              onMapCreated: _onMapCreated,
              markers: markers.values.toSet(),
              // markers: ,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 10.0,
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 10.0,
            ),
          );
        }
      },
    ));
  }
}
