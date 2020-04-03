import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class stateList extends StatefulWidget {
  final Widget child;

  stateList({Key key, this.child}) : super(key: key);
  _stateList createState() => _stateList();
}

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/apis/govt";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

List<String> states = [];
double width;

double height;
List<charts.Series<Task, String>> _seriesPieData;
List<charts.Series<Sales, int>> _seriesLineData;

_generateData(double cases, double deaths, double cured) {
  var piedata = [
    new Task('Total Cases', cases, Color(0xff3366cc)),
    new Task('Total Deaths', deaths, Color(0xff990099)),
    new Task('Total Cured', cured, Color(0xff109618)),
  ];

  var linesalesdata = [
    new Sales(0, 45),
    new Sales(1, 56),
    new Sales(2, 55),
    new Sales(3, 60),
    new Sales(4, 61),
    new Sales(5, 80),
    new Sales(6, 45),
    new Sales(7, 56),
    new Sales(8, 55),
    new Sales(9, 60),
    new Sales(10, 61),
  ];
  var linesalesdata1 = [
    new Sales(0, 35),
    new Sales(1, 46),
    new Sales(2, 45),
    new Sales(3, 50),
    new Sales(4, 51),
    new Sales(5, 60),
    new Sales(6, 35),
    new Sales(7, 46),
    new Sales(8, 45),
    new Sales(9, 50),
    new Sales(10, 51),
  ];

  var linesalesdata2 = [
    new Sales(0, 20),
    new Sales(1, 24),
    new Sales(2, 25),
    new Sales(3, 40),
    new Sales(4, 45),
    new Sales(5, 60),
    new Sales(6, 20),
    new Sales(7, 24),
    new Sales(8, 25),
    new Sales(9, 40),
    new Sales(10, 45),
  ];

  _seriesPieData.clear();
  _seriesPieData.add(
    charts.Series(
      domainFn: (Task task, _) => task.task,
      measureFn: (Task task, _) => task.taskvalue,
      colorFn: (Task task, _) => charts.ColorUtil.fromDartColor(task.colorval),
      id: 'Air Pollution',
      data: piedata,
      labelAccessorFn: (Task row, _) => '${row.taskvalue}',
    ),
  );

  _seriesLineData.add(
    charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
      id: 'Air Pollution',
      data: linesalesdata,
      domainFn: (Sales sales, _) => sales.yearval,
      measureFn: (Sales sales, _) => sales.salesval,
    ),
  );
  _seriesLineData.add(
    charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
      id: 'Air Pollution',
      data: linesalesdata1,
      domainFn: (Sales sales, _) => sales.yearval,
      measureFn: (Sales sales, _) => sales.salesval,
    ),
  );
  _seriesLineData.add(
    charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      id: 'Air Pollution',
      data: linesalesdata2,
      domainFn: (Sales sales, _) => sales.yearval,
      measureFn: (Sales sales, _) => sales.salesval,
    ),
  );
}

class _stateList extends State<stateList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFFFF9933),
          Color(0xFFFFFFFF),
          Color(0xFF138808),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: FutureBuilder(
          future: getUri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List content = snapshot.data;
              for (int i = 0; i < content.length; i++) {
                if (!states.contains(content[i]["state"])) {
                  states.add(content[i]["state"]);
                }
              }
              states.sort((a, b) => a.toString().compareTo(b.toString()));

              return ListView.builder(
                itemCount: states.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  stateDetails(states[index])));
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 10.0)
                          ]),
                      child: Center(
                          child: Text(
                        states[index],
                        style: TextStyle(fontSize: 20.0),
                      )),
                    ),
                  );
                },
              );
            } else {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                  ),
                ),
              );
            }
          }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();
    _seriesLineData = List<charts.Series<Sales, int>>();
  }
}

Widget stateDetails(String state) {
  return Scaffold(
    // debugShowCheckedModeBanner: false,
    body: DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1976d2),
            // backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(
                    icon: Icon(
                  FontAwesomeIcons.chartPie,
                )),
                Tab(icon: Icon(FontAwesomeIcons.chartLine)),
              ],
            ),
            title: Text('कोविड-19'),
          ),
          body: FutureBuilder(
            future: getUri(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List content = snapshot.data;
                int index;
                for (int i = 0; i < content.length; i++) {
                  if (content[i]["state"] == state) {
                    index = i;
                  }
                }
                _generateData(
                    content[index]["cases"].toDouble(),
                    content[index]["death"].toDouble(),
                    content[index]["cured"].toDouble());
                return TabBarView(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: charts.PieChart(_seriesPieData,
                        animate: true,
                        animationDuration: Duration(seconds: 5),
                        behaviors: [
                          new charts.DatumLegend(
                            outsideJustification:
                                charts.OutsideJustification.endDrawArea,
                            horizontalFirst: false,
                            desiredMaxRows: 2,
                            cellPadding:
                                new EdgeInsets.only(right: 4.0, bottom: 4.0),
                            entryTextStyle: charts.TextStyleSpec(
                                color:
                                    charts.MaterialPalette.purple.shadeDefault,
                                fontFamily: 'Georgia',
                                fontSize: 11),
                          )
                        ],
                        defaultRenderer: new charts.ArcRendererConfig(
                            arcWidth: 100,
                            arcRendererDecorators: [
                              new charts.ArcLabelDecorator(
                                  labelPosition: charts.ArcLabelPosition.inside)
                            ])),
                  ),
                  ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: charts.LineChart(_seriesLineData,
                              defaultRenderer: new charts.LineRendererConfig(
                                  includeArea: true, stacked: true),
                              animate: true,
                              animationDuration: Duration(seconds: 5),
                              behaviors: [
                                new charts.ChartTitle('दिन',
                                    behaviorPosition:
                                        charts.BehaviorPosition.bottom,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                                new charts.ChartTitle('ठीक ',
                                    behaviorPosition:
                                        charts.BehaviorPosition.start,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                                new charts.ChartTitle(
                                  'संगरोध',
                                  behaviorPosition: charts.BehaviorPosition.end,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea,
                                )
                              ]),
                        );
                      })
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

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
