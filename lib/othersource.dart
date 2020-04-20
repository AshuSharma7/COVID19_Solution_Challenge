import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
// import 'chart1.dart';
import 'outerstate.dart';
// import 'outerstate.dart';
import 'timeseries.dart';

List<Color> blue = [Color(0xFF36D1DC), Color(0xFF5B86E5)];
List<Color> sweet = [Color(0xFFFF5F6D), Color(0xFFFFC371)];

class OtherSource extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => OuterState()));
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                  colors: blue,
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.blue[300],
                      blurRadius: 20.0,
                      spreadRadius: 0.1,
                      offset: Offset.fromDirection(4.0, -10.0))
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    LineIcons.list,
                    size: 60.0,
                  ),
                  Text("Corona case by State")
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => TimeSeries()));
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                  colors: sweet,
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.deepOrange[300],
                      blurRadius: 20.0,
                      spreadRadius: 0.1,
                      offset: Offset.fromDirection(4.0, -10.0))
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    LineIcons.list,
                    size: 60.0,
                  ),
                  Text("Corona Cases Sorted by time")
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
