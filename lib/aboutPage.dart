import 'package:covid19/faqPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

List<Color> colorsMentor = [
  Color(0xFF11998e),
  Color(0xFF38ef7d),
];
List<Color> colorsStudent = [
  Color(0xFF8E2DE2),
  Color(0xFF4A00E0),
];
List<String> image = ["deepak.png", "awneet.png", "rahul.png"];
Route createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FAQPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOutQuad;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      });
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Developers",
          style: TextStyle(color: Colors.black, fontSize: 35.0),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 800),
              child: SlideAnimation(
                horizontalOffset: 90.0,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(createRoute());
                    },
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width / 10,
                      height: MediaQuery.of(context).size.height / 7,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: index < 3 ? colorsMentor : colorsStudent,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45,
                              blurRadius: 15.0,
                              offset: Offset.fromDirection(1.0, 10.0))
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: AssetImage(
                                      "assets/about/" + image[index],
                                    )),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0)),
                            height: MediaQuery.of(context).size.height / 7,
                            width: 100.0,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Team Member " + index.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              Text(
                                index < 3 ? "Mentor" : "Studet",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
