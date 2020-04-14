import 'package:flutter/material.dart';
import 'package:flutter_localization_master/localization/language_constants.dart';
import 'package:flutter_localization_master/pages/MyHomePage.dart';
// import 'package:fprojects/familyDeclaration.dart';
// import 'package:fprojects/slefDeclaration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoronaMonitor extends StatefulWidget {
  @override
  _CoronaMonitorState createState() => _CoronaMonitorState();
}

String apiKey = "a051a6e786msheabdb117530fe36p133d27jsn3c2846d089cd";
Future<dynamic> getUri() async {
  String url =
      "https://coronavirus-monitor.p.rapidapi.com/coronavirus/cases_by_country.php";
  Map<String, String> headers = {
    "content-type": "application/json",
    "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
    "x-rapidapi-key": apiKey,
  };
  http.Response response = await http.get(url, headers: headers);
  return json.decode(response.body);
}

List<Color> color1 = [
  Color(0xFF11998e),
  Color(0xFF38ef7d),
];
List<Color> color2 = [
  Color(0xFFFF5F6D),
  Color(0xFFFFC371),
];

class _CoronaMonitorState extends State<CoronaMonitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //     padding: EdgeInsets.only(left: 5),
        //     child: Image(image: AssetImage('images/Corona.png'))),
        title: Center(
          child: Text(
            // "कोरोना मॉनिटर",
            getTranslated(context, 'corona_monitor'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28.0, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: FutureBuilder(
            future: getUri(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                Map content = snapshot.data;
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 530,
                        color: Colors.white,
                        child: Stack(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  content["countries_stat"][21]["country_name"]
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(fontSize: 30.0),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        colors: color1,
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black45,
                                                          blurRadius: 5.0,
                                                          offset: Offset
                                                              .fromDirection(
                                                                  1.0, 3.0))
                                                    ],
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      // "कुल संक्रमण:"
                                                      getTranslated(context,
                                                              'total_infected') +
                                                          "\n" +
                                                          content["countries_stat"]
                                                              [21]["cases"],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                  )))),
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: color2,
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black45,
                                                    blurRadius: 5.0,
                                                    offset:
                                                        Offset.fromDirection(
                                                            1.0, 3.0))
                                              ],
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                // "कुल मौतें:"
                                                getTranslated(context,
                                                        'total_death') +
                                                    "\n" +
                                                    content["countries_stat"]
                                                        [21]["deaths"],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            )),
                                      ))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        colors: color1,
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black45,
                                                          blurRadius: 5.0,
                                                          offset: Offset
                                                              .fromDirection(
                                                                  1.0, 3.0))
                                                    ],
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      // "कुल उपचारित: "
                                                      getTranslated(context,
                                                              'total_cured') +
                                                          "\n" +
                                                          content["countries_stat"]
                                                                  [21][
                                                              "total_recovered"],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                  )))),
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: color2,
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black45,
                                                    blurRadius: 5.0,
                                                    offset:
                                                        Offset.fromDirection(
                                                            1.0, 3.0))
                                              ],
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                // "संक्रमण के नए मामले : "
                                                getTranslated(
                                                        context, 'new_cases') +
                                                    "\n" +
                                                    content["countries_stat"][
                                                            21] //new_deaths":"2","new_cases":"121","serious_critical":"0","active_cases":"602","total_cases_per_1m_population":"0.5
                                                        ["new_cases"],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            )),
                                      )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        colors: color1,
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black45,
                                                          blurRadius: 5.0,
                                                          offset: Offset
                                                              .fromDirection(
                                                                  1.0, 3.0))
                                                    ],
                                                  ),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        // "गंभीर / महत्वपूर्ण:"
                                                        getTranslated(context,
                                                                'critical') +
                                                            "\n" +
                                                            content["countries_stat"]
                                                                    [21][
                                                                "serious_critical"],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                        ),
                                                      ))))),
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: color2,
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black45,
                                                    blurRadius: 5.0,
                                                    offset:
                                                        Offset.fromDirection(
                                                            1.0, 3.0))
                                              ],
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                // "सक्रिय मामले:"
                                                getTranslated(context,
                                                        'active_cases') +
                                                    "\n" +
                                                    content["countries_stat"]
                                                        [21]["active_cases"],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            )),
                                      ))
                                    ],
                                  ),
                                ),
                                Text(
                                  // "प्रति 10 लाख लोगों पर कुल मामले: "
                                  getTranslated(context, 'total_cases_per') +
                                      content["countries_stat"][21]
                                          ["total_cases_per_1m_population"],
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 170.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF8E2DE2),
                                    Color(0xFF4A00E0),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 5.0,
                                    offset: Offset.fromDirection(1.0, 3.0))
                              ],
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    // "विश्व के आंकड़े कोरोना पर",
                                    getTranslated(context, 'world_figure'),
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Table(
                                        border: TableBorder.all(
                                            width: 1.0, color: Colors.black),
                                        children: [
                                          TableRow(children: [
                                            TableCell(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    "Country Name",
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Total Cases",
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Total deaths",
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    content["countries_stat"][3]
                                                        ["country_name"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0),
                                                  ),
                                                  Text(
                                                    content["countries_stat"][3]
                                                        ["cases"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0),
                                                  ),
                                                  Text(
                                                    content["countries_stat"][3]
                                                        ["deaths"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    content["countries_stat"][1]
                                                        ["country_name"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0),
                                                  ),
                                                  Text(
                                                    content["countries_stat"][1]
                                                        ["cases"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0),
                                                  ),
                                                  Text(
                                                    content["countries_stat"][1]
                                                        ["deaths"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[],
                                              ),
                                            )
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    content["countries_stat"][2]
                                                        ["country_name"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0),
                                                  ),
                                                  Text(
                                                    content["countries_stat"][2]
                                                        ["cases"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0),
                                                  ),
                                                  Text(
                                                    content["countries_stat"][2]
                                                        ["deaths"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0),
                                                  )
                                                ],
                                              ),
                                            )
                                          ])
                                        ],
                                      )),
                                ],
                              ),
                            ))),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          width: 200.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF426bd7),
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 10.0)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => mainBoard()),
                                  (_) => false);
                            },
                            child: Text(
                              // "Next",
                              getTranslated(context, 'next'),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                  ),
                );
              }
            }),
      ),
    );
  }
}
