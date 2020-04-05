import 'otherchecker.dart';
import 'ownchecker1.dart';
import 'package:flutter/material.dart';

class checker3 extends StatefulWidget {
  @override
  _checker3 createState() => _checker3();
}

class _checker3 extends State<checker3> {
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
            ListView(
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
                  height: MediaQuery.of(context).size.height / 1.5,
                  color: Colors.white,
                ),
              ],
            ),
            ListView(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 18,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Image(image: AssetImage('images/forindia.gif')),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 11,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
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
                                        "अपने राज्य का उल्लेख करें।",
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                    TextFormField(
                                      obscureText: false,
                                      keyboardType: TextInputType.text,
                                      // controller: passEditor,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                        child: Text(
                                      " आप अपने लिए या किसी और के लिए जवाब दे रहे हैं?",
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    )),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                                value: 0,
                                                groupValue: _radioValue,
                                                onChanged: _handleRadio),
                                            Text("अपने लिए"),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                                value: 1,
                                                groupValue: _radioValue,
                                                onChanged: _handleRadio),
                                            Text("किसी और के लिए")
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Center(
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
                                  if (_radioValue == 0) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                selfownchecker()));
                                  } else if (_radioValue == 1) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                selfotherchecker()));
                                  }
                                },
                                child: Text(
                                  "आगे  >>>",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class selfownchecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("कोरोना के खिलाफ भारत की लड़ाई")),
        body: ownchecker());
  }
}

class selfotherchecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("कोरोना के खिलाफ भारत की लड़ाई")),
        body: otherchecker());
  }
}
