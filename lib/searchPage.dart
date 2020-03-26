import 'package:covid19/helpLine.dart';
import 'package:flutter/material.dart';
import 'helpLine.dart' as query;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
          style: TextStyle(fontSize: 32.0),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xFF3180e4),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF3180e4),
              Color(0xFF564dc2),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          helpLineDetails(query.searchQuery)));
            },
            child: Align(
              alignment: Alignment.topCenter,
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
                  query.searchQuery,
                  style: TextStyle(fontSize: 20.0),
                )),
              ),
            ),
          )),
    );
  }
}
