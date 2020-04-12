import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String langCode = 'en';
void prefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  langCode = prefs.getString('languageCode');
}
