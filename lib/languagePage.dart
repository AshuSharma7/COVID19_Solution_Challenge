import 'package:covid19/homePage.dart';
import 'package:covid19/splashPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globalVar.dart' as global;

class LanguagePage extends StatelessWidget {
  List<String> lang = ["english", "hindi", "punjabi", "bengali"];
  List<String> lang2 = ["odiya", "telugu", "marathi", "kannada", "tamil"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Welcome",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 30.0),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xFFFF9933),
      ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "Please Select Your Language\nकृपया अपनी भाषा चुनें",
                style: TextStyle(fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: lang.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          global.lang = lang[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SplashPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26, blurRadius: 10.0),
                              ],
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white
                              // gradient: LinearGradient(
                              //     colors: [
                              //       Color(0xFF3180e4),
                              //       Color(0xFF564dc2),
                              //     ],
                              //     begin: Alignment.topCenter,
                              //     end: Alignment.bottomCenter)
                              ),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                          child: Center(
                              child: Text(
                            lang[index],
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.black),
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('lang', lang2[index]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26, blurRadius: 10.0),
                              ],
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white
                              // gradient: LinearGradient(
                              //     colors: [
                              //       Color(0xFF3180e4),
                              //       Color(0xFF564dc2),
                              //     ],
                              //     begin: Alignment.topCenter,
                              //     end: Alignment.bottomCenter)
                              ),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                          child: Center(
                              child: Text(
                            lang2[index],
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.black),
                          )),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
