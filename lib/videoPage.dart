import 'package:flutter/material.dart';
import 'package:flutube/flutube.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:neumorphic/neumorphic.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/video";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

List<String> url = [
  "https://www.youtube.com/watch?v=9OIbMVfPqtg",
  // "https://www.youtube.com/watch?v=jOoXFWDVPZk"
];

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Videos"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFFF9933),
            Color(0xFFFFFFFF),
            Color(0xFF138808),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: getUri(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List content = snapshot.data;
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //shape: RoundedRectangleBorder(borderRadius: ),
                          borderRadius: BorderRadius.circular(20.0)),
                      //padding: EdgeInsets.only(top: 20.0),
                      margin: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          FluTube(
                            url[index],
                            autoInitialize: true,
                            aspectRatio: 16 / 9,
                            allowMuting: false,
                            // autoPlay: true,
                            //looping: true,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  child: Text("data"),
                );
              }
            }),
      ),
    );
  }
}
