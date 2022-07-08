import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:sampleproject/bill.dart';
import 'package:sampleproject/checkout.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCart extends StatefulWidget {
  @override
  _AuthCartState createState() => _AuthCartState();
}

class _AuthCartState extends State<AuthCart> {
  SharedPreferences sharedPreferences;
   TextEditingController coupon = new TextEditingController();
  //   final flutterWebviewPlugin = new FlutterWebviewPlugin();

  dynamic data = [];
      
      //  InAppWebViewController webView;
  String url = "";
  double progress = 0;
  String cart_id = "";
  static const String imageURL = "https://w3cert.net/outfit/";
  var list = new List();
  var accesstoken;
  Future a;
  String grandtotal="";
  //https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token='+localaccesstoken+'&mobile=mobile&currency='+currencycode+'&tmpl=component
 
String url1;
  Future<void> _launchInBrowser1() async {
     sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("accesstoken").toString();
    print("accesstoken"+accesstoken);
  /* url1 = "https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=checkout&access_token='$accesstoken'&mobile='mobile'&currency=''&tmpl='component'";
url1 = "https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=checkout&access_token=%27+N8NSirEdsMVTHgD3YmfY6ZTp2wFPW2vdRcnxiUw9+%27&mobile=mobile&currency=%27+currencycode+%27&tmpl=component";*/

 //const browser = this.iab.create('
  //https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token='+localaccesstoken+'&mobile=mobile&currency='+currencycode+'&tmpl=component', '_self', 'hideurlbar=yes,location=no');

url1 = "https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=checkout&access_token=%27+$accesstoken+%27&mobile=mobile&currency=%27+currencycode+%27&tmpl=component";
//url1 = "https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=checkout&access_token=%27+N8NSirEdsMVTHgD3YmfY6ZTp2wFPW2vdRcnxiUw9+%27&mobile=mobile&currency=%27+currencycode+%27&tmpl=component";
 /*
 
 https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=checkout
 &access_token=%27+N8NSirEdsMVTHgD3YmfY6ZTp2wFPW2vdRcnxiUw9+%27&mobile=mobile&currency=%27+currencycode+%27&tmpl=component
 */
  print(url1);
 
    setState(() {
      url = url1;
    });

//html.window.location.href ="https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token=$accesstoken&mobile=mobile&currency=''&tmpl=component";
  }
 

  Future getauthcart() async {
    print("insideauth_cart");
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("accesstoken").toString();
    print("accesstoken"+accesstoken);
    final response = await http.get(
        "https://w3cert.net/outfit/index.php/api/v1/authcarts?access_token=$accesstoken");
    if (response.statusCode == 200) {
      print('response.body:' + response.body);
      //return Cart Items not found
      this.setState(() {
        data = json.decode(response.body);
      });
      print(data);
      data['data']['items'].forEach((key, value){
    list.add(value);
  });
  print("listtttttttttttttttttt of auth cart");
  print("listtttttttttttttttttt");
  print(list);
   // print(list[0]['product_id']);
  // print(list[0]['cartitem']['thumb_image']);
return list;
   // print(list[0]['product_id']);
  //  print(list[0]['cartitem']['thumb_image']);
     
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  getauthcarttotals() async {
    print("inside getauthcarttotals ");
    //accesstoken
        await Future.delayed(Duration(seconds: 5));

    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("accesstoken").toString();
    print(accesstoken);
    final response = await http.get(
        "https://w3cert.net/outfit/index.php/api/v1/authcarttotal?access_token=$accesstoken");
    if (response.statusCode == 200) {
      print('response.body:' + response.body);
     this.setState(() {
        data = json.decode(response.body);
      });
    //  print(data);
    //  print(data['grandtotal']['value']);na
      setState(() {
     //   grandtotal = data['grandtotal']['value'];
      });
      //print(data['AADI20a_a_d_i20']['label']);

      // print( "${data['data']['items']}");
      /*data['data']['items'].forEach((key, value){
    list.add(value);
  });
  print("listtttttttttttttttttt of auth cart");
    print(list[0]['product_id']);
    print(list[0]['cartitem']['thumb_image']);*/
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  navigate() async {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new Bill(),
    ));
  }
applycoupon() async{
print("inside apply coupon");
  sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("accesstoken").toString();
    print(accesstoken);
 var url = "https://w3cert.net/outfit/index.php/api/v1/coupon";
  
    final response = await http.post(url, body: {
      "access_token": accesstoken.toString(),
	  "coupon": coupon.toString(),
    }
    );//.whenComplete(() => getauthcarttotals());

    print('response.body' + response.body);
   
}
  void initState() {
     _launchInBrowser1(); 
    a= getauthcart();
    
    super.initState();
  }
  void dispose() {
   // flutterWebviewPlugin.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //  crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
                  
                                              FutureBuilder(
        
           future: a,
           
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              print("snapshot.hasData");
             print(snapshot.hasData.toString());
           //   print("snapshot.data"+snapshot.data);
              return snapshot.hasData

                  /*? new ItemList(
                      list: snapshot.data,  
                    )*/
                  ?    Center(
              child: new Container(
                child: Column(
                  children: <Widget>[
                    GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(1.0),
                        scrollDirection: Axis.vertical,
                        itemCount: list.length,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: (10 / 10),
                        ),
                        //itemBuilder: null
                        itemBuilder: (BuildContext context, int index) {
                          return new GestureDetector(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: new Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: new Container(
                                      child: GestureDetector(
                                        child: SingleChildScrollView(
                                            child: new Column(
                                          //dmainAxisAlignment:     MainAxisAlignment.center,
                                          //crossAxisAlignment:                      CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            new Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  // Text("${data['data']['items']['996.6.6.0.YTowOnt9']['cartitem']['product_name']}", style:new TextStyle(fontSize: 15.0,color:Colors.black, fontWeight: FontWeight.bold,),),
                                                  //    Text("${list[index]['cartitem']['product_name']}", style:new TextStyle(fontSize: 15.0,color:Colors.black, fontWeight: FontWeight.bold,),),
//Text(list[index]['product_id']),
                                                  // Text("${data['data']['items']['cartitem']['product_name']}", style:new TextStyle(fontSize: 15.0,color:Colors.black, fontWeight: FontWeight.bold,),),

                                                  //996.6.6.0.YTowOnt9
                                                  //997.8.8.0.YTowOnt9
                                                  //998.19.23.0.YTowOnt9
                                                  Image.network(
                                                    imageURL +
                                                        '${list[index]['cartitem']['thumb_image']}',
                                                    width: 400,
                                                    height: 200,
                                                  ),
//'                                           Text("${list[index]['cartitem']['product_qty']}", style:new TextStyle(fontSize: 15.0,color:Colors.black, fontWeight: FontWeight.bold,),),
                                                  Text(
                                                    "Name : " +
                                                        "${list[index]['cartitem']['product_name']}",
                                                    style: new TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  /*  Text("id : "+
                                          "${list[index]['cartitem']['product_id']}",
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),*/

                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    "Quantity : " +
                                                        "${list[index]['cartitem']['product_qty']}",
                                                    style: new TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                )),
                          );
                        }),
                       //  Row(
                        //   children: <Widget>[
                          /*   new TextFormField(
                        
                        controller: coupon,
                        decoration: new InputDecoration(
                              //icon: const Icon(Icons.code),
                              labelText: "Enter coupon",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(),
                              ),
                        ),
                      ),
                        new RaisedButton(
                        child: new Text(
                          "Apply",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        color: Colors.lightBlue,
                        onPressed: () {
                          applycoupon();
                        }),
                          new RaisedButton(
                        child: new Text(
                          "bill",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        color: Colors.lightBlue,
                        onPressed: () {
                      //    navigate();
                        }),*/
//                           ],
                     //    ),
                      SizedBox(
                        height: 10.0,
                      ),
                    Text(
                      "$grandtotal",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 25.0),
                    ),
                 
                    new RaisedButton(
                        child: new Text(
                          "Checkout",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        color: Colors.lightBlue,
                        onPressed: () {
                         // _launchInBrowser1();
                         print(url);
                         Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new Checkout(url:url),
    ));
                    
                        }),
                  ],
                ),
              ),
            )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Center(
                          child: new CircularProgressIndicator(),
                        ),
                            new RaisedButton(
                        child: new Text(
                          "Checkout",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        color: Colors.lightBlue,
                        onPressed: () {
                         // _launchInBrowser1();
                         print(url);
                         Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new Checkout(url:url),
    ));
                    
                        }),
                        
                    ],
                  );
            },
          ),
        
          ],
        )),
      ),
    );
  }
}
