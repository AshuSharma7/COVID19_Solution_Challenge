import 'package:flutter/material.dart';

class FarmerDashBoard extends StatefulWidget {
  @override
  _FarmerDashBoardState createState() => _FarmerDashBoardState();
}

List<Color> color = [
  Color(0xFFf5cd79),
  Color(0xFF778beb),
  Color(0xFF63cdda),
  Color(0xFFf3a683),
  Color(0xFF786fa6)
];

class _FarmerDashBoardState extends State<FarmerDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DashBoard",
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xFFf1c40f),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFf1c40f),
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, int index) {
              double height = 100;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    height = 200;
                  });
                },
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    height: height,
                    margin: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage("assets/images/diet.png"),
                            width: 50,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "13 Items Needed",
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 20.0),
                                  ),
                                  Text(
                                    "Distance: 3km",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              );
            }),
      ),
    );
  }
}
