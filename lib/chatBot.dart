import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

TextEditingController messageEditor = new TextEditingController();
ScrollController scroll = new ScrollController();
List<Map<String, dynamic>> message = [];

List<Color> color1 = [
  Color(0xFF11998e),
  Color(0xFF38ef7d),
];
List<Color> color2 = [
  Color(0xFF8E2DE2),
  Color(0xFF4A00E0),
];
bool me = true;
Widget messages(int index) {
  if (message.isNotEmpty) {
    return Container(
      margin: EdgeInsets.all(5.0),
      alignment: message[index]["me"] == true
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 6.0,
                  offset: Offset.fromDirection(1.0, 3.0))
            ],
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                colors: message[index]["me"] == true ? color1 : color2,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Text(
            message[index]["message"],
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          )),
    );
  } else {
    return Column(
      children: <Widget>[
        Center(
          child: Image.asset(
            "assets/images/empty.png",
            width: 300,
          ),
        ),
        SizedBox(height: 10.0),
        Align(
            child: Text(
          "We found Nothing Here",
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
          ),
        )),
        Align(
            child: Text(
          "Say Hi! to start",
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.black,
          ),
        ))
      ],
    );
  }
}

class _ChatBotState extends State<ChatBot> {
  Future<http.Response> sendMessage(String m) async {
    String url = "https://mitrccovid.herokuapp.com/webhooks/rest/webhook";
    var body = {
      "message": m,
    };
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onPressed: () {
                message.clear();
                setState(() {});
              })
        ],
        title: Text(
          "ChatBot",
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                controller: scroll,
                itemCount: message.length == 0 ? 1 : message.length,
                itemBuilder: (BuildContext context, int index) {
                  return messages(index);
                },
              ),
            ),
            Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 6.0,
                        offset: Offset.fromDirection(1.0, 3.0))
                  ],
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(colors: [
                    Color(0xFFFF5F6D),
                    Color(0xFFFFC371),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      //width: MediaQuery.of(context).size.width - 50.0,
                      child: TextField(
                        controller: messageEditor,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type your message...."),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 30.0,
                        ),
                        onPressed: () async {
                          message
                              .add({"message": messageEditor.text, "me": true});
                          String m = messageEditor.text;
                          messageEditor.clear();
                          scroll.jumpTo(scroll.position.maxScrollExtent);
                          setState(() {});
                          scroll.jumpTo(scroll.position.maxScrollExtent);
                          http.Response r = await sendMessage(m);
                          if (r.statusCode == 200) {
                            List data = json.decode(r.body);
                            for (int i = 0; i < data.length; i++) {
                              message.add(
                                  {"message": data[i]["text"], "me": false});
                            }
                          }
                          setState(() {});
                          scroll.animateTo(
                              scroll.position.maxScrollExtent +
                                  scroll.position.maxScrollExtent,
                              duration: Duration(milliseconds: 100),
                              curve: Curves.ease);
                          setState(() {});
                        })
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
