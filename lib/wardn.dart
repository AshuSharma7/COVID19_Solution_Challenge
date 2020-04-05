import 'grid.dart';
import 'package:flutter/material.dart';

class warn extends StatefulWidget {
  @override
  _warn createState() => _warn();
}

class _warn extends State<warn> {
  int _radioValue, _radioValue2;

  void _handleRadio(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  void _handleRadio2(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  List<String> users = ["Hospital", "Citizen"];
  String text;

  String selectedUser;
  TextEditingController emailEditor = new TextEditingController();
  TextEditingController passEditor = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFFFF9933),
        Color(0xFFFFFFFF),
        Color(0xFF138808),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height / 12),
                Text(
                  "आपको कोरोना वायरस के उचित लक्षण नहीं हैं लेकिन कुछ एहतियात बरतने चाहिए जो इस प्रकार हैं:",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                Text(
                  "1.अपनी आंखों, नाक और मुंह को छूने से बचें।",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                Text(
                  "2.बीमार होने पर घर पर रहें",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                Text(
                  "3.कम से कम 20 सेकंड के लिए अपने हाथों को अक्सर साबुन और पानी से धोएं, खासकर बाथरूम जाने से पहले, खाने से पहले, और अपनी नाक बहने के बाद, खांसने या छींकने से।",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                Text(
                  "4.यदि आपको बुखार, खांसी और सांस लेने में कठिनाई है, तो तुरंत चिकित्सा की तलाश करें।",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                Text(
                  "5.एक नियमित रूप से घरेलू सफाई स्प्रे या पोंछे का उपयोग करके अक्सर छुआ-छूत वाली वस्तुओं और सतहों को साफ और कीटाणुरहित करें।",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                Text(
                  "6.यदि साबुन और पानी आसानी से उपलब्ध नहीं हैं, तो कम से कम 60% अल्कोहल के साथ अल्कोहल-आधारित हैंड सैनिटाइज़र का उपयोग करें।",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 200.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF426bd7),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10.0)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DashBoard()));
                    },
                    child: Text(
                      "मुख्य मेनू पर जाएं >>>",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
