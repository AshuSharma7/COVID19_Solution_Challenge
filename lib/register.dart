import 'dart:io';

import 'package:covid19/advisoryUpdate.dart';
import 'package:covid19/familyDeclaration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

TextEditingController nameEditor = new TextEditingController();
TextEditingController passEditor = new TextEditingController();
TextEditingController adhharEditor = new TextEditingController();

class RegisterPage extends StatelessWidget {
  Future<Response> makePost() async {
    String url = "https://covid-mitrc.herokuapp.com/accounts/register";
    var body = {
      "username": adhharEditor.text,
      "first_name": nameEditor.text,
      "password": passEditor.text,
    };
    Response r = await post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    return r;
  }

  Future<List<dynamic>> getUri() async {
    String url = "https://covid-mitrc.herokuapp.com/accounts/";
    Response response = await get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  //color: Colors.white
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/fightindia.jpg")),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    //alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(top: 200),
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                              //padding: EdgeInsets.only(bottom: 100),
                              width: 300,
                              height: MediaQuery.of(context).size.height / 2,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 10.0,
                                color: Colors.white,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: ListView(
                                    children: <Widget>[
                                      Center(
                                        child: Text(
                                          "REGISTER",
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "First Name",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0),
                                          )),
                                      TextFormField(
                                        obscureText: false,
                                        controller: nameEditor,
                                        decoration: InputDecoration(
                                          fillColor: Colors.red,
                                        ),
                                      ),
                                      //     )),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Adhhar No.",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0),
                                          )),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        maxLength: 12,
                                        obscureText: false,
                                        controller: adhharEditor,
                                        decoration: InputDecoration(),
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Password",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0),
                                          )),
                                      TextFormField(
                                        obscureText: true,
                                        controller: passEditor,
                                        decoration: InputDecoration(
                                          fillColor: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),

                                      SizedBox(
                                        height: 30.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 320.0),
                              child: Column(
                                children: <Widget>[
                                  FutureBuilder(
                                      future: getUri(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        List content = snapshot.data;
                                        return Container(
                                          width: 200.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF426bd7),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 10.0)
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          child: MaterialButton(
                                            onPressed: () async {
                                              if (adhharEditor.text != "" &&
                                                  passEditor.text != "" &&
                                                  nameEditor.text != "") {
                                                bool adhharExists = false;
                                                for (int i = 0;
                                                    i < content.length;
                                                    i++) {
                                                  if (content[i]["username"] ==
                                                      adhharEditor.text) {
                                                    adhharExists = true;
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "Adhhar No. exists!"),
                                                          content: Text(
                                                              "this adhhar no. is already registered"),
                                                          actions: <Widget>[
                                                            IconButton(
                                                                icon: Icon(
                                                                    Icons.done),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                })
                                                          ],
                                                        );
                                                      },
                                                    );
                                                    break;
                                                  }
                                                }
                                                if (adhharExists == false) {
                                                  if (adhharEditor
                                                          .text.length ==
                                                      1) {
                                                    Response response =
                                                        await makePost();
                                                    if (response.statusCode ==
                                                        201) {
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      prefs.setString('aadhar',
                                                          adhharEditor.text);
                                                      makePost();
                                                      adhharEditor.clear();
                                                      nameEditor.clear();
                                                      passEditor.clear();
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FamilyDeclaration()),
                                                          (route) => false);
                                                    } else {
                                                      return showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title:
                                                                Text("Error"),
                                                            content: Text(
                                                                "Check Your Internet Connection"),
                                                            actions: <Widget>[
                                                              IconButton(
                                                                  icon: Icon(
                                                                      Icons
                                                                          .done),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  })
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                  } else {
                                                    return showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text("Error"),
                                                          content: Text(
                                                              "Please Type valid Adhhar No."),
                                                          actions: <Widget>[
                                                            IconButton(
                                                                icon: Icon(
                                                                    Icons.done),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                })
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                }
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title:
                                                            Text("Empty Field"),
                                                        content: Text(
                                                            "Either one or More Fields are empty"),
                                                        actions: <Widget>[
                                                          IconButton(
                                                              icon: Icon(
                                                                  Icons.done),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        ],
                                                      );
                                                    });
                                              }
                                            },
                                            child: Text(
                                              "Register",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      }),
                                  SizedBox(height: 20.0),
                                  Text("Already Have an Account?  Login")
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
