import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization_master/pages/coronaMonitor.dart';
import 'dart:convert';
import 'package:flutter_localization_master/pages/userrequire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottomNavBar.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}
final database = FirebaseDatabase.instance.reference();
List<bool> check = [false, false, false];
List<Color> sweet = [Color(0xFFFF5F6D), Color(0xFFFFC371)];
List<Color> blue = [Color(0xFF36D1DC), Color(0xFF5B86E5)];
final FirebaseAuth auth = FirebaseAuth.instance;
List<String> users = ["Hospital", "Citizen"];
String selectedUser;
TextEditingController passEditor = new TextEditingController();
TextEditingController phoneEditor = new TextEditingController();
bool submit = false;
bool _check = false, _check2 = false, _check3 = false;

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Login",
            style: TextStyle(fontSize: 30.0, color: Colors.black),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: Colors.white,
            child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 20),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            check[0] = true;
                            check[1] = false;
                            check[2] = false;
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Container(
                                decoration: check[0] == true
                                    ? BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 18.0,
                                              spreadRadius: 0.1,
                                              offset: Offset.fromDirection(
                                                  4.5, -10.0))
                                        ],
                                      )
                                    : BoxDecoration(),
                                height: 120,
                                width: 120,
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/citizenlogo.png'))))),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            check[0] = false;
                            check[1] = true;
                            check[2] = false;
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Container(
                                decoration: check[1] == true
                                    ? BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 18.0,
                                              spreadRadius: 0.1,
                                              offset: Offset.fromDirection(
                                                  4.5, -10.0))
                                        ],
                                      )
                                    : BoxDecoration(),
                                height: 120,
                                width: 120,
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/farmerlogo.png'),
                                  width: 40.0,
                                )))),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        check[0] = false;
                        check[1] = false;
                        check[2] = true;
                      });
                    },
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                            decoration: check[2] == true
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 18.0,
                                          spreadRadius: 0.1,
                                          offset:
                                              Offset.fromDirection(4.5, -10.0))
                                    ],
                                  )
                                : BoxDecoration(),
                            height: 120,
                            width: 120,
                            child: Image(
                                image: AssetImage(
                                    'assets/images/frontlinelogo.png'),
                                width: 40.0)))),
                Center(
                    child: Text(
                  (check[0] == false && check[1] == false && check[2] == false)
                      ? "Please Select Catagory"
                      : (check[0] == true
                          ? "Citizen Category"
                          : (check[1] == true
                              ? "Farmer Category"
                              : (check[2] == true
                                  ? "Hospital Category"
                                  : "Please Select Category"))),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
                SizedBox(height: 50),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        gradient: LinearGradient(
                            colors: sweet,
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.deepOrange[300],
                              blurRadius: 20.0,
                              offset: Offset.fromDirection(4.0, -10.0))
                        ],
                      ),
                      child: TextFormField(
                          controller: phoneEditor,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            prefixIcon: Icon(Icons.phone),
                            hintText: "Enter Your Phone Number",
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),
                          )),
                    )),
                SizedBox(height: 40),
                Container(
                    width: 100,
                    height: 50.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF1488CC), Color(0xFF2B32B2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue[300],
                            blurRadius: 15.0,
                            offset: Offset.fromDirection(4.5, -5.0))
                      ],
                    ),
                    child: Center(
                        child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: submit == true ? () {
                            Fluttertoast.showToast(msg: "Please Wait");
                          } : () {
                            if (phoneEditor.text != "") {
                              setState(() {
                                submit = true;
                              });
                              auth.verifyPhoneNumber(
                                  phoneNumber: "+91" + phoneEditor.text,
                                  timeout: Duration(seconds: 5),
                                  verificationCompleted: (authCredential) =>
                                      verifyComplete(authCredential, context),
                                  verificationFailed:
                                      (AuthException authException) =>
                                          verificationFailed(
                                              authException, context),
                                  codeSent: (verificationId, [code]) =>
                                      smsSent(verificationId, [code], context),
                                  codeAutoRetrievalTimeout: (verificationId) =>
                                      Fluttertoast.showToast(
                                          msg: "Enter Code Manually"));
                                          phoneEditor.clear();
                            } else {
                              return showDialog(
                                  context: (context),
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Failed",
                                        // getTranslated(
                                        //     context, 'failed'),
                                      ),
                                      content:
                                          Text("Please Enter Phone no."
                                              // getTranslated(
                                              //     context, 'one_or_more'),
                                              ),
                                      actions: <Widget>[
                                        IconButton(
                                            icon: Icon(Icons.done),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            })
                                      ],
                                    );
                                  });
                            }
                          },
                          child: submit == true ? CircularProgressIndicator() : Text("Next",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ))),
                    ))),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "No Account?\t",
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: Text("SignUp",
                            style: TextStyle(color: Colors.blue)))
                  ],
                )
              ],
            ),
          ],
        )));
  }
}

verifyComplete(AuthCredential authCredential, BuildContext context) async {
  auth
      .signInWithCredential(authCredential)
      .then((value) {
      database.child(value.user.uid).once().then((snapshot){
        if(snapshot.value == null) {
          database.child(value.user.uid).set({
            "declaration": false,
            "latitude": 0.0,
            "longitude": 0.0
          });
           Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => CoronaMonitor()),
      (route) => false);
        } else {
          database.child(value.user.uid).once().then((snapshot){
            if(snapshot.value["declaration"] == true) {
              Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => BottomnavBar()),
      (route) => false);
            } else {
              Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => CoronaMonitor()),
      (route) => false);
            }
          });
          
        }
      });
}
      );}

String otpCode;
smsSent(String verificationId, List<int> code, BuildContext context) {
  otpCode = verificationId;
  submit = false;
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => verifyPage(otpCode, context)));
}
bool otpSubmit = false;
verificationFailed(AuthException authException, BuildContext context) {
  Fluttertoast.showToast(msg: authException.message);
}

void codeVerify(String otp, String sms, BuildContext context) async {
  try {
    final AuthCredential credential =
        PhoneAuthProvider.getCredential(verificationId: otp, smsCode: sms);
    auth
        .signInWithCredential(credential)
        .then((value){
          database.child(value.user.uid).once().then((snapshot){
        if(snapshot.value == null) {
          database.child(value.user.uid).set({
            "declaration": false,
            "latitude": 0.0,
            "longitude": 0.0
          });
           Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => CoronaMonitor()),
      (route) => false);
        } else {
          database.child(value.user.uid).once().then((snapshot){
            if(snapshot.value["declaration"] == true) {
              Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => BottomnavBar()),
      (route) => false);
            } else {
              Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => CoronaMonitor()),
      (route) => false);
            }
          });
          
        }
      });
        });
  } catch (e) {
    otpSubmit = false;
    Fluttertoast.showToast(msg: "Error Please Try Again");
  }
}
TextEditingController sms = new TextEditingController();
Widget verifyPage(String otp, BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        "Verification",
        style: TextStyle(fontSize: 30.0, color: Colors.black),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
    ),
    body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
          child: SingleChildScrollView(
                      child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/images/Authentication.png"),
                    width: 200,
                  ),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    child: Center(
                      child: Text(
                        "Please wait or Enter OTP manually",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      gradient: LinearGradient(
                          colors: color4,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue[400],
                            blurRadius: 20.0,
                            offset: Offset.fromDirection(4.0, -10.0))
                      ],
                    ),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: sms,
                        maxLength: 6,
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white60, fontSize: 30.0),
                        decoration: InputDecoration(
                            hintText: "Enter OTP",
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                            ),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            labelStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: otpSubmit == true ? () { Fluttertoast.showToast(msg: "Please wait");} : () {
                      if (sms.text.length == 6) {
                        Fluttertoast.showToast(msg: "Please wait");
                        otpSubmit = true;
                        codeVerify(otp, sms.text, context);
                        sms.clear();
                      } else {
                        Fluttertoast.showToast(msg: "Please Enter otp");
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 50.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF1488CC), Color(0xFF2B32B2)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue[800],
                              blurRadius: 20.0,
                              offset: Offset.fromDirection(4.5, -10.0))
                        ],
                      ),
                      child: Center(
                        child: Text("Submit",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80.0,
                  )
                ],
              ),
            ),
          ),
      
      ),
    ),
  );
}
