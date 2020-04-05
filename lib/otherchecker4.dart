import 'otherchecker5.dart';
import 'package:flutter/material.dart';

class majorotherchecker extends StatefulWidget {
  @override
  _majorotherchecker createState() => _majorotherchecker();
}

class _majorotherchecker extends State<majorotherchecker> {
  int _radioValue;
  void _handleRadio(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  List<String> users = ["Hospital", "Citizen"];
  String text;
  String selectedUser;
  TextEditingController emailEditor = new TextEditingController();
  TextEditingController passEditor = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 60.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color(0xFF3180e4),
                    Color(0xFF564dc2),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  color: Colors.white,
                ),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                //alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(top: 150),
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          //padding: EdgeInsets.only(bottom: 100),
                          width: 300,
                          height: MediaQuery.of(context).size.height / 2,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 10.0,
                            color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 10.0, right: 10.0),
                              child: ListView(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "क्या उसको इनमें से कोई बड़ी समस्या है",
                                      style: TextStyle(fontSize: 20.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                              value: 0,
                                              groupValue: _radioValue,
                                              onChanged: _handleRadio),
                                          Text("पुरानी फेफड़ों की बीमारी"),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                              value: 1,
                                              groupValue: _radioValue,
                                              onChanged: _handleRadio),
                                          Text("गंभीर दिल की स्थिति")
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                              value: 2,
                                              groupValue: _radioValue,
                                              onChanged: _handleRadio),
                                          Text("कैंसर का उपचार")
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                              value: 3,
                                              groupValue: _radioValue,
                                              onChanged: _handleRadio),
                                          Text("गंभीर मोटापा")
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                              value: 4,
                                              groupValue: _radioValue,
                                              onChanged: _handleRadio),
                                          Text("मधुमेह")
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                              value: 5,
                                              groupValue: _radioValue,
                                              onChanged: _handleRadio),
                                          Text("गुर्दे की विफलता")
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 390.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 200.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF426bd7),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26, blurRadius: 10.0)
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (_radioValue >= 0) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  othermajorLast()));
                                    }
                                  },
                                  child: Text(
                                    "आगे >>>",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class othermajorLast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("कोरोना के खिलाफ भारत की लड़ाई")),
        body: majorotherLast());
  }
}
