import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_view/gallery_view.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ims/Invoice/singleinvoicelist.dart';
import 'package:ims/LeadRegister/leadregister.dart';
import 'package:ims/Leaddetails/Leaddetails.dart';
import 'package:ims/Login/login.dart';
import 'package:ims/const/constant.dart';
import 'package:http/http.dart' as http;
import 'package:ims/leadedit/leadedit.dart';
import 'package:ims/onboardscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:intl/intl.dart';

class QuotesScreen extends StatefulWidget {
  // var id;
  //@override
  //ProductimageScreen({this.id});
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
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
    a = quotesList();

    super.initState();
  }

   int dynamiccrosscount = 1;
  var _quoteslist = [];
  var contcolor = Colors.white;
  quotesList() async {
    print("inside invoicesList");
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("access_token") ?? "_";
    print("accesstoken" + accesstoken);
    if (accesstoken == "_") {
      print("insode if no access token ");
    } else {
      print("inside else" + accesstoken);

      Uri url = Uri.parse(siteurl + "api/quotes");

      print(url);
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      });
      if (response.statusCode == 200) {
        setState(() {
          _quoteslist = json.decode(response.body);

          print(_quoteslist.toString());
          print(_quoteslist.length);
        });

        print("lead_accountindustries id is" + _quoteslist.toString());
        print(_quoteslist.toString());
        setState(() {});
        return _quoteslist;
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
  /*Widget build(BuildContext context) {

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
        title: Text("Quote"),
      ),
      body: Form(
        key: formKey,
        child: FutureBuilder(
          //child: FutureBuilder(
          future: a,
              builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData == true
                      ? SingleChildScrollView(
                        child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            
                                GridView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    //  padding: const EdgeInsets.all(10.0),
                                    scrollDirection: Axis.vertical,
                                    itemCount: _quoteslist.length,
                                    //  itemCount: data.length,
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: dynamiccrosscount,
                                      //  crossAxisCount: 2,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              2.5),
                                      mainAxisSpacing: 10.0,
                      
                                      crossAxisSpacing: 10.0,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      //   Navigator.pop(context);
                                      if (_quoteslist[index]['status'] == "New") {
                                        contcolor = Colors.blue;
                                      } else if (_quoteslist[index]['status'] ==
                                          "Assigned") {
                                        contcolor = Colors.teal;
                                      } else if (_quoteslist[index]['status'] ==
                                          "In Process") {
                                        contcolor = Colors.orange;
                                      } else if (_quoteslist[index]['status'] ==
                                          "Converted") {
                                        contcolor = Colors.red;
                                      } else if (_quoteslist[index]['status'] ==
                                          "Recycled") {
                                        contcolor = Colors.red;
                                      } else if (_quoteslist[index]['status'] ==
                                          "Dead") {
                                        contcolor = Colors.red;
                                      }
                                      print(
                                          " _quoteslist[index]['status']  _quoteslist[index]['status'] +" +
                                              _quoteslist[index]['status']
                                                  .toString());
                                      if (_quoteslist[index]['industry'] == '1') {
                      //setState(() {
                                        _quoteslist[index]['industry'] = "Catering";
                      //});
                                      } else if (_quoteslist[index]['industry'] ==
                                          '2') {
                      //setState(() {
                                        _quoteslist[index]['industry'] =
                                            "Events Management";
                      //});
                                      } else if (_quoteslist[index]['industry'] ==
                                          '3') {
                      //setState(() {
                                        _quoteslist[index]['industry'] =
                                            "Information Technology";
                      //});
                                      }
                                      if (_quoteslist[index]['source'] == '1') {
                      //setState(() {
                                        _quoteslist[index]['source'] = "Referral";
                      //});
                                      } else if (_quoteslist[index]['source'] ==
                                          '2') {
                      //setState(() {
                                        _quoteslist[index]['source'] =
                                            "Google 0r Yellow Pages";
                      //});
                                      } else if (_quoteslist[index]['source'] ==
                                          '3') {
                      //setState(() {
                                        _quoteslist[index]['source'] =
                                            "Digital Marketting";
                      //});
                                      } else if (_quoteslist[index]['source'] ==
                                          '4') {
                      //setState(() {
                                        _quoteslist[index]['source'] = "Zoho Lead";
                      //});
                                      }
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
                                        height: 1000.0,
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
                                                                5.0,
                                                                  0.0,
                                                                  1.0),
                                                              child:
                                                                  Center(
                                                                child: Container(
                                                                    //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                                                                    child: Text(
                                                                  "Quote Id : ",
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
                                                                  5.0,
                                                                  0.0,
                                                                  1.0),
                                                              child:
                                                                  Center(
                                                                child: Container(
                                                                    child: Text(
                                                                  "#QUO0000" +
                                                                      "${_quoteslist[index]['id']}",
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
                                                                5.0,
                                                                0.0,
                                                                1.0),
                                                        //  const EdgeInsets .all(  5.0),
                                                      ),
                                                    ),
                                                    // _quoteslist['status']
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
                                                                  5.0,
                                                                  0.0,
                                                                  1.0),
                                                              child:
                                                                  Center(
                                                                child: Container(
                                                                    //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                      
                                                                    child: Text(
                                                                  "Name : ",
                                                                  //  "${_quoteslist[index]['name'][0]}".toUpperCase(),
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
                                                                  5.0,
                                                                  0.0,
                                                                  10.0),
                                                              child:
                                                                  Center(
                                                                child: Container(
                                                                    child: Text(
                                                                  allWordsCapitilize(
                                                                    "${_quoteslist[index]['name']}",
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
                                                                5.0,
                                                                0.0,
                                                                1.0),
                                                        //  const EdgeInsets .all(  5.0),
                                                      ),
                                                    ),
                                                    // _quoteslist['status']
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
                                                                  5.0,
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
                                                                  5.0,
                                                                  0.0,
                                                                  1.0),
                                                              child:
                                                                  Center(
                                                                child: Container(
                                                                    child: Text(
                                                                  "${_quoteslist[index]['status_name']}",
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
                                                                5.0,
                                                                0.0,
                                                                1.0),
                                                        //  const EdgeInsets .all(  5.0),
                                                      ),
                                                    ),
                                                    // _quoteslist['status']
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
                                                                  5.0,
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
                                                                  5.0,
                                                                  0.0,
                                                                  1.0),
                                                              child:
                                                                  Center(
                                                                child: Container(
                                                                    child: Text(
                                                                  "${_quoteslist[index]['account_name']}",
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
                                                                5.0,
                                                                0.0,
                                                                1.0),
                                                        //  const EdgeInsets .all(  5.0),
                                                      ),
                                                    ),
                                                    // _quoteslist['status']
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
                                                                  5.0,
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
                                                                  5.0,
                                                                  0.0,
                                                                  1.0),
                                                              child:
                                                                  Center(
                                                                child: Container(
                                                                    child: Text(
                                                                 defaultcurrency+ " "+"${_quoteslist[index]['amount']}",
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
                                                                5.0,
                                                                0.0,
                                                                1.0),
                                                        //  const EdgeInsets .all(  5.0),
                                                      ),
                                                    ),
                                                    // _quoteslist['status']
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
                                                                 
                                                                   /*Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context) => new SingleQuotesScreen(id:_quoteslist[index]['id'])));*/
                                                                 
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
            
          //  future: getData(),
           ),
      ),
    );
  }
*/
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
        title: Text("Quote"),
      ),
      body: Form(
        key: formKey,
        child: FutureBuilder(
          //child: FutureBuilder(
          future: a,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData == true
                ? SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              //  padding: const EdgeInsets.all(10.0),
                              scrollDirection: Axis.vertical,
                              itemCount: _quoteslist.length,
                              //  itemCount: data.length,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: dynamiccrosscount,
                                //  crossAxisCount: 2,
                                childAspectRatio: MediaQuery.of(context)
                                        .size
                                        .width /
                                    (MediaQuery.of(context).size.height / 3.3),
                                mainAxisSpacing: 10.0,

                                crossAxisSpacing: 10.0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                //   Navigator.pop(context);
                                if (_quoteslist[index]['status'] == "New") {
                                  contcolor = Colors.blue;
                                } else if (_quoteslist[index]['status'] ==
                                    "Assigned") {
                                  contcolor = Colors.teal;
                                } else if (_quoteslist[index]['status'] ==
                                    "In Process") {
                                  contcolor = Colors.orange;
                                } else if (_quoteslist[index]['status'] ==
                                    "Converted") {
                                  contcolor = Colors.red;
                                } else if (_quoteslist[index]['status'] ==
                                    "Recycled") {
                                  contcolor = Colors.red;
                                } else if (_quoteslist[index]['status'] ==
                                    "Dead") {
                                  contcolor = Colors.red;
                                }
                                print(
                                    " _quoteslist[index]['status']  _quoteslist[index]['status'] +" +
                                        _quoteslist[index]['status']
                                            .toString());
                                if (_quoteslist[index]['industry'] == '1') {
                                  //setState(() {
                                  _quoteslist[index]['industry'] = "Catering";
                                  //});
                                } else if (_quoteslist[index]['industry'] ==
                                    '2') {
                                  //setState(() {
                                  _quoteslist[index]['industry'] =
                                      "Events Management";
                                  //});
                                } else if (_quoteslist[index]['industry'] ==
                                    '3') {
                                  //setState(() {
                                  _quoteslist[index]['industry'] =
                                      "Information Technology";
                                  //});
                                }
                                if (_quoteslist[index]['source'] == '1') {
                                  //setState(() {
                                  _quoteslist[index]['source'] = "Referral";
                                  //});
                                } else if (_quoteslist[index]['source'] ==
                                    '2') {
                                  //setState(() {
                                  _quoteslist[index]['source'] =
                                      "Google 0r Yellow Pages";
                                  //});
                                } else if (_quoteslist[index]['source'] ==
                                    '3') {
                                  //setState(() {
                                  _quoteslist[index]['source'] =
                                      "Digital Marketting";
                                  //});
                                } else if (_quoteslist[index]['source'] ==
                                    '4') {
                                  //setState(() {
                                  _quoteslist[index]['source'] = "Zoho Lead";
                                  //});
                                }
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
                                           // height: 1000.0,
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          5.0),
                                                  child: Row(
                                                   
                                                    children: [
                                                      Row(
                                                       
                                                        children: [
                                                          Row(
                                                         children: [
                                                              
                                                                    
                                                          
                                                                    Container(
                                                                        //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                                                                        child: Text(
                                                                      "Quote ID : ",
                                                                      style:
                                                                          TextStyle(
                                                                        color:
                                                                            Colors.black,
                                                                        fontSize:
                                                                            16.0
                                                                      ),
                                                                    )),
                                                              
                                                            ],
                                                          ),
                                                          Padding(
                                                            //  padding:  const EdgeInsets .all(  18.0),

                                                            padding:
                                                                const EdgeInsets
                                                                        .all(
                                                                    5.0,
                                                                    ),
                                                            child: Container(
                                                                child: Text(
                                                              "#QUO0000" +
                                                                  "${_quoteslist[index]['id']}",
                                                              style:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    16.0,
                                                                    fontWeight: FontWeight.bold
                                                              ),
                                                            )),
                                                          ),
                                                        ],
                                                      ),
                                                     
                                                        ],
                                                  ),
                                                ),
                                                             Padding(
                                                               padding: const EdgeInsets.all(5.0),
                                                               child: Container(
                                                                 child: Row(
                                                        children: [
                                                          Container(

                                                                  //color: Colors.green,
                                                                  //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                                                                  child: Text(
                                                            "Status : ",
                                                            style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16.0
                                                            ),
                                                          )),
                                                          Container(
                                                                  
                                                          //    color: Colors .yellow,
                                                                  child:
                                                                      Text(
                                                                    "${_quoteslist[index]['status_name']}",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Colors.black,
                                                                      fontSize:
                                                                          16.0
                                                                    ),
                                                                  )),
                                                        ],
                                                      ),
                                                               ),
                                                             ), // _quoteslist['status']
                                     
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                           
                                                            children: [
                                                              Container(
                                                                  //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),

                                                                  child: Text(
                                                                "Name : "+  allWordsCapitilize(
                                                                    "${_quoteslist[index]['name']}",
                                                                  ),
                                                                //  "${_quoteslist[index]['name'][0]}".toUpperCase(),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      16.0
                                                                ),
                                                              )),
                                                              
                                                              // _quoteslist['status']
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    child: Row(
                                                      
                                                      children: [
                                                        
                                                          
                                                              Container(
                                                                //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                                                                child: Text(
                                                              "Amount : " +   defaultcurrency+ " "+"${_quoteslist[index]['amount']}",
                                                              style:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    16.0
                                                              ),
                                                            )),
                                                           
                                                     
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                   SizedBox(
                                                  height: 5.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
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
                                                        /*Padding(
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
                                                    ),*/
                                                        // SizedBox(width: 2.0,),
                                                  /*      Flexible(
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height: 40.0,
                                                                width: 100.0,
                                                                //   color: Color(lightcolor),
                                                                child: ElevatedButton(
                                                                    style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Color(maincolor))))),
                                                                    onPressed: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pushReplacement(
                                                                              new MaterialPageRoute(builder: (BuildContext context) => new SingleInvoicescreen(id: _quoteslist[index]['id'])));
                                                                      /* _showDialog(
                                                                      context,
                                                                      _quoteslist[index]);*/
                                                                    },
                                                                    child: Text(
                                                                      "View",
                                                                      style: TextStyle(
                                                                          // fontStyle: FontStyle.italic,
                                                                          color: Colors.white),
                                                                    )),
                                                              )),
                                                        ),
                                                */
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

          //  future: getData(),
        ),
      ),
    );
  }

}
