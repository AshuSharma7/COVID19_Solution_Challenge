import 'package:flutter/material.dart';

class audiodata extends StatelessWidget {
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
                                              AssetImage('images/virus.png')),
                                      Center(
                                        child: Text(
                                        
                                          "\nयदि कोरोना है तो ऑडियो नमूना अपलोड करें",
                                          textAlign:TextAlign.center,
                                          
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.blue,),
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => SecondRoute()),
                            // );
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Expanded(
                          child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        elevation: 10.0,
                        color: Color(0xFFFFFFFF),
                        child: Stack(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => SecondRoute()),
                                // );
                              },
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(image: AssetImage('images/symptoms.png')),
                                  Center(
                                    child: Text(
                                      "\nलक्षण होने पर ऑडियो नमूना अपलोड करें",
                                      textDirection: TextDirection.ltr,
                                      textAlign:TextAlign.center,
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
                          ],
                        ),
                        margin: EdgeInsets.only(left: 10),
                      ))
                    ],
                  ),
                )
              ],
            )));
  }
}

// class SecondRoute extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: HomePage4());
//   }
// }
