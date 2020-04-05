import 'package:flutter/material.dart';

class hospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "कोविड-19",
      home: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFFFF9933),
                Color(0xFFFFFFFF),
                Color(0xFF138808),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Stack(
                children: <Widget>[
                  Container(
                      child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text("कोरोना को ठीक करने की सुविधा वाले अस्पताल की सूची",
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ],
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 120),
                    child: getListView(),
                  )
                ],
              ))),
    );
  }
}

List<String> getListElements() {
  var items = List<String>.generate(1000, (counter) => "Hospital $counter");
  return items;
}

Widget getListView() {
  var listItems = getListElements();

  var listView = ListView.builder(itemBuilder: (context, index) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Card(
          color: Color(0xFFecf0f1),
          elevation: 10.0,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.arrow_right),
                title: Text(listItems[index]),
                onTap: () {
                  print('${listItems[index]} was tapped');
                },
              )
            ],
          ),
        ));
  });

  return listView;
}
