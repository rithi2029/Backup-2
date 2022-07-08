import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/singleproduct.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Categorylist extends StatefulWidget {
  @override
  _CategorylistState createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  dynamic data = [];
  dynamic data1 = [];
  dynamic data2 = [];
  //  List data = [];
  Future a;
  Future b;
  Future c;
  String msg = '';
  var accesstoken, cart_id;
  SharedPreferences sharedPreferences;

  Future getcategirylist() async {
    print('Inside getcategirylist');
    var url = "http://w3cert.net/outfit/index.php/api/v1/categories";
    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print('response.body:' + response.body);
      setState(() {
        var resBody = json.decode(response.body);
        data = resBody; //This line changed from data = resBody[" "];
      });
 //     print(data['data'][0]['title']);
      return data;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  void initState() {
    a = getcategirylist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth =
        screenSize.width / (2 / (screenSize.height / screenSize.width));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title:  Text("Category", style: const TextStyle(
              fontSize: 30.0,
              //letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),),
      ),
        key: scaffoldkey,
            resizeToAvoidBottomInset: false,

       // resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              
              FutureBuilder(
                future: a,
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                
                  print("snapshot.hasData");
                  print(snapshot.hasData.toString());
                  
                  return snapshot.hasData
                      ? Container(
                          height: screenWidth*2,
                          child: Row(
                            children: <Widget>[
                             
                              Flexible(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                     itemCount: data['data']['data'].length,
                                   // itemCount: 4,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return new GestureDetector(
                                        child: SingleChildScrollView(
                                                                                  child: Container(
                                            
                              
                                              child: new Card(
                                            
                                            child: new Container(
                                      
                                              height: 130.0,
                                              child:                                GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
           color:
                Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "${data['data']['data'][index]['title']}".toUpperCase(),
            style: const TextStyle(
              fontSize: 20.0,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onTap: () {
        
             Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new MyHomePage(cat_id: "9")));

      
      },
    ),
                                          /*    child: GestureDetector(
                                                onTap: () {
                                                  // print(data['data']['products'][index]['price']);
                                          

                                                  /* Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new SingleproductPage(
                        


                                       productprice: "${data['data']['products'][index]['price']}",
                                 
                                            productname: "${data['data']['products'][index]['product_name']}",
                                            productimage: "${data['data']['products'][index]['main_image']}",
                                            productlongdesc: "${data['data']['products'][index]['product_long_desc']}",
                                            producttype: "${data['data']['products'][index]['product_type']}",
                                //            productid:int.tryParse("${data['data']['products'][index]['j2store_product_id']}"),
                                 productid:"${data['data']['products'][index]['j2store_product_id']}",
                                            
                                                 )));*/
                                                },
                                                child: new Container(
                                                  //  width: 1500,
                                                  //height: 1500,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment:        CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              /*Text(
                                                                  //    "hai",
                                                                  //title
                                                                  "${data['data']['data'][index]['title']}",
                                                                  
                                                                  style:
                                                                      new TextStyle(
                                                                    fontSize: 12.0,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),*/
                                                              
                                                            ],
                                                          ),
                       
                                                        ],
                                                      ),
                                                      //price = double.parse(data['price']).toStringAsFixed(2);
                                                    ],
                                                  ),
                                                ),
                                              ),*/
                                            ),
                                          )),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 150.0,),
                            new Center(
                              child: new CircularProgressIndicator(),
                            ),
                          ],
                        );
                },
              ),
            ],
          )),
        ));
  }
}
