import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sampleproject/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
    
  TextEditingController email = new TextEditingController();
  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  void usercreate() async {
    var url = "https://w3cert.net/outfit/index.php/api/v1/account";
    print(email.text);
    print(password.text);
    print(confirmpassword.text);
    print(firstname.text);
    print(lastname.text);
    final response = await http.post(url, body: {
      "email": email.text,
      "first_name": firstname.text,
      "last_name": lastname.text,
      "password": password.text,
      "confirm": confirmpassword.text
    });
    print('response.body' + response.body);
  }
  navigate() async {
      Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new Login(),
    ));
  }
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      Map<int, Color> color =
{
50:Color.fromRGBO(136,14,79, .1),
100:Color.fromRGBO(136,14,79, .2),
200:Color.fromRGBO(136,14,79, .3),
300:Color.fromRGBO(136,14,79, .4),
400:Color.fromRGBO(136,14,79, .5),
500:Color.fromRGBO(136,14,79, .6),
600:Color.fromRGBO(136,14,79, .7),
700:Color.fromRGBO(136,14,79, .8),
800:Color.fromRGBO(136,14,79, .9),
900:Color.fromRGBO(136,14,79, 1),
};
    MaterialColor colorCustom = MaterialColor(0xffF6846C, color);
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
                        "SignUp".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                  /*    SizedBox(
                        height: 50.0,
                      ),
                      Text("SignUp",textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,fontSize: 20.0),),
                                         SizedBox(
                        height: 50.0,
                      ),*/
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 300.0,
                          child: new TextFormField(
                            
                           validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter Name";
                              }
                            },
                            controller: firstname,
                            //  autofocus: true,
                            decoration: new InputDecoration(
                              icon: const Icon(Icons.supervised_user_circle),
                              labelText: "Enter First Name",
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
                                return "Please Enter Last Name";
                              }
                            },
                            controller: lastname,
                          //  autofocus: true,
                            decoration: new InputDecoration(
                              icon: const Icon(Icons.supervisor_account),
                              labelText: "Enter Last Name",
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
                            validator: validateEmail,
                           /* validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter Email";
                              }
                            },*/
                            controller: email,
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
                                return "Please Password";
                              }
                            },
                            controller: password,
                            //autofocus: true,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 300.0,
                          child: new TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please confirm password";
                              }
                              if (value != password.text)
                                return 'password Not Match';
                              return null;
                            },
                            controller: confirmpassword,
                            obscureText: true,
                           // autofocus: true,
                            decoration: new InputDecoration(
                              icon: const Icon(Icons.verified_user),
                              labelText: "Enter Confirm Password",
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
                            SizedBox(
                        width: 70.0,
                      ),
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
                                    usercreate();
                                  scaffoldkey.currentState.showSnackBar(SnackBar(
                                    content: Text("Account Created Sucessfully"),
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
                     "Sign Up",
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
                      FlatButton(
                            child: Text('Already registered click here to Login'),
                            shape: BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                            ),
                            onPressed: () {
                              navigate();
                            },
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
                            return "Please Enter Email";
                          }
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address';
    else
      return null;
  }
