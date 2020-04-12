import 'package:flutter/material.dart';
import 'package:flutter_localization_master/classes/language.dart';
import 'package:flutter_localization_master/localization/language_constants.dart';
import 'package:flutter_localization_master/main.dart';
import 'package:flutter_localization_master/pages/LoginPage.dart';
import 'package:flutter_localization_master/pages/homePage.dart';
import 'package:flutter_localization_master/pages/splashPage.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Covid-19")),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFFF9933),
          Color(0xFFFFFFFF),
          Color(0xFF138808),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Text(
              "\nPlease Select Your Language\nकृपया अपनी भाषा चुनें",
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0),
            Image(image: AssetImage('images/flag.gif')),
            SizedBox(height: 40.0),
            Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Center(
                      child: DropdownButton<Language>(
                        underline: SizedBox(),
                        onChanged: (Language language) {
                          _changeLanguage(language);
                        },
                        items: Language.languageList()
                            .map<DropdownMenuItem<Language>>(
                              (e) => DropdownMenuItem<Language>(
                                value: e,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      e.name,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(40),
                child: MaterialButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    // To close the Drawer
                    // Navigator.pop(context);
                    // Navigating to About Page
                    // Navigator.pushNamed(context, 'splashR');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  height: 50,
                  shape: StadiumBorder(),
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Text(
                      // "Next",
                      getTranslated(context, 'next'),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
