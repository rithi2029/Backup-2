import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_view/gallery_view.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:ims/Invoice/singleinvoicelist.text';
import 'package:ims/LeadRegister/leadregister.dart';
import 'package:ims/Leaddetails/Leaddetails.dart';
import 'package:ims/Login/login.dart';
import 'package:ims/const/constant.dart';
import 'package:http/http.dart' as http;
import 'package:ims/leadedit/leadedit.dart';
import 'package:ims/onboardscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:intl/intl.dart';

class InvoiceScreen extends StatefulWidget {
  // var id;
  //@override
  //ProductimageScreen({this.id});
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  var leadresponse = [];
  var lead_source = [];
  var lead_accountindustries = [];

  String msg = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map _product_image = {};

  final formKey = GlobalKey<FormState>();
  var accesstoken;

  SharedPreferences sharedPreferences;

  Uint8List _bytesImage;

  Future a;
  initState() {
    a = invoicesList();

    super.initState();
  }

  _showDialog(BuildContext context, _leadlist) {
    print("_leadlist_leadlist" + _leadlist.toString() + _leadlist['name']);

    if (_leadlist['status'] == "0") {
      setState(() {
        _leadlist['status'] = "New";
      });
    } else if (_leadlist['status'] == "1") {
      setState(() {
        _leadlist['status'] = "Assigned";
      });
    } else if (_leadlist['status'] == "2") {
      setState(() {
        _leadlist['status'] = "In Process";
      });
    } else if (_leadlist['status'] == "3") {
      setState(() {
        _leadlist['status'] = "Converted";
      });
    } else if (_leadlist['status'] == "4") {
      setState(() {
        _leadlist['status'] = "Recycled";
      });
    } else if (_leadlist['status'] == "5") {
      setState(() {
        _leadlist['status'] = "Dead";
      });
    }
    if (_leadlist['industry'] == '1') {
      setState(() {
        _leadlist['industry'] = "Catering";
      });
    } else if (_leadlist['industry'] == '2') {
      setState(() {
        _leadlist['industry'] = "Events Management";
      });
    } else if (_leadlist['industry'] == '3') {
      setState(() {
        _leadlist['industry'] = "Information Technology";
      });
    }
    if (_leadlist['source'] == '1') {
      setState(() {
        _leadlist['source'] = "Referral";
      });
    } else if (_leadlist['source'] == '2') {
      setState(() {
        _leadlist['source'] = "Google 0r Yellow Pages";
      });
    } else if (_leadlist['source'] == '3') {
      setState(() {
        _leadlist['source'] = "Digital Marketting";
      });
    } else if (_leadlist['source'] == '4') {
      setState(() {
        _leadlist['source'] = "Zoho Lead";
      });
    }

    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new LeaddetailsScreen(
              _leadlist['name'],
              _leadlist['email'],
              _leadlist['phone'],
              _leadlist['title'],
              _leadlist['website'],
              _leadlist['lead_address'],
              _leadlist['lead_city'],
              _leadlist['lead_state'],
              _leadlist['lead_country'],
              _leadlist['status'],
              _leadlist['source'].toString(),
              _leadlist['opportunity_amount'].toString(),
              _leadlist['industry'],
              _leadlist['description'],
            )));
  }

  int dynamiccrosscount = 1;
  var _invoicelist = [];
  var contcolor = Colors.white;
  invoicesList() async {
    print("inside invoicesList");
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("access_token") ?? "_";
    print("accesstoken" + accesstoken);
    if (accesstoken == "_") {
      print("insode if no access token ");
    } else {
      print("inside else" + accesstoken);

      Uri url = Uri.parse(siteurl + "api/invoices");

      print(url);
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      });
      if (response.statusCode == 200) {
        setState(() {
          _invoicelist = json.decode(response.body);

          print(_invoicelist.toString());
          print(_invoicelist.length);
        });

        print("lead_accountindustries id is" + _invoicelist.toString());
        print(_invoicelist.toString());
        setState(() {});
        return _invoicelist;
      } else if (response.statusCode == 401) {
        sharedPreferences = await SharedPreferences.getInstance();
        accesstoken = sharedPreferences.setString("access_token", "_");

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
  //http://humbletree.in/lms/api/invoices
  // http://localhost:8888/lms/api/invoices

  allWordsCapitilize(String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth =
        screenSize.width / (2 / (screenSize.height / screenSize.width));
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(maincolor),
        leading: InkResponse(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("Invoice"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                //child: FutureBuilder(
                future: a,
                //  future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData == true
                      ? Container(
                          child: Column(
                            children: [
                              GridView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  //  padding: const EdgeInsets.all(10.0),
                                  scrollDirection: Axis.vertical,
                                  itemCount: _invoicelist.length,
                                  //  itemCount: data.length,
                                  gridDelegate:
                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: dynamiccrosscount,
                                    //  crossAxisCount: 2,
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .width /
                                        (MediaQuery.of(context).size.height /
                                            2.2),
                                    mainAxisSpacing: 10.0,

                                    crossAxisSpacing: 10.0,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Center(
                                      child: new GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Card(
                                            //  color: Color(crd_color),
                                            elevation: 6.0,
                                            child: GestureDetector(
                                              child: new Container(
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          3.0, 0.0, 0.0, 0.0),
                                                      child: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              child: Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      //  padding:  const EdgeInsets .all(  18.0),

                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          5.0,
                                                                          15.0,
                                                                          0.0,
                                                                          1.0),
                                                                      child:
                                                                          Center(
                                                                        child: Container(
                                                                            //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                                                                            child: Text(
                                                                          "Id : ",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                18.0,
                                                                          ),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      //  padding:  const EdgeInsets .all(  18.0),

                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          5.0,
                                                                          15.0,
                                                                          0.0,
                                                                          1.0),
                                                                      child:
                                                                          Center(
                                                                        child: Container(
                                                                            child: Text(
                                                                          "#INV0000" +
                                                                              "${_invoicelist[index]['id']}",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                18.0,
                                                                          ),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        5.0,
                                                                        18.0,
                                                                        0.0,
                                                                        1.0),
                                                                //  const EdgeInsets .all(  5.0),
                                                              ),
                                                            ),
                                                            // _invoicelist['status']
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          3.0, 0.0, 0.0, 0.0),
                                                      child: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              child: Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      //  padding:  const EdgeInsets .all(  18.0),

                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          5.0,
                                                                          15.0,
                                                                          0.0,
                                                                          1.0),
                                                                      child:
                                                                          Center(
                                                                        child: Container(
                                                                            //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),

                                                                            child: Text(
                                                                          "Name : ",
                                                                          //  "${_invoicelist[index]['name'][0]}".toUpperCase(),
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                18.0,
                                                                          ),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      //  padding:  const EdgeInsets .all(  18.0),

                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          5.0,
                                                                          18.0,
                                                                          0.0,
                                                                          10.0),
                                                                      child:
                                                                          Center(
                                                                        child: Container(
                                                                            child: Text(
                                                                          allWordsCapitilize(
                                                                            "${_invoicelist[index]['name']}",
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                18.0,
                                                                          ),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        5.0,
                                                                        18.0,
                                                                        0.0,
                                                                        1.0),
                                                                //  const EdgeInsets .all(  5.0),
                                                              ),
                                                            ),
                                                            // _invoicelist['status']
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          3.0, 0.0, 0.0, 0.0),
                                                      child: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              child: Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      //  padding:  const EdgeInsets .all(  18.0),

                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          5.0,
                                                                          15.0,
                                                                          0.0,
                                                                          1.0),
                                                                      child:
                                                                          Center(
                                                                        child: Container(
                                                                            //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                                                                            child: Text(
                                                                          "Status : ",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                18.0,
                                                                          ),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      //  padding:  const EdgeInsets .all(  18.0),

                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          5.0,
                                                                          15.0,
                                                                          0.0,
                                                                          1.0),
                                                                      child:
                                                                          Center(
                                                                        child: Container(
                                                                            child: Text(
                                                                          "${_invoicelist[index]['status']}",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                18.0,
                                                                          ),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        5.0,
                                                                        18.0,
                                                                        0.0,
                                                                        1.0),
                                                                //  const EdgeInsets .all(  5.0),
                                                              ),
                                                            ),
                                                            // _invoicelist['status']
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          3.0, 0.0, 0.0, 0.0),
                                                      child: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              child: Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      //  padding:  const EdgeInsets .all(  18.0),

                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          5.0,
                                                                          15.0,
                                                                          0.0,
                                                                          1.0),
                                                                      child:
                                                                          Center(
                                                                        child: Container(
                                                                            //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                                                                            child: Text(
                                                                          "Account : ",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                18.0,
                                                                          ),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      //  padding:  const EdgeInsets .all(  18.0),

                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          5.0,
                                                                          15.0,
                                                                          0.0,
                                                                          1.0),
                                                                      child:
                                                                          Center(
                                                                        child: Container(
                                                                            child: Text(
                                                                          "${_invoicelist[index]['account']}",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                18.0,
                                                                          ),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        5.0,
                                                                        18.0,
                                                                        0.0,
                                                                        1.0),
                                                                //  const EdgeInsets .all(  5.0),
                                                              ),
                                                            ),
                                                            // _invoicelist['status']
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          3.0, 0.0, 0.0, 0.0),
                                                      child: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              child: Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      //  padding:  const EdgeInsets .all(  18.0),

                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          5.0,
                                                                          15.0,
                                                                          0.0,
                                                                          1.0),
                                                                      child:
                                                                          Center(
                                                                        child: Container(
                                                                            //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                                                                            child: Text(
                                                                          "Amount : ",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                18.0,
                                                                          ),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      //  padding:  const EdgeInsets .all(  18.0),

                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          5.0,
                                                                          15.0,
                                                                          0.0,
                                                                          1.0),
                                                                      child:
                                                                          Center(
                                                                        child: Container(
                                                                            child: Text(
                                                                          "${_invoicelist[index]['amount']}",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                18.0,
                                                                          ),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        5.0,
                                                                        18.0,
                                                                        0.0,
                                                                        1.0),
                                                                //  const EdgeInsets .all(  5.0),
                                                              ),
                                                            ),
                                                            // _invoicelist['status']
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          3.0, 0.0, 0.0, 0.0),
                                                      child: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),

                                                              child: Container(
                                                                height: 40.0,
                                                                width: 100.0,
                                                                child: ElevatedButton(
                                                                    style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Color(maincolor))))),
                                                                    onPressed: () async {},
                                                                    child: Text(
                                                                      "Edit",
                                                                      style: TextStyle(
                                                                          // fontStyle: FontStyle.italic,
                                                                          color: Colors.white),
                                                                    )),
                                                              ),
                                                              // )
                                                            ),
                                                            // SizedBox(width: 2.0,),
                                                            Flexible(
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        40.0,
                                                                    width:
                                                                        100.0,
                                                                    //   color: Color(lightcolor),
                                                                    child: ElevatedButton(
                                                                        style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Color(maincolor))))),
                                                                        onPressed: () {
                                                                         /*  Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new SingleInvoicescreen(
         
            )));*/
                                                                         /* _showDialog(
                                                                              context,
                                                                              _invoicelist[index]);*/
                                                                        },
                                                                        child: Text(
                                                                          "View",
                                                                          style: TextStyle(
                                                                              // fontStyle: FontStyle.italic,
                                                                              color: Colors.white),
                                                                        )),
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 150.0,
                            ),
                            new Center(
                              child: new CircularProgressIndicator(),
                            ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
