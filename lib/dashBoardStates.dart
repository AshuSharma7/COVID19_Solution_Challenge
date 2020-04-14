import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

import 'dashBoardGoogleMap.dart' as dash;
import 'package:flutter/material.dart';
import 'getLangCode.dart' as lang;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dashBoardDistrict.dart' as dash;

class stateList extends StatefulWidget {
  String para;
  stateList({Key key, @required this.para}) : super(key: key);

  _stateList createState() => _stateList();
}

Future<List<dynamic>> getUri() async {
  String url = "https://covid-mitrc.herokuapp.com/accounts/member";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

List<String> states = [];
double width;

double height;

List<Color> color1 = [
  Color(0xFF11998e),
  Color(0xFF38ef7d),
];
List<Color> color2 = [
  Color(0xFFFF5F6D),
  Color(0xFFFFC371),
];

class _stateList extends State<stateList> {
  List<String> translatedStates = [];
  void translate() async {
    String langCode = await lang.prefs();
    for (int i = 0; i < states.length; i++) {
      String text = states[i];
      String url =
          "https://translation.googleapis.com/language/translate/v2?target=$langCode&key=AIzaSyAu7bUrwnWzbfN2lK-zGxdf-KHbzvm-PNA&q=$text";
      http.Response response = await http.get(url);
      Map content = json.decode(response.body);
      if (!translatedStates
          .contains(content["data"]["translations"][0]["translatedText"])) {
        translatedStates
            .add(content["data"]["translations"][0]["translatedText"]);
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
                    "State Chart",
                    style: TextStyle(color: Colors.black),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.map,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              FutureBuilder(
                  future: getUri(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List content = snapshot.data;
                      for (int i = 0; i < content.length; i++) {
                        if (!states.contains(content[i]["state"]) &&
                            content[i][widget.para] == true) {
                          states.add(content[i]["state"]);
                        }
                      }
                      states
                          .sort((a, b) => a.toString().compareTo(b.toString()));
                      translate();
                      return ListView.builder(
                        itemCount: states.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => stateDetails(
                                          states[index], widget.para)));
                            },
                            child: Container(
                              height: 60,
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
                                                  padding: EdgeInsets.symmetric(
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
                                      : Text(
                                          translatedStates[index],
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white),
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
                          child: SpinKitChasingDots(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                  }),
              dash.MapPage(
                para: widget.para,
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

Widget stateDetails(String state, String para) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1976d2),
        // backgroundColor: Color(0xff308e1c),

        title: Text(state),
      ),
      body: Container(
        child: dash.DistrictList(
          state: state,
          para: para,
        ),
      ));
}
