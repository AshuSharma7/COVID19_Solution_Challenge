import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String langCode = 'en';
Future<String> prefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  langCode = prefs.getString('languageCode') == null
      ? "en"
      : prefs.getString('languageCode');
  return langCode;
}
