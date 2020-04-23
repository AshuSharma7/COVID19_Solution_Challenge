import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

import 'googleMap.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'getLangCode.dart' as lang;
import 'districtListMinistry.dart';
import 'districtMap.dart' as district;

class stateList extends StatefulWidget {
  final Widget child;

  stateList({
    Key key,
    this.child,
  }) : super(key: key);
  _stateList createState() => _stateList();
}

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/apis/govt";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

List<Map<String, dynamic>> states = [];

List<Color> color1 = [
  Color(0xFF11998e),
  Color(0xFF38ef7d),
];
List<Color> color2 = [
  Color(0xFFFF5F6D),
  Color(0xFFFFC371),
];

class SubscriberSeries {
  final String year;
  final int subscribers;
  final charts.Color barColor;

  SubscriberSeries(
      {@required this.year,
      @required this.subscribers,
      @required this.barColor});
}

double width;

double height;
List<SubscriberSeries> data;

void generate(List content, String state) {
  data = [
    SubscriberSeries(
      year: "",
      subscribers: 0,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    )
  ];
  int count = 0;
  for (int i = 0; i < content.length; i++) {
    if (content[i]["state"].toString().toLowerCase() == state.toLowerCase() &&
        content[i]["is_state"] == false) {
      count++;
      data.add(SubscriberSeries(
        year: content[i]["district"],
        subscribers: content[i]["cases"],
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ));
    }
  }
}

bool f = true;
List<Map<String, dynamic>> translatedStates = [];

class _stateList extends State<stateList> {
  void translate() async {
    String langCode = await lang.prefs();
    for (int i = 0; i < states.length; i++) {
      String state = states[i]["state"].toString().toLowerCase();
      String url =
          "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$state";
      http.Response response = await http.get(url);
      Map content = json.decode(response.body);
      if (!translatedStates.contains({
        "state": content["data"]["translations"][0]["translatedText"],
      })) {
        translatedStates.add({
          "state": content["data"]["translations"][0]["translatedText"],
        });
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                onPressed: () {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Container(
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Tap on Each State to Know More",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: const Color(0xFF1BC0C5),
                                  ),
                                ],
                              )),
                        );
                      });
                })
          ],
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "States",
            style: TextStyle(fontSize: 30.0, color: Colors.black),
          ),
          bottom: TabBar(
            indicatorColor: Color(0xff9962D0),
            tabs: [
              Tab(
                  child: Text(
                    "State List",
                    style: TextStyle(color: Colors.black),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.list,
                    color: Colors.black,
                  )),
              Tab(
                  child: Text(
                    "State Map",
                    style: TextStyle(color: Colors.black),
                  ),
                  icon: Icon(FontAwesomeIcons.map, color: Colors.black)),
            ],
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.white),
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              FutureBuilder(
                  future: getUri(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List content = snapshot.data;
                      bool flag = false;
                      for (int i = 0; i < content.length; i++) {
                        flag = false;
                        if (content[i]["is_state"] == true) {
                          for (int j = 0; j < states.length; j++) {
                            if (states[j]["state"].toString().toLowerCase() ==
                                content[i]["state"].toString().toLowerCase()) {
                              flag = true;
                            }
                          }
                          if (flag == false) {
                            states.add({
                              "state": content[i]["state"],
                              "cases": content[i]["cases"],
                              "cured": content[i]["cured"],
                              "death": content[i]["death"]
                            });
                          }
                        }
                      }
                      states.sort((a, b) => a["state"].compareTo(b["state"]));
                      translate();
                      if (translatedStates.isNotEmpty) {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: states.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => stateDetails(
                                            states[index]["state"])));
                              },
                              child: Container(
                                // height: 60,
                                margin: EdgeInsets.all(10.0),
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: index % 2 == 0 ? color1 : color2,
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
                                child: Center(
                                    child: translatedStates.isEmpty
                                        ? Shimmer.fromColors(
                                            child: Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: double.infinity,
                                                    height: 15.0,
                                                    color: Colors.white54,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 15.0,
                                                    color: Colors.white54,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: 40.0,
                                                    height: 15.0,
                                                    color: Colors.white54,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            baseColor: Colors.grey[300],
                                            highlightColor: Colors.grey[50])
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                translatedStates[index]
                                                    ["state"],
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "Total Cases: " +
                                                    states[index]["cases"]
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "Total Cured: " +
                                                    states[index]["cured"]
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "Total Deaths: " +
                                                    states[index]["death"]
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )),
                              ),
                            );
                          },
                        );
                      } else {
                        return Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: SpinKitChasingDots(color: Colors.black),
                          ),
                        );
                      }
                    } else {
                      return Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: SpinKitChasingDots(color: Colors.black),
                        ),
                      );
                    }
                  }),
              MapPage(
                boo: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}

Widget stateDetails(String state) {
  return Scaffold(
    // debugShowCheckedModeBanner: false,
    body: DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            // backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              isScrollable: false,
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(
                  child: Text("District List",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  icon: Icon(Icons.menu, color: Colors.black),
                ),
                Tab(
                  child: Text("Chart",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  icon: Icon(Icons.menu, color: Colors.black),
                ),
                Tab(
                    child: Text("District Map",
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    icon: Icon(FontAwesomeIcons.map, color: Colors.black)),
              ],
            ),
            title: Text(
              state,
              style: TextStyle(color: Colors.black, fontSize: 30.0),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
          ),
          body: FutureBuilder(
            future: getUri(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List content = snapshot.data;

                int index;
                for (int i = 0; i < content.length; i++) {
                  if (content[i]["state"] == state &&
                      content[i]["is_state"] == true) {
                    index = i;
                  }
                }
                generate(content, state);
                return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      DistrictList(state: state),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SubscriberChart(
                          data: data,
                        ),
                      ),
                      district.MapPage(
                        state: state,
                      )
                    ]);
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                  ),
                );
              }
            },
          )),
    ),
  );
}

class SubscriberChart extends StatelessWidget {
  final List<SubscriberSeries> data;

  SubscriberChart({@required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<SubscriberSeries, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (SubscriberSeries series, _) => series.year,
          measureFn: (SubscriberSeries series, _) => series.subscribers,
          colorFn: (SubscriberSeries series, _) => series.barColor)
    ];

    return Container(
      height: MediaQuery.of(context).size.height,
      width: 1000,
      //padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Corona Cases",
                style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.BarChart(
                  series,
                  animate: true,
                  vertical: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
