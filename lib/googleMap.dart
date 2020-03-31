import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/apis/govt";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

GoogleMapController mapController;
List content;
List<String> a = ["as", "ash"];
List<double> lat = [20.5937, 25.75];
List<double> long = [78.9629, 70.67];

class _MapPageState extends State<MapPage> {
  final Map<String, Marker> markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      markers.clear();
      for (final i in a) {
        print(i);
        print(a.indexOf(i));
        final marker = Marker(
          markerId: MarkerId(content[a.indexOf(i)]["id"].toString()),
          position: LatLng(lat[a.indexOf(i)], long[a.indexOf(i)]),
          infoWindow: InfoWindow(
            title: content[a.indexOf(i)]["state"],
            snippet: content[a.indexOf(i)]["cases"].toString(),
          ),
        );
        markers[content[a.indexOf(i)]["state"]] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "Google Map",
            style: TextStyle(color: Colors.black),
          )),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: getUri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              content = snapshot.data;
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
          },
        ));
  }
}
