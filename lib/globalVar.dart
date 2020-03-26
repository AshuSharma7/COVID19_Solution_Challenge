import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String lang;
int flag = 0;
Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/faq";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}
