import 'package:flutter/material.dart';
import 'package:flutter_localization_master/pages/chatBot.dart';
import 'package:flutter_localization_master/pages/newDeclaration.dart';
import 'package:flutter_localization_master/pages/newsapi.dart';
import 'package:flutter_localization_master/pages/quizPage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class BottomnavBar extends StatefulWidget {
  @override
  _BottomnavBarState createState() => _BottomnavBarState();
}

class _BottomnavBarState extends State<BottomnavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Quiz(),
    NewsApi(),
    ChatBot(),
    SelectMembers(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.grey[800],
                tabs: [
                  GButton(
                    icon: LineIcons.graduation_cap,
                    text: 'Quiz',
                  ),
                  GButton(
                    icon: LineIcons.newspaper_o,
                    text: 'News',
                  ),
                  GButton(
                    icon: LineIcons.comment,
                    text: 'ChatBot',
                  ),
                  GButton(
                    icon: LineIcons.home,
                    text: 'DashBoard',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
