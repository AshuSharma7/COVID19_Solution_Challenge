import 'package:flutter/cupertino.dart';
import 'package:flutter_localization_master/pages/LanguagePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization_master/pages/userCheck.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_icons/line_icons.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

List<Color> colorsMentor = [Color(0xFFFF5F6D), Color(0xFFFFC371)];
List<Color> colorsStudent = [
  Color(0xFF5B86E5),
  Color(0xFF36D1DC),
];
List<String> image = [
  "https://imgur.com/download/anBYcdR",
  "https://imgur.com/download/Vh3S6Vh",
  "https://imgur.com/download/ranpvpF",
  "https://imgur.com/download/moWLJdf",
  "https://imgur.com/download/A8hyt9a",
  "https://imgur.com/download/pHP8MLV",
  "https://imgur.com/download/jGRwI9T",
  "https://imgur.com/download/NJgpYrS",
  "https://imgur.com/download/n8FBNnu"
];
List<String> name = [
  "Deepak Sharma",
  "Awneet",
  "Rahul Shandilya",
  "Minakshi",
  "Gaurav Saini",
  "Sanchit Mangal",
  "Ashu Sharma",
  "Deepanshu Chauhan",
  "Devesh Sharma"
];
Route createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LanguagePage(),
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
        automaticallyImplyLeading: false,
        title: Text(
          "About Developers",
          style: TextStyle(color: Colors.black, fontSize: 30.0),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                LineIcons.power_off,
                color: Colors.black,
              ),
              onPressed: () {
                auth.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => CheckUser()),
                    (_) => false);
              })
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: name.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width / 10,
                      height: MediaQuery.of(context).size.height / 7,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: index < 4 ? colorsMentor : colorsStudent,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                              color: index < 4
                                  ? Colors.deepOrange[100]
                                  : Colors.blue[100],
                              blurRadius: 13.0,
                              offset: Offset.fromDirection(4.0, -10.0))
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      image[index],
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
                                name[index],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              Text(
                                index < 4 ? "Mentor" : "Student",
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
