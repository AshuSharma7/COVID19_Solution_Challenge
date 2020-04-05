import 'selfchecker2.dart';
import 'slefDeclaration.dart';
import 'package:flutter/material.dart';

class checker extends StatefulWidget {
  @override
  _checker createState() => _checker();
}

class _checker extends State<checker> {
  List<String> users = ["Hospital", "Citizen"];
  String text;
  String selectedUser;
  TextEditingController emailEditor = new TextEditingController();
  TextEditingController passEditor = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 60.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color(0xFF3180e4),
                    Color(0xFF564dc2),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  color: Colors.white,
                ),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                //alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          //padding: EdgeInsets.only(bottom: 100),
                          width: 300,
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 10.0,
                            color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 10.0, right: 10.0),
                              child: ListView(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "आत्म मूल्यांकन में आपका स्वागत है",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                    child: Text(
                                      "नमस्ते, मैं क्लारा हूं। आशा है, आप स्वस्थ हैं और कोरोना वायरस से प्रभावित नहीं हैं। फिर भी आपको जांचना होगा। मैं आपको कोरोना वायरस सेल्फ-चेकर के माध्यम से मार्गदर्शन करने के लिए हूं।\nयदि आप किसी जानलेवा आपातकाल का सामना कर रहे हैं, तो कृपया तुरंत 911 पर कॉल करें।\nयह प्रणाली स्वास्थ्य पेशेवरों के निर्णय या किसी नैदानिक मूल्यांकन के प्रदर्शन को प्रतिस्थापित नहीं करती है।\nदेखभाल के सही स्तर पर जानकारी प्रदान करने के लिए, हम आपसे कई प्रश्न पूछने जा रहे हैं।\nआप तैयार हैं? आएँ शुरू करें।",
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 22,
                      ),
                      Center(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Color(0xFF426bd7),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 10.0)
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => selfcheck2()));
                                },
                                child: Text(
                                  "आगे  >>>",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class selfcheck2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("कोरोना के खिलाफ भारत की लड़ाई")),
        body: checker2());
  }
}
