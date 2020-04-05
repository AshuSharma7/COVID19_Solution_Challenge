import 'package:flutter/material.dart';
import 'ministrystate.dart';

class CoronaCase extends StatelessWidget {
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
            child: Stack(
              children: <Widget>[
                Text("\nकोरोना के खिलाफ भारत की लड़ाई",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF3498db),
                      decoration: TextDecoration.none,
                      fontSize: 40,
                    )),
                Padding(
                  padding: EdgeInsets.all(80),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 8,
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            elevation: 10.0,
                            color: Color(0xFFFFFFFF),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image(
                                          image:
                                              AssetImage('images/chart.png')),
                                      Center(
                                        child: Text(
                                          "\nराज्यवार डेटा देखें",
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(left: 10),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => cityRoute()),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            elevation: 10.0,
                            color: Color(0xFFFFFFFF),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image(
                                          image: AssetImage('images/data.png')),
                                      Center(
                                        child: Text(
                                          "\nजिलावार डेटा देखें",
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(left: 10),
                          ),
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => districtRoute()),
                            // );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}

class cityRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("कोरोना के खिलाफ भारत की लड़ाई"),
        ),
        body: stateList());
  }
}

// class districtRoute extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("कोविड-19"),
//         ),
//         body: district());
//   }
// }
