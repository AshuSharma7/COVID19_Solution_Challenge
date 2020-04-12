// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_localization_master/pages/DeclarationForm.dart';
// import 'package:http/http.dart' as http;

// class PatientReport extends StatefulWidget {
//   @override
//   _PatientReport createState() => _PatientReport();
// }

// Future<Map<String,dynamic>> Report() async {
//   String url = 'http://hospital-covid.herokuapp.com/api/patient/${9941}';
//   http.Response response = await http.get(url);
//   return json.decode(response.body);
// }

// // TextEditingController ctr;
// var aadhar = 9941;

// class _PatientReport extends State<PatientReport> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           gradient: LinearGradient(colors: [
//         Color(0xFFFF9933),
//         Color(0xFFFFFFFF),
//         Color(0xFF138808),
//       ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//       child: FutureBuilder(
//           future: Report(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               List content = snapshot.data;
//               return ListView.builder(
//                   itemCount: content.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Container(
//                       color: Colors.white,
//                       child: Center(
//                           child: Padding(
//                               padding: EdgeInsets.all(10),
//                               child: Text(
//                                 content[index]["status"],
//                                 style: TextStyle(
//                                     fontSize: 20.0, color: Colors.white),
//                               ))),
//                     );
//                   });
//             } else {
//               return Container();
//             }
//           }),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map> getUri() async {
  String url = "https://hospital-covid.herokuapp.com/api/patient/9941";
  http.Response response = await http.get(url);
  // var sa = json.encode(response.body);
  return json.decode(response.body);
}

// class Album {
//   final String status;
//   final int id;
//   final String come_by;

//   Album({this.status, this.id, this.come_by});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       status: json['status'],
//       id: json['id'],
//       come_by: json['come_by'],
//     );
//   }
// }

var data;

class PatientReport extends StatefulWidget {
  PatientReport({Key key}) : super(key: key);

  @override
  _PatientReport createState() => _PatientReport();
}

TextEditingController adhharEditor = new TextEditingController();

class _PatientReport extends State<PatientReport> {
  // Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    // futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getUri(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            // print(snapshot.data.status);
            if (snapshot.hasData) {
              print(snapshot.data);
              Map content = snapshot.data;
              print(content);
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[Text(content["status"])],
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
