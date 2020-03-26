import 'package:covid19/familyRadio.dart';
import 'package:covid19/slefDeclaration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'globalVar.dart' as global;
import 'registerVariables.dart' as declaration;
import 'slefDeclaration.dart' as self;

class FamilyDeclaration extends StatefulWidget {
  @override
  _FamilyDeclarationState createState() => _FamilyDeclarationState();
}

List<String> eng = [
  "Family Members",
  "Member",
  "Adhaar No.",
  "Gender",
  "Are you Infected?",
  "Have Symptoms?",
  "Have Travelled?",
];
List<String> hin = [
  "यात्रा देश का चयन करें",
  "से",
  "तक",
  "अपना राज्य चुनें",
  "अपने जिले का चयन करें",
  "स्थान प्राप्त करें",
  "प्रस्तुत"
];
List<String> pun = [
  "ਯਾਤਰਾ ਦੇਸ਼ ਦੀ ਚੋਣ ਕਰੋ",
  "ਤੋਂ",
  "ਨੂੰ",
  "ਆਪਣੇ ਰਾਜ ਦੀ ਚੋਣ ਕਰੋ",
  "ਆਪਣੇ ਜ਼ਿਲ੍ਹੇ ਦੀ ਚੋਣ ਕਰੋ",
  "ਸਥਾਨ ਪ੍ਰਾਪਤ ਕਰੋ",
  "ਜਮ੍ਹਾਂ ਕਰੋ"
];
List<String> kan = [
  "ಪ್ರಯಾಣ ದೇಶವನ್ನು ಆಯ್ಕೆಮಾಡಿ",
  "ಇಂದ",
  "ಗೆ",
  "ನಿಮ್ಮ ರಾಜ್ಯವನ್ನು ಆಯ್ಕೆಮಾಡಿ",
  "ನಿಮ್ಮ ಜಿಲ್ಲೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ",
  "ಸ್ಥಳ ಪಡೆಯಿರಿ",
  "ಸಲ್ಲಿಸು"
];
List<String> mar = [
  "प्रवासी देश निवडा",
  "पासून",
  "ते",
  "आपले राज्य निवडा",
  "आपला जिल्हा निवडा",
  "स्थान मिळवा",
  "प्रस्तुत करणे"
];
List<String> odi = [
  "ଭ୍ରମଣକାରୀ ଦେଶ ଚୟନ କରନ୍ତୁ",
  "ରୁ",
  "to",
  "ଆପଣଙ୍କର ରାଜ୍ୟ ଚୟନ କରନ୍ତୁ",
  "ଆପଣଙ୍କର ଜିଲ୍ଲା ଚୟନ କରନ୍ତୁ",
  "ସ୍ଥାନ ପାଆନ୍ତୁ",
  "ଦାଖଲ"
];
List<String> tel = [
  "ప్రయాణించిన దేశాన్ని ఎంచుకోండి",
  "నుండి",
  "టు",
  "మీ రాష్ట్రాన్ని ఎంచుకోండి",
  "మీ జిల్లాను ఎంచుకోండి",
  "స్థానం పొందండి",
  "సమర్పించు"
];
List<String> tam = [
  "பயண நாட்டைத் தேர்ந்தெடுக்கவும்",
  "from",
  "to",
  "உங்கள் மாநிலத்தைத் தேர்ந்தெடுக்கவும்",
  "உங்கள் மாவட்டத்தைத் தேர்ந்தெடுக்கவும்",
  "இருப்பிடத்தைப் பெறு",
  "சமர்ப்பி"
];
List<String> uiVar = [];
void uiLang() {
  switch (global.lang) {
    case "hindi":
      {
        uiVar = hin;
        break;
      }
    case "english":
      {
        uiVar = eng;
        break;
      }
    case "odiya":
      {
        uiVar = odi;
        break;
      }
    case "marathi":
      {
        uiVar = mar;
        break;
      }
    case "tamil":
      {
        uiVar = tam;
        break;
      }
    case "telegu":
      {
        uiVar = tel;
        break;
      }
    case "kannada":
      {
        uiVar = kan;
        break;
      }
  }
}

TextEditingController nameEditor = new TextEditingController();
TextEditingController fnameEditor = new TextEditingController();
int members = 1;
double height = 20;

List<String> country = ["india", "china", "usa", "russia", "japan", "italy"];
String selectedDistrict;

class _FamilyDeclarationState extends State<FamilyDeclaration> {
  Widget travel(List<int> travelled, int i) {
    if (travelled[i] == 1) {
      return Text("");
    } else if (travelled[i] == 0) {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: DropdownButton(
              hint: Text("Select Travelled country",
                  style: TextStyle(color: Colors.black, fontSize: 15.0)),
              value: selectedDistrict,
              onChanged: (newValue) {
                setState(() {
                  selectedDistrict = newValue;
                });
              },
              items: country.map((location) {
                return DropdownMenuItem(
                  child:
                      new Text(location, style: TextStyle(color: Colors.black)),
                  value: location,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10.0),
                    ]),
                child: MaterialButton(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      borderRadius: 2,
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  child: Text("from"),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10.0),
                    ]),
                child: MaterialButton(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      borderRadius: 2,
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  child: Text("to"),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      );
    }
  }

  DateTime dateTime;
  Duration duration;
  @override
  void initState() {
    dateTime = DateTime.now();
    duration = Duration(minutes: 10);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Family Declaration",
          style: TextStyle(fontSize: 30.0),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xFF3180e4),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFF3180e4),
          Color(0xFF564dc2),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          children: <Widget>[
            Text(
              "Family Members",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50.0,
                  //padding: EdgeInsets.only(left: 10.0, right: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10.0),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("1"),
                      new Radio(
                          activeColor: Colors.black,
                          value: 1,
                          groupValue: members,
                          onChanged: (value) {
                            setState(() {
                              members = value;
                            });
                          }),
                      Text("2"),
                      new Radio(
                          activeColor: Colors.black,
                          value: 2,
                          groupValue: members,
                          onChanged: (value) {
                            setState(() {
                              members = value;
                            });
                          }),
                      Text("3"),
                      new Radio(
                          activeColor: Colors.black,
                          value: 3,
                          groupValue: members,
                          onChanged: (value) {
                            setState(() {
                              members = value;
                            });
                          }),
                      Text("4"),
                      new Radio(
                          activeColor: Colors.black,
                          value: 4,
                          groupValue: members,
                          onChanged: (value) {
                            setState(() {
                              members = value;
                            });
                          }),
                      Text("5"),
                      new Radio(
                          activeColor: Colors.black,
                          value: 5,
                          groupValue: members,
                          onChanged: (value) {
                            setState(() {
                              members = value;
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: members,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Member " + (index + 1).toString() + " name",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26, blurRadius: 10.0),
                            ]),
                        child: TextField(
                          controller: declaration.editor[index],
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Adhhar No.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26, blurRadius: 10.0),
                            ]),
                        child: TextField(
                          controller: declaration.editor[index],
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Gender",
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 10.0),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Male"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: 0,
                                    groupValue: declaration.gender[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.gender[index] = value;
                                      });
                                    }),
                                Text("Female"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: 1,
                                    groupValue: declaration.gender[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.gender[index] = value;
                                      });
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Are you infected?",
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 10.0),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Yes"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: 0,
                                    groupValue: declaration.gender[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.gender[index] = value;
                                      });
                                    }),
                                Text("No"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: 1,
                                    groupValue: declaration.gender[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.gender[index] = value;
                                      });
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Have Symptoms?",
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 10.0),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Yes"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: 0,
                                    groupValue: declaration.isInfected[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.isInfected[index] = value;
                                      });
                                    }),
                                Text("No"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: 1,
                                    groupValue: declaration.isInfected[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.isInfected[index] = value;
                                      });
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Have Travelled?",
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 10.0),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Yes"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: 0,
                                    groupValue:
                                        declaration.haveTravelled[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.haveTravelled[index] =
                                            value;
                                      });
                                    }),
                                Text("No"),
                                new Radio(
                                    activeColor: Colors.black,
                                    value: 1,
                                    groupValue:
                                        declaration.haveTravelled[index],
                                    onChanged: (value) {
                                      setState(() {
                                        declaration.haveTravelled[index] =
                                            value;
                                      });
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15.0),
                      travel(declaration.haveTravelled, index)
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
