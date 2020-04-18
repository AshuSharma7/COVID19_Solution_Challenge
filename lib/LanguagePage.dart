import 'package:flutter/material.dart';
import 'package:flutter_localization_master/classes/language.dart';
import 'package:flutter_localization_master/localization/language_constants.dart';
import 'package:flutter_localization_master/main.dart';
import 'package:flutter_localization_master/pages/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_localization_master/router/route_constants.dart';

class LanguagePage extends StatefulWidget {
  LanguagePage({Key key}) : super(key: key);

  @override
  _LanguagePage createState() => _LanguagePage();
}

class _LanguagePage extends State<LanguagePage> {
  Language language;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  void _showSuccessDialog() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  String lang = "Select Your Language";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 35.0),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Text(
              "Please Select Your Language\nकृपया अपनी भाषा चुनें",
              style: TextStyle(
                fontSize: 32.0,
              ),
              textAlign: TextAlign.center,
            ),
            Image.asset(
              "assets/images/flag.png",
            ),
            Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFFff9966),
                    Color(0xFFff5e62),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.deepOrange[200],
                        blurRadius: 15.0,
                        offset: Offset.fromDirection(1.0, 10.0))
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Text(
                        lang,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Center(
                      child: Expanded(
                        child: DropdownButton(
                          underline: SizedBox(),
                          onChanged: (language) {
                            _changeLanguage(language);
                            setState(() {
                              lang = language.name;
                            });
                          },
                          items: Language.languageList()
                              .map(
                                (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.name,
                                      style: TextStyle(color: Colors.black),
                                    )),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                )),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  height: 60.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF1488CC), Color(0xFF2B32B2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blue[700],
                          blurRadius: 20.0,
                          offset: Offset.fromDirection(4.5, -10.0))
                    ],
                  ),
                  child: Center(
                    child: Text(
                      getTranslated(context, 'next'),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
