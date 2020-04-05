import 'package:flutter/material.dart';
import 'deathgrid.dart';
import 'depart.dart';

class department extends StatefulWidget {
  @override
  _department createState() => _department();
}

class _department extends State<department>
    with SingleTickerProviderStateMixin {
  String i;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFFFF9933),
              Color(0xFFFFFFFF),
              Color(0xFF138808),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: ListView(children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => secondgrid()),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                elevation: 10.0,
                                color: Color(0xFFFFFFFF),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image(
                                          image: AssetImage(
                                              'images/hospital.png')),
                                      Center(
                                        child: Text(
                                          "\nसरकारी लैब सेंटर",
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                margin: EdgeInsets.only(left: 10),
                              ))),
                    ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            elevation: 10.0,
                            color: Color(0xFFFFFFFF),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                      image: AssetImage('images/hospital.png')),
                                  Center(
                                    child: Text(
                                      "\nनिजी लैब सेंटर",
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            margin: EdgeInsets.only(left: 10),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => secondgrid()),
                            );
                          },
                        ),
                      ),
                    ],
                  ))
            ])));
  }
}

class secondgrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: deathgrid());
  }
}

// class firstgrid extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
//         ));
//         // body: );
//   }
// }
