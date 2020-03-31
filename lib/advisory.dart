import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:translator/translator.dart';

class AdvisoryPage extends StatefulWidget {
  @override
  _AdvisoryPageState createState() => _AdvisoryPageState();
}

GoogleTranslator translator = new GoogleTranslator();
Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/apis/advisory";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

String text;
String textOriginal;

class _AdvisoryPageState extends State<AdvisoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advisory"),
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFFF9933),
          Color(0xFFFFFFFF),
          Color(0xFF138808),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: FutureBuilder(
          future: getUri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List content = snapshot.data;
              print(content[2]["title"]);
              return ListView.builder(
                itemCount: content.length,
                itemBuilder: (BuildContext context, int index) {
                  textOriginal = content[index]["title"];
                  translator.translate(textOriginal, to: "hi").then((value) {
                    text = value;
                  });

                  return Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 10.0)
                        ]),
                    child: Column(
                      children: <Widget>[
                        Text(
                          text,
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          content[index]["detail"],
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 10.0,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
