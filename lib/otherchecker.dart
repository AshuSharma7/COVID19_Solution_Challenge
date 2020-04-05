import 'otherchecker2.dart';
import 'package:flutter/material.dart';

class otherchecker extends StatefulWidget {
  @override
  _otherchecker createState() => _otherchecker();
}

class _otherchecker extends State<otherchecker> {
  int _radioValue;
  void _handleRadio(int value) {
    setState(() {
      _radioValue = value;
    });
  }

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
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Image(image: AssetImage('images/forindia.gif')),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 15,
                    ),
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
                                    "उसकी उम्र क्या है?",
                                    style: TextStyle(fontSize: 25.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            value: 0,
                                            groupValue: _radioValue,
                                            onChanged: _handleRadio),
                                        Text("2 साल से कम उम्र का"),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            value: 1,
                                            groupValue: _radioValue,
                                            onChanged: _handleRadio),
                                        Text("2-4")
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            value: 2,
                                            groupValue: _radioValue,
                                            onChanged: _handleRadio),
                                        Text("5-9"),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            value: 3,
                                            groupValue: _radioValue,
                                            onChanged: _handleRadio),
                                        Text("10-18")
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            value: 4,
                                            groupValue: _radioValue,
                                            onChanged: _handleRadio),
                                        Text("19-29"),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            value: 5,
                                            groupValue: _radioValue,
                                            onChanged: _handleRadio),
                                        Text("30-39")
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            value: 6,
                                            groupValue: _radioValue,
                                            onChanged: _handleRadio),
                                        Text("40-49"),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            value: 7,
                                            groupValue: _radioValue,
                                            onChanged: _handleRadio),
                                        Text("50-59")
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            value: 8,
                                            groupValue: _radioValue,
                                            onChanged: _handleRadio),
                                        Text("60-69"),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            value: 9,
                                            groupValue: _radioValue,
                                            onChanged: _handleRadio),
                                        Text("70+")
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
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
                                if (_radioValue >= 0) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              selfotherchecker2()));
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
            ),
          ],
        ),
      ),
    );
  }
}

class selfotherchecker2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("कोरोना के खिलाफ भारत की लड़ाई")),
        body: otherchecker2());
  }
}
