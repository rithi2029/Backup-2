import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sampleproject/authcart.dart';
import 'package:sampleproject/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  String msg = '';
  var accesstoken, cart_id;
  SharedPreferences sharedPreferences;
  void addcartmerge(accesstoken) async {
    print("inside addcartmerge(accesstoken) ");
    print("accesstoken"+accesstoken.toString());
   
    sharedPreferences = await SharedPreferences.getInstance();
    cart_id = sharedPreferences.getString("cartid").toString();
     print("cart_id"+cart_id.toString());
    var url = "https://w3cert.net/outfit/index.php/api/v1/cartmerge";

    final response = await http.post(url, body: {
      "access_token": accesstoken.toString(),
      "cart_id": cart_id.toString()
    });
    print('response.body of addcartmerge' + response.body);
     sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("accesstoken", accesstoken.toString());
      print(sharedPreferences.getString("accesstoken").toString());
    });

    navigate();
  }
  navigate() async {
      Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new AuthCart(),
    ));
  }
  void validateuser() async {
    print("inside validate user");
    var url = "https://w3cert.net/outfit/index.php/api/v1/oauth/access_token";
    print(email.text);
    print(password.text);

    final response = await http.post(url, body: {
      "username": email.text,
      "password": password.text,
      "grant_type": "password",
      "client_id": "Outfit1548925669",
      "client_secret": "a10620c85033ab02b582d17716cda245"
    });
    print(response.body);
    var datauser = json.decode(response.body);
    print(datauser.length);
    if (datauser.length == 2) {
      setState(() {
        msg = "Incorrect Username or Password";
      });
    } else {
      setState(() {
        print(datauser['access_token']);
        accesstoken = datauser['access_token'];
        addcartmerge(accesstoken);
      /*  if (datauser['access_token'] != null) {
          print("accesstoken");
          print(datauser['access_token']);
        } else {
          print("accesstoken");
        }*/
      });
    }
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
     resizeToAvoidBottomInset: false,
     // resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                    /*  SizedBox(
                        height: 50.0,
                      ),*/
                      Image.asset('assets/img/logo.png',height: 150.0,width: 150.0,),
                      
                      Text(
                        "SignIn".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 300.0,
                          child: new TextFormField(
                             validator: validateEmail,
                            /*validator: (value) {

                              if (value.isEmpty) {
                                return "Please enter Email";
                              }
                              
                            },*/
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            // autofocus: true,
                            decoration: new InputDecoration(
                              icon: const Icon(Icons.email),
                              labelText: "Enter Email",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 300.0,
                          child: new TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter Password";
                              }
                            },
                            controller: password,
                            //  autofocus: true,
                            obscureText: true,
                            decoration: new InputDecoration(
                              icon: const Icon(Icons.lock),
                              labelText: "Enter Password",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                                Row(
                        children: [
                             SizedBox(width: 70.0,),
                          Center(
                            child: Container(
                           //   color: Color(0xffF6846C),
                              //  Color: Color(0xffF6846C),
                              alignment: Alignment.center,
             height: 50.0,
          //   width: 400.0,
           
margin: EdgeInsets.all(10),
             child: RaisedButton(
                 onPressed: () {
                                
                                if (formKey.currentState.validate()) {
                                validateuser();
                                scaffoldkey.currentState.showSnackBar(SnackBar(
                                  content: Text("Login Sucessfully"),
                                ));
                              } else {
                                scaffoldkey.currentState.showSnackBar(SnackBar(
                                  content:
                                      Text("Failed to Created Sucessfully"),
                                ));
                              }
                              },
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(50.0)),
               padding: EdgeInsets.all(0.0),
               child: Ink(
                 decoration: BoxDecoration(
                     gradient: LinearGradient(
                              // colors:colorCustom,
                               colors: [Color(0xffF6846C), Color(0xffF6846C)],
                               begin: Alignment.centerLeft,
                               end: Alignment.centerRight,
                     ),
                     borderRadius: BorderRadius.circular(30.0)),
                 child: Container(
                     width: 200.0,
                   constraints:
                               BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                   alignment: Alignment.center,
                   child: Text(
                     "Sign In",
                     textAlign: TextAlign.center,
                     style: TextStyle(color: Colors.white, fontSize: 15),
                   ),
                 ),
               ),
               
             ),
           ),
                          ),
                        ],
                      ),
                     /* ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: Text('CANCEL'),
                            shape: BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                            ),
                            onPressed: () {
                              email.clear();
                              password.clear();
                            },
                          ),
                          RaisedButton(
                            child: Text('SignIn'),
                            color: Colors.blueAccent,
                            shape: BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                            ),
                            onPressed: () {
                              
                              if (formKey.currentState.validate()) {
                                validateuser();
                                scaffoldkey.currentState.showSnackBar(SnackBar(
                                  content: Text("Login Sucessfully"),
                                ));
                              } else {
                                scaffoldkey.currentState.showSnackBar(SnackBar(
                                  content:
                                      Text("Failed to Created Sucessfully"),
                                ));
                              }
                            },
                          ),
                      
                        ],
                      ),*/
                          Center(
                              child: Text(
                            msg,
                            style: TextStyle(fontSize: 16.0, color: Colors.red),
                          )),
                          SizedBox(height: 10.0,),
                           Row(
                               children: [
                                     SizedBox(width: 70.0,),
                                 Center(
                                   child: FlatButton(
                                   
                          child: Text( "Not Register? Create an account",
                                    style: TextStyle(fontSize: 13.0, color: Colors.black),
                          ), onPressed: () {
                                      Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new Register(),
    ));
                                    },),
                                 ),
                               ],
                             ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
       if (value.isEmpty) {
                            return "Please enter Email";
                          }
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address';
    else
      return null;
  }