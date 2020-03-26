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

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Videos"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: getUri(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List content = snapshot.data;
                return ListView.builder(
                  itemCount: content.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //shape: RoundedRectangleBorder(borderRadius: ),
                          borderRadius: BorderRadius.circular(20.0)),
                      //padding: EdgeInsets.only(top: 20.0),
                      margin: EdgeInsets.all(20.0),
                      child: FluTube(
                        "https://www.youtube.com/watch?v=G5Z7dOG9SuM",
                        autoInitialize: true,
                        aspectRatio: 16 / 9,
                        allowMuting: false,
                        looping: true,
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
