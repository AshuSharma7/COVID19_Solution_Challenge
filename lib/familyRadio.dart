import 'package:covid19/familyDeclaration.dart';
import 'package:flutter/material.dart';
import 'globalVar.dart' as global;

class FamilyRadio extends StatefulWidget {
  @override
  _FamilyRadioState createState() => _FamilyRadioState();
}

class _FamilyRadioState extends State<FamilyRadio> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          "Declaration Type",
          style: TextStyle(color: Colors.white),
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 10.0),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Individual"),
              new Radio(
                  activeColor: Colors.black,
                  value: 0,
                  groupValue: global.flag,
                  onChanged: (value) {
                    setState(() {
                      global.flag = value;
                    });
                  }),
              Text("Family"),
              new Radio(
                  activeColor: Colors.black,
                  value: 1,
                  groupValue: global.flag,
                  onChanged: (value) {
                    setState(() {
                      global.flag = value;
                    });
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
