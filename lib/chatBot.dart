import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

List<String> sent = [];
List<String> received = [];

TextEditingController message = new TextEditingController();

Future<Response> sendMessage(String m) async {
  String url = "https://mitrccovidapp.herokuapp.com/webhooks/rest/webhook/";
  var body = {
    "message": m,
  };
  Response response = await post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );
  return response;
}

Widget sentMessage(int i) {
  if (sent[i] != null || sent[i] != "") {
    return Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        alignment: Alignment.bottomRight,
        child: Text(sent[i]));
  } else {
    return SizedBox(
      height: 0.0,
    );
  }
}

Widget receivedMessage(int i) {
  if (sent[i] != null || sent[i] != "") {
    return Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        alignment: Alignment.bottomLeft,
        child: Text(received[i]));
  } else {
    return SizedBox(
      height: 0.0,
    );
  }
}

ScrollController scroll = new ScrollController();

class _ChatBotState extends State<ChatBot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ChatBot"),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    controller: scroll,
                    shrinkWrap: true,
                    //reverse: true,
                    itemCount: sent.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          sentMessage(index),
                          receivedMessage(index)
                        ],
                      );
                    }),
              ),
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: message,
                          decoration:
                              InputDecoration(hintText: "Type Your Message"),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.send, color: Colors.black),
                          onPressed: () async {
                            sent.add(message.text);
                            String m = message.text;
                            message.clear();
                            Response r = await sendMessage(m);
                            if (r.statusCode == 200) {
                              List<dynamic> jsonData = json.decode(r.body);
                              List content = jsonData;
                              received.add(content[0]["text"]);

                              setState(() {});
                              scroll.animateTo(scroll.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            }
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
