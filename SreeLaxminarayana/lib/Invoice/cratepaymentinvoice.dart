import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ims/Login/login.dart';
import 'package:ims/const/constant.dart';
import 'package:ims/leadlisting/leadlist.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Createpayment extends StatefulWidget {
//  const ({ Key? key }) : super(key: key);

  @override
  _CreatepaymentState createState() => _CreatepaymentState();
}

class _CreatepaymentState extends State<Createpayment> {
  //address
  var leadresponse = [];
  String msg = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var lead_source = [];

  var lead_status = [];
  var lead_accountindustries = [];
  //var lead_setting =[];
  Map lead_setting = {};
  bool displaynotes = false;
  TextEditingController amount = TextEditingController();
  TextEditingController payment_id = TextEditingController();
  TextEditingController dateCtl = TextEditingController();

  TextEditingController notes = TextEditingController();
  var accesstoken ="";
  var _paymentid =[];
  var id;
    initState() {
     getpaymentid();

    super.initState();
  }
    var selectedpaymenttype = "Cash";
  var response;
  getpaymentid() async {

    //http://humbletree.in/sales/api/paymentmethods
       print("inside  getpaymentid()");
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("access_token") ?? "_";
    print("accesstoken" + accesstoken);
    if (accesstoken == "_") {
      print("insode if no access token ");
    } else {
      print("inside else" + accesstoken);

      Uri url = Uri.parse(siteurl + "api/paymentmethods");

      print(url);
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      });
      if (response.statusCode == 200) {
        setState(() {
          _paymentid = json.decode(response.body);

          print("_paymentid[0]['id']"+_paymentid[0]['name'].toString());
          print(_paymentid.length);
        }); 

         setState(() {
             radioItemHolder = _paymentid[0]["name"];
         });
        return _paymentid;
      } else if (response.statusCode == 401) {
        sharedPreferences = await SharedPreferences.getInstance();
        accesstoken = sharedPreferences.setString("access_token", "_") as String;

        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new Loginscreen()));
      } else {
        print(response.body.toString());

        print(response.statusCode.toString());
        print(json.decode(response.body).toString());
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    }

  }
  navigatetoleadlist(){
     Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new LeadlistScreen(),
            ));
  }
   SharedPreferences sharedPreferences;
     String radioItemHolder = "";

_createpayment() async {
  print("Hii inside Create_payment");
 // 'http://localhost:8888/lms/api/invoicepayments/create/1' 
 
   Uri url = Uri.parse(siteurl + "api/invoicepayments/create/1");
     sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("access_token") ?? "_";
    print("accesstoken" + accesstoken);

    print("url&accesstoekn" + url.toString() + '$accesstoken'.toString());
   var response = await http.post(url, headers: {
      'Authorization': 'Bearer $accesstoken',
    },
        body: {
          "amount": amount.text.toString(),  
           "date":dateCtl.text.toString(),
           "payment_id":payment_id.text.toString(),
           "notes":notes.text.toString()
        });
    print("responseeee");
    print(response.body.toString());
    print(response.statusCode);

    if (response.statusCode == 201) {
      print('response.body:' + response.body.toString());
      
      setState(() {
            //  _leadlist.add(json.decode(response.body));
var resBody = json.decode(response.body);
  
        //   leadresponse = json.decode(response.body);
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Payment created Sucessfully"),
          backgroundColor: Color(maincolor),
        ));
        navigatetoleadlist();
        
      });

      print("create sucessfully");
    } else {
      print(response.statusCode);

      setState(() {
        // leadresponse = json.decode(response.body);
        print("leadresponse" + response.body.toString());
        var leadresponse1 = json.decode(response.body);
        print("leadresponse1" + leadresponse1.toString());
        msg = leadresponse1.toString();
        setState(() {
          //   leadresponse = json.decode(response.body);
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Color(maincolor),
            content: Text(msg.toString()),
          ));
        });
      });
    }     
}
 
  final formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Color(maincolor),
        leading: InkResponse(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new LeadlistScreen(),
            ));
            //     Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("Create Payment"),
      ),
      body: Form(
        key: formKey,
        child: WillPopScope(
          //   onWillPop: () async => false,
          onWillPop: () {
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new LeadlistScreen(),
            ));
          },
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter amount";
                              }
                            },
                            //  validator: validateEmail,
                            controller: amount,
                            //  autofocus:true,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              //   labelText: "Email",
                              hintText: "Amount",
                              border: InputBorder.none,
                              fillColor: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ),
                /*  SizedBox(
                  height: 5.0,
                ),*/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.grey[200],
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: new InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
         labelText: "Date of Pay",
        contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        ),
  
                            controller: dateCtl,
                          
                            onTap: () async {
                              DateTime date = DateTime(1900);
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());

                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime.now());
                                  //DateTime(2100));
                              String formatted = formatter.format(date);
                              print(formatted); // something like 2013-04-20

                              dateCtl.text = formatted;
                            },
                          )
                          /* TextFormField(
                            /* validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter email";
                              }
                            },*/
                            validator: (value) {
                              if (lead_setting['email'] == 1) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value)) {
                                  return 'Enter Valid Email';
                                } else {
                                  return null;
                                }

                                //  ValidateEmail();
                              } else if (lead_setting['email'] == 0) {
                                if (value.isEmpty) {
                                  return "";
                                }
                              }
                            },
                            // validator: validateEmail,
                            controller: email,
                            //  autofocus:true,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              //   labelText: "Email",
                              hintText: "Email",
                              border: InputBorder.none,
                              fillColor: Colors.white,
                            )),
                      */
                          ),
                    ),
                  ),
                ),
                Text("Select the Payment Method"),
                       ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                // itemCount: data.length,
                                itemCount: _paymentid.length,
                                //  itemCount : data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      RadioListTile(
                                        activeColor: Color(maincolor),
                                        //   title: Text("${data[index]["title"]}"),
                                        title: Text(_paymentid[index]['name']
                                            .toString()),
                                        //  title: Text(activepaymentlist.toString()),

                                        groupValue: radioItemHolder,
                                        //   value: data[index]["title"],
                                        value: _paymentid[index]['id'].toString(),

                                        onChanged: (val) {
       
                                          setState(() {
                                            selectedpaymenttype = val;
                                            radioItemHolder = val;
                                            //  radioItemHolder = data[index]["title"] ;
                                            payment_id.text = _paymentid[index]["id"].toString();
                                          });
                                        },
                                      )
                                    ],
                                  );
                                }),
                            
                /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                           validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter Payment id";
                              }
                            },
                           
                               
                            
                            controller: payment_id,
//                              minLines: 10,
                         
                            decoration: InputDecoration(
                              //   labelText: "Email",
                              labelText: 'Payment Id',
                              hintText: "Payment Id",
                              border: InputBorder.none,
                              fillColor: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ),
               */
                Visibility(
                  //       visible: displaynotes,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              validator: (value) {
                               
                                  if (value.isEmpty) {
                                    return "Please enter notes";
                                  }
                               
                              },
                              maxLines: 5,
                              controller: notes,
                              //  autofocus:true,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: 'Notes',
                                hintText: "Notes",
                                border: InputBorder.none,
                                fillColor: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      width: 150.0,
                      height: 50.0,
                      color: Color(maincolor),
                      child: TextButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            _createpayment();
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              backgroundColor: Color(maincolor),
                              content: Text("Payment creation in progress"),

                            ));
                          } else {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              backgroundColor: Color(maincolor),
                              content: Text("One or more fields are empty"),
                            ));
                          }
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            width: 200.0,
                            constraints: BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Submit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        /*  Text("Sign in",
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 20.0,
                   fontWeight: FontWeight.bold,
                 ),
               ),*/
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
