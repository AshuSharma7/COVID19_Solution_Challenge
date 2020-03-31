import 'package:flutter/material.dart';
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

class _CoronaMonitorState extends State<CoronaMonitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "COVID19 Monitor",
          style: TextStyle(fontSize: 28.0),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xFFFF9933),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFFF9933),
          Color(0xFFFFFFFF),
          Color(0xFF138808),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: FutureBuilder(
            future: getUri(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                Map content = snapshot.data;
                return Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 280,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 10.0)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            content["countries_stat"][42]["country_name"],
                            style: TextStyle(fontSize: 28.0),
                          ),
                          Text(
                            "Total Case:" +
                                content["countries_stat"][42]["cases"],
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Text(
                            "Deaths: " +
                                content["countries_stat"][42]["deaths"],
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Text(
                            "Total Recovered: " +
                                content["countries_stat"][42]
                                    ["total_recovered"],
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Text(
                            "New Cases: " +
                                content["countries_stat"][
                                        42] //new_deaths":"2","new_cases":"121","serious_critical":"0","active_cases":"602","total_cases_per_1m_population":"0.5
                                    ["new_cases"],
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Text(
                            "Serious/Critical: " +
                                content["countries_stat"][42]
                                    ["serious_critical"],
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Text(
                            "Active Cases: " +
                                content["countries_stat"][42]["active_cases"],
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Text(
                            "Total Cases Per 1M People: " +
                                content["countries_stat"][42]
                                    ["total_cases_per_1m_population"],
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 270.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 10.0)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "World",
                            style: TextStyle(fontSize: 25.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text("                "),
                              Text(
                                content["countries_stat"][0]["country_name"],
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Text(
                                content["countries_stat"][1]["country_name"],
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Text(
                                content["countries_stat"][2]["country_name"],
                                style: TextStyle(fontSize: 18.0),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Total Cases",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                content["countries_stat"][0]["cases"],
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Text(
                                content["countries_stat"][1]["cases"],
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Text(
                                content["countries_stat"][2]["cases"],
                                style: TextStyle(fontSize: 18.0),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Total Deaths",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                content["countries_stat"][0]["deaths"],
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Text(
                                content["countries_stat"][1]["deaths"],
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Text(
                                content["countries_stat"][2]["deaths"],
                                style: TextStyle(fontSize: 18.0),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      strokeWidth: 10.0,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
