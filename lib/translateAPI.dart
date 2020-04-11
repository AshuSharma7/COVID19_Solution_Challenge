import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<String> data = [];
void translate(List temp) async {
  for (int i = 0; i < temp.length; i++) {
    String text = temp[i]["que"];
    String url =
        "https://translation.googleapis.com/language/translate/v2?target=hi&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$text";
    http.Response response = await http.post(url);
    Map content = json.decode(response.body);
    // if (!data.contains(content["data"]["translations"][0]["translatedText"])) {
    data.add(content["data"]["translations"][0]["translatedText"]);
    //}
  }
}
