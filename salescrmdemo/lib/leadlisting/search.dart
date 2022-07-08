import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ims/Leaddetails/Leaddetails.dart';
import 'package:ims/Login/login.dart';
import 'package:ims/const/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);
  @override
  _SearchListState createState() => new _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Widget appBarTitle = new Text(
    "Lead Search",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  //List<String> _list;
  bool _IsSearching;
  String _searchText = "";
  var contcolor = Colors.white;
  allWordsCapitilize(String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }

  var accesstoken = "";
  String msg = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _leadlist = [];
  SharedPreferences sharedPreferences;
  final formKey = GlobalKey<FormState>();
  bool showsearchlist = false;
  int dynamiccrosscount = 1;
  double dynamicchildAspectRatio = 1;
  searchinleadlist() async {
  print("Hii inside searsearchinleadlist"+_searchQuery.text.toString());

   Uri url = Uri.parse(siteurl + "api/leads/search");

    print("url&accesstoekn" + url.toString() + '$accesstoken'.toString());
   var response = await http.post(url, headers: {
      'Authorization': 'Bearer $accesstoken',
    },
        body: {
          "name": _searchQuery.text.toString(),  
         // "":,
        });
    print("responseeee");
    print(response.body.toString());
    print(response.statusCode);

    if (response.statusCode == 200) {
      var resBody = json.decode(response.body);

      print('response.body:' + response.body.toString());
           if (response.body.toString() == '[]') {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Search Not Found"),
              backgroundColor: Color(maincolor),
            ));
          }  
          else{
      setState(() {
        setState(() {
    _leadlist.clear();
  
});
            //  _leadlist.add(json.decode(response.body));

 for (int i = 0; i < resBody.length; i++) {
            setState(() {
            
                  _leadlist.add({
              //     resBody
              "name": resBody[i]['name'],
              "id": resBody[i]['id'],
              "email": resBody[i]['email'],
              "phone": resBody[i]['phone'],
              "title": resBody[i]['title'],
              "website": resBody[i]['website'],
              "lead_address": resBody[i]['lead_address'],
              "lead_city": resBody[i]['lead_city'],
              "lead_state": resBody[i]['lead_state'],
              "lead_country": resBody[i]['lead_country'],
              "lead_postalcode": resBody[i]['lead_postalcode'],
              "status": resBody[i]['status'],
              "source": resBody[i]['source'],
              "opportunity_amount": resBody[i]['opportunity_amount'],
              "industry": resBody[i]['industry'],
              "description": resBody[i]['description'],
              "campaign_name": resBody[i]['campaign_name'],
              "created_by": resBody[i]['created_by'],
              "created_from": resBody[i]['created_from'],
              // "location_latitude": resBody[i]['location_latitude'],
              //"location_longitude": resBody[i]['location_longitude'],
              // "updated_at": resBody[i]['updated_at'],
              //  "created_at":resBody[i]['created_at'],
            });
        
              if (_leadlist[i]['status'] == "0") {
                setState(() {
                  _leadlist[i]['status'] = "New";
                  contcolor = Colors.blue;
                });
              } else if (_leadlist[i]['status'] == "1") {
                setState(() {
                  _leadlist[i]['status'] = "Assigned";
                  //  contcolor = Colors.teal;
                });
              } else if (_leadlist[i]['status'] == "2") {
                setState(() {
                  _leadlist[i]['status'] = "In Process";
                  // contcolor = Colors.orange;
                });
              } else if (_leadlist[i]['status'] == "3") {
                setState(() {
                  _leadlist[i]['status'] = "Converted";
                  //  contcolor = Colors.red;
                });
              } else if (_leadlist[i]['status'] == "4") {
                setState(() {
                  _leadlist[i]['status'] = "Recycled";
                  //   contcolor = Colors.red;
                });
              } else if (_leadlist[i]['status'] == "5") {
                setState(() {
                  _leadlist[i]['status'] = "Dead";
                  //   contcolor = Colors.red;
                });
              }
            });
          }
          setState(() {
              showsearchlist = true;
          });
        //   leadresponse = json.decode(response.body);
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Search Found"),
          backgroundColor: Color(maincolor),
        ));
        
      });
      return _leadlist;

          }
          }

   //   print("create sucessfully");
    else {
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
  

  @override
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

  Widget buildBar(BuildContext context) {
    return new AppBar(centerTitle: true,
     leading: InkResponse(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(maincolor),
     title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: actionIcon,
        onPressed: () {
          setState(() {
            if (this.actionIcon.icon == Icons.search) {
              this.actionIcon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _searchQuery,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    suffix: InkWell(
                      child: new Icon(Icons.search, color: Colors.white),
                      onTap: () {
                        searchinleadlist();
                      },
                    ),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.white)),
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Lead Search",
        style: new TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

  void initState() {
    a = getleadlist();
    super.initState();
    //_IsSearching = false;
    // init();
  }

  Future a;

  getleadlist() async {
    print("inside getleadlist");
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("access_token") ?? "_";
    print("accesstoken" + accesstoken);
    if (accesstoken == "_") {
      print("insode if no access token ");
    } else {
      // getleadaccountindustries();
      //getleadsource();
      print("inside else" + accesstoken);

      Uri url = Uri.parse(siteurl + "api/leads");

      print(url);
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      });
      if (response.statusCode == 200) {
        setState(() {
          var resBody = json.decode(response.body);
          print(resBody.toString());
          for (int i = 0; i < resBody.length; i++) {
            _leadlist.add({
              //     resBody
              "name": resBody[i]['name'],
              "id": resBody[i]['id'],
              "email": resBody[i]['email'],
              "phone": resBody[i]['phone'],
              "title": resBody[i]['title'],
              "website": resBody[i]['website'],
              "lead_address": resBody[i]['lead_address'],
              "lead_city": resBody[i]['lead_city'],
              "lead_state": resBody[i]['lead_state'],
              "lead_country": resBody[i]['lead_country'],
              "lead_postalcode": resBody[i]['lead_postalcode'],
              "status": resBody[i]['status'],
              "source": resBody[i]['source'],
              "opportunity_amount": resBody[i]['opportunity_amount'],
              "industry": resBody[i]['industry'],
              "description": resBody[i]['description'],
              "campaign_name": resBody[i]['campaign_name'],
              "created_by": resBody[i]['created_by'],
              "created_from": resBody[i]['created_from'],
              // "location_latitude": resBody[i]['location_latitude'],
              //"location_longitude": resBody[i]['location_longitude'],
              // "updated_at": resBody[i]['updated_at'],
              //  "created_at":resBody[i]['created_at'],
            });
            setState(() {
              if (_leadlist[i]['status'] == "0") {
                setState(() {
                  _leadlist[i]['status'] = "New";
                  contcolor = Colors.blue;
                });
              } else if (_leadlist[i]['status'] == "1") {
                setState(() {
                  _leadlist[i]['status'] = "Assigned";
                  //  contcolor = Colors.teal;
                });
              } else if (_leadlist[i]['status'] == "2") {
                setState(() {
                  _leadlist[i]['status'] = "In Process";
                  // contcolor = Colors.orange;
                });
              } else if (_leadlist[i]['status'] == "3") {
                setState(() {
                  _leadlist[i]['status'] = "Converted";
                  //  contcolor = Colors.red;
                });
              } else if (_leadlist[i]['status'] == "4") {
                setState(() {
                  _leadlist[i]['status'] = "Recycled";
                  //   contcolor = Colors.red;
                });
              } else if (_leadlist[i]['status'] == "5") {
                setState(() {
                  _leadlist[i]['status'] = "Dead";
                  //   contcolor = Colors.red;
                });
              }
            });
          }
        });

        print("lead_accountindustries id is" + _leadlist.toString());
        print(_leadlist.toString());
        setState(() {});
        return _leadlist;
      } else if (response.statusCode == 401) {
        sharedPreferences = await SharedPreferences.getInstance();
        accesstoken =
            sharedPreferences.setString("access_token", "_") as String;

        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new Loginscreen()));
      } else {
        print(response.statusCode.toString());
        print(json.decode(response.body).toString());
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth =
        screenSize.width / (2 / (screenSize.height / screenSize.width));
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildBar(context),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(children: [
                
              ],),
              Visibility(
                visible: showsearchlist,
                child: FutureBuilder(
                  //child: FutureBuilder(
                  //  future: searchinleadlist(),
                  future: a,
                  //getleadlist(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);

                    return snapshot.hasData == true
                        ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                /*Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () {
                                          /*    Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new Alleventsscreen()));*/
                                        },
                                        child: Container(
                                            child: Image.network(img,
                                                height: screenSize.height / 4,
                                                fit: BoxFit.cover,
                                                width: screenSize.width))),
                                  ),*/
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    /*  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Text(
                                          "Number of Leads".toString(),
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),*/
                                    /* Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Text(
                                          _leadlist.length.toString(),
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),*/
                                  ],
                                ),
                                GridView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    //  padding: const EdgeInsets.all(10.0),
                                    scrollDirection: Axis.vertical,
                                    itemCount: _leadlist.length,
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
                                      //   Navigator.pop(context);
                                      //    print("r0"+_leadlist[index]['status'].toString());
                                      if (_leadlist[index]['status'] == "New") {
                                        contcolor = Colors.blue;
                                      } else if (_leadlist[index]['status'] ==
                                          "Assigned") {
                                        contcolor = Colors.teal;
                                      } else if (_leadlist[index]['status'] ==
                                          "In Process") {
                                        contcolor = Colors.orange;
                                      } else if (_leadlist[index]['status'] ==
                                          "Converted") {
                                        contcolor = Colors.red;
                                      } else if (_leadlist[index]['status'] ==
                                          "Recycled") {
                                        contcolor = Colors.red;
                                      } else if (_leadlist[index]['status'] ==
                                          "Dead") {
                                        contcolor = Colors.red;
                                      }
                                      /*  print(
                                          " _leadlist[index]['status']  _leadlist[index]['status'] +" +
                                              _leadlist[index]['status']
                                                  .toString());*/
                                      if (_leadlist[index]['industry'] == '1') {
//setState(() {
                                        _leadlist[index]['industry'] =
                                            "Catering";
//});
                                      } else if (_leadlist[index]['industry'] ==
                                          '2') {
//setState(() {
                                        _leadlist[index]['industry'] =
                                            "Events Management";
//});
                                      } else if (_leadlist[index]['industry'] ==
                                          '5') {
//setState(() {
                                        _leadlist[index]['industry'] =
                                            "Direct Customer";
//});
                                      }
                                      if (_leadlist[index]['source'] == '1') {
//setState(() {
                                        _leadlist[index]['source'] = "Referral";
//});
                                      } else if (_leadlist[index]['source'] ==
                                          '2') {
//setState(() {
                                        _leadlist[index]['source'] =
                                            "Google 0r Yellow Pages";
//});
                                      } else if (_leadlist[index]['source'] ==
                                          '3') {
//setState(() {
                                        _leadlist[index]['source'] =
                                            "Digital Marketting";
//});
                                      } else if (_leadlist[index]['source'] ==
                                          '4') {
//setState(() {
                                        _leadlist[index]['source'] =
                                            "Zoho Lead";
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
                                                  child: Column(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8.0,
                                                                0.0,
                                                                0.0,
                                                                0.0),
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
                                                                            .all(
                                                                        2.0),
                                                                child:
                                                                    Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      //   SizedBox(height: 45.0,),
                                                                      if ("${_leadlist[index]['name'][0]}"
                                                                              .toUpperCase() ==
                                                                          "S")
                                                                        Padding(
                                                                          //  padding:  const EdgeInsets .all(  20.0),

                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              5.0,
                                                                              20.0,
                                                                              0.0,
                                                                              10.0),
                                                                          child:
                                                                              Center(
                                                                            child: Container(
                                                                                //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                                                                                child: CircleAvatar(
                                                                                    backgroundColor: Colors.red,
                                                                                    //Color(maincolor),
                                                                                    child: Text(
                                                                                      "${_leadlist[index]['name'][0]}".toUpperCase(),
                                                                                      style: TextStyle(color: Colors.white, fontSize: 23.0),
                                                                                    ))),
                                                                          ),
                                                                        ),
                                                                      if ("${_leadlist[index]['name'][0]}".toUpperCase() == "A" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "D" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "B" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "C")
                                                                        Padding(
                                                                          //  padding:  const EdgeInsets .all(  20.0),

                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              5.0,
                                                                              20.0,
                                                                              0.0,
                                                                              10.0),
                                                                          child:
                                                                              Center(
                                                                            child: Container(
                                                                                //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                                                                                child: CircleAvatar(
                                                                                    backgroundColor: Colors.teal,
                                                                                    //Color(maincolor),
                                                                                    child: Text(
                                                                                      "${_leadlist[index]['name'][0]}".toUpperCase(),
                                                                                      style: TextStyle(color: Colors.white, fontSize: 23.0),
                                                                                    ))),
                                                                          ),
                                                                        ),
                                                                      if ("${_leadlist[index]['name'][0]}".toUpperCase() == "E" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "F" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "G" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "H" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "I" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "J" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "K" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "L")
                                                                        Padding(
                                                                          //  padding:  const EdgeInsets .all(  20.0),

                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              5.0,
                                                                              20.0,
                                                                              0.0,
                                                                              10.0),
                                                                          child:
                                                                              Center(
                                                                            child: Container(
                                                                                //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                                                                                child: CircleAvatar(
                                                                                    backgroundColor: Colors.pink,
                                                                                    //Color(maincolor),
                                                                                    child: Text(
                                                                                      "${_leadlist[index]['name'][0]}".toUpperCase(),
                                                                                      style: TextStyle(color: Colors.white, fontSize: 23.0),
                                                                                    ))),
                                                                          ),
                                                                        ),
                                                                      if ("${_leadlist[index]['name'][0]}".toUpperCase() == "M" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "O" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "Q" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "N" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "P" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "R" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "T")
                                                                        Padding(
                                                                          //  padding:  const EdgeInsets .all(  20.0),

                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              5.0,
                                                                              20.0,
                                                                              0.0,
                                                                              10.0),
                                                                          child:
                                                                              Center(
                                                                            child: Container(
                                                                                //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                                                                                child: CircleAvatar(
                                                                                    backgroundColor: Colors.orange,
                                                                                    //Color(maincolor),
                                                                                    child: Text(
                                                                                      "${_leadlist[index]['name'][0]}".toUpperCase(),
                                                                                      style: TextStyle(color: Colors.white, fontSize: 23.0),
                                                                                    ))),
                                                                          ),
                                                                        ),
                                                                      if ("${_leadlist[index]['name'][0]}".toUpperCase() == "U" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "W" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "Y" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "V" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "X" ||
                                                                          "${_leadlist[index]['name'][0]}".toUpperCase() ==
                                                                              "Z")
                                                                        Padding(
                                                                          //  padding:  const EdgeInsets .all(  20.0),

                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              5.0,
                                                                              20.0,
                                                                              0.0,
                                                                              10.0),
                                                                          child:
                                                                              Center(
                                                                            child: Container(
                                                                                //  decoration: BoxDecoration(border: Border.all(color: Color(maincolor))),
                                                                                child: CircleAvatar(
                                                                                    backgroundColor: Colors.orange,
                                                                                    //Color(maincolor),
                                                                                    child: Text(
                                                                                      "${_leadlist[index]['name'][0]}".toUpperCase(),
                                                                                      style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 23.0,
                                                                                      ),
                                                                                    ))),
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
                                                                          20.0,
                                                                          0.0,
                                                                          10.0),
                                                                  //  const EdgeInsets .all(  5.0),
                                                                  child: Text(
                                                                    //toBeginningOfSentenceCase('this is a string'),
                                                                    allWordsCapitilize(
                                                                      "${_leadlist[index]['name']}",
                                                                    ),
                                                                    // "${_leadlist[index]['name']}",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    // softWrap: false,
                                                                    style:
                                                                        new TextStyle(
                                                                      fontSize:
                                                                          18.0,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              // _leadlist['status']

                                                              Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            1.0),

                                                                    //  const EdgeInsets .all(  5.0),
                                                                    child: Text(
                                                                      "Status",
                                                                      style:
                                                                          new TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            15.0,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                      child:
                                                                          Container(
                                                                        // width: 30.0,
                                                                        // height: 20.0,
                                                                        color:
                                                                            contcolor,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(4.0),
                                                                            child:
                                                                                Text(
                                                                              allWordsCapitilize(
                                                                                "${_leadlist[index]['status']}",
                                                                              ),
                                                                              // "${_leadlist[index]['name']}",
                                                                              overflow: TextOverflow.ellipsis,
                                                                              // softWrap: false,
                                                                              style: new TextStyle(
                                                                                fontSize: 15.0,
                                                                                //  color:contcolor,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8.0,
                                                                0.0,
                                                                0.0,
                                                                0.0),
                                                        child: Container(
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 13.0,
                                                                  backgroundColor:
                                                                      Colors.grey[
                                                                          350],
                                                                  child: Icon(
                                                                    FontAwesomeIcons
                                                                        .envelopeSquare,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 15.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2.0,
                                                              ),
                                                              Flexible(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "${_leadlist[index]['email']}",
                                                                    style:
                                                                        new TextStyle(
                                                                      fontSize:
                                                                          18.0,
                                                                      //  color: Color(text_color),
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                          /*   Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets.all(
                                                                        5.0),
                                                                child: Text(
                                                                  
                                                                      " " +
                                                                      "${_leadlist[index]['email']}",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  // softWrap: false,
                                                                  style:
                                                                      new TextStyle(
                                                                    fontSize:
                                                                        18.0,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    */
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8.0,
                                                                0.0,
                                                                0.0,
                                                                0.0),
                                                        child: Container(
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 13.0,
                                                                  backgroundColor:
                                                                      Colors.grey[
                                                                          350],
                                                                  child: Icon(
                                                                    FontAwesomeIcons
                                                                        .mobile,
                                                                    //color:Color(maincolor),
                                                                    //  color: Color(text_color),
                                                                    color: Colors
                                                                        .black,
                                                                    size: 15.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2.0,
                                                              ),
                                                              Flexible(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "${_leadlist[index]['phone']}",
                                                                    style:
                                                                        new TextStyle(
                                                                      fontSize:
                                                                          18.0,
                                                                      color: Colors
                                                                          .grey,
                                                                      //  color: Color(text_color),
                                                                      //  color: Colors .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8.0,
                                                                0.0,
                                                                0.0,
                                                                0.0),
                                                        child: Container(
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 13.0,
                                                                  backgroundColor:
                                                                      Colors.grey[
                                                                          350],
                                                                  child: Icon(
                                                                    FontAwesomeIcons
                                                                        .industry,
                                                                    //  color:Color(maincolor),
                                                                    color: Colors
                                                                        .black,
                                                                    size: 15.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2.0,
                                                              ),
                                                              Flexible(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    _leadlist[
                                                                            index]
                                                                        [
                                                                        'industry'],
                                                                    style:
                                                                        new TextStyle(
                                                                      fontSize:
                                                                          18.0,
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8.0,
                                                                0.0,
                                                                0.0,
                                                                0.0),
                                                        child: Container(
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 13.0,
                                                                  backgroundColor:
                                                                      Colors.grey[
                                                                          350],
                                                                  child: Icon(
                                                                    FontAwesomeIcons
                                                                        .mapMarker,
                                                                    color: Colors
                                                                        .black,
                                                                    // color:Color(maincolor),
                                                                    size: 14.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2.0,
                                                              ),
                                                              Flexible(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    _leadlist[
                                                                            index]
                                                                        [
                                                                        'lead_city'],
                                                                    style:
                                                                        new TextStyle(
                                                                      fontSize:
                                                                          18.0,
                                                                      color: Colors
                                                                          .grey,
                                                                      //  color: Colors .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      /*SizedBox(
                                                        height: 1.0,
                                                      ),*/
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8.0,
                                                                0.0,
                                                                0.0,
                                                                0.0),
                                                        child: Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              // SizedBox(width: 2.0,),
                                                              Flexible(
                                                                child: Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
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
                                                                            _showDialog(context,
                                                                                _leadlist[index]);
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
              ),

              /*Row(
                children: [
                  Expanded(
                    child: DataTable(
                      sortColumnIndex: 1,
        
                      //    sortAscending: true,
                      // dataRowHeight: 50,
                      // dividerThickness: 5,
                      columns: <DataColumn>[
                        DataColumn(
                          tooltip: "This is Name",
                          label: Text(
                            'Name',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color(maincolor)),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Email',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color(maincolor)),
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        for (int ij = 0; ij < _leadlist.length; ij++)
                          DataRow(
                            cells: <DataCell>[
                              DataCell(
                                  Text(
                                    _leadlist[ij]['name'].toString(),
                                  ),
                                  //   showEditIcon: true,
                                  placeholder: false, onTap: () {
                                print('row 1 pressed');
                                _showDialog(context, _leadlist[ij]);
                              }),
                              DataCell(
                                  Text(_leadlist[ij]['email'].toString()
        
                                      //_leadlist[ij]['email']  null : _leadlist[ij]['email'] ? ''
        
                                      ), onTap: () {
                                print('row 2 pressed');
                                _showDialog(context, _leadlist[ij]);
                              }),
                              /* DataCell(Text(
                               _leadlist[ij]['phone'].toString() 
                            //  _leadlist[ij]['phone']
                              
                              )),*/
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              )
            */
            ],
          ),
        ),
      ),
    );
  }
}
/*Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: buildBar(context),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        //children: _IsSearching ? _buildSearchList() : _buildList(),
      ),
    );
  }*/

/*List<ChildItem> _buildList() {
    return _leadlist.map((contact) => new ChildItem(contact)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _leadlist.map((contact) => new ChildItem(contact))
          .toList();
    }
    else {
      List<String> _searchList = List();
      for (int i = 0; i < _leadlist.length; i++) {
        String  name = _leadlist.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => new ChildItem(contact))
          .toList();
    }
  }
*/

class ChildItem extends StatelessWidget {
  final String name;
  ChildItem(this.name);
  @override
  Widget build(BuildContext context) {
    return new ListTile(title: new Text(this.name));
  }
}
