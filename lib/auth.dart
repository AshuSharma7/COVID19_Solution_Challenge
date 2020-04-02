import 'dart:io';
import 'dart:convert';
import 'package:covid19/familyDeclaration.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

String userId;

//Register Variables
TextEditingController userName = new TextEditingController();
TextEditingController name = new TextEditingController();
TextEditingController password = new TextEditingController();

Future<dynamic> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/accounts";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

Future<File> getPath() async {
  final appDir = await getApplicationDocumentsDirectory();
  final path = appDir.path;
  final file = File('$path/userId.txt');
  return file;
}

Map<dynamic, dynamic> getJson() {
  FutureBuilder(
    future: getUri(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        List content = snapshot.data;
      } else {
        print("connection error");
      }
    },
  );
  return content;
}
