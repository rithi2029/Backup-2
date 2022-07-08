import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sampleproject/register.dart';
//import 'package:sampleproject/singleproductasas.t';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> { 
  SharedPreferences sharedPreferences;
  dynamic data = [];
  String cart_id = "";
   static const String imageURL = "https://w3cert.net/outfit/";
     var list = new List();
     Future a;
 

  Future  getcartData() async {
    print('Inside getData in cart.dart');
    sharedPreferences = await SharedPreferences.getInstance();
    cart_id = sharedPreferences.getString("cartid").toString();
    print("cart_idcart_id"+cart_id);
   //await Future.delayed(Duration(seconds: 2));
    final response = await http
        .get("https://w3cert.net/outfit/index.php/api/v1/showcart/$cart_id");
      //  .get("https://w3cert.net/outfit/index.php/api/v1/showcart/12421");
        //12421
    if (response.statusCode == 200) {
      print('response.body:' + response.body);
      this.setState(() {
        data = json.decode(response.body);
      });
      print(data);
 
  data['data']['items'].forEach((key, value){
    list.add(value);
  });
  print("listtttttttttttttttttt");
  print(list);
   // print(list[0]['product_id']);
   print(list[0]['cartitem']['thumb_image']);
return list;
    //print(list[0]);   

    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }


    navigate() async {
      Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new Register(),
    ));
  }

  void initState() {  
    a = getcartData();
    super.initState();
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

              ///  snapshot.data.child(product_name).getValue() != null;
              /// print
              print("snapshot.hasData in cartscreen'");
             print(snapshot.hasData.toString());
           //   print("snapshot.data"+snapshot.data);
              return snapshot.hasData

                  /*? new ItemList(
                      list: snapshot.data,  
                    )*/
                  ?  Center(
              child: new Container(
                child: Column(
                  children: <Widget>[
                     GridView.builder(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(10.0),
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: (10 / 10),
              ),
              //itemBuilder: null
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: new Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new Container(
                            child: GestureDetector(
                           
                                                          child: SingleChildScrollView(
                                  child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  new Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                     
                                       Image.network(
                                          imageURL +
                                              '${list[index]['cartitem']['thumb_image']}',
                                          width: 400,
                                          height: 200,
                                        ),
//'                                           Text("${list[index]['cartitem']['product_qty']}", style:new TextStyle(fontSize: 15.0,color:Colors.black, fontWeight: FontWeight.bold,),),
                                        Text("Name : "+
                                          "${list[index]['cartitem']['product_name']}",
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
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
                                          height:10.0,
                                        ),
                                         Text("Quantity : "+"${list[index]['cartitem']['product_qty']}",
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
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
    new RaisedButton(
                        child: new Text(
                          "Checkout",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        color: Colors.lightBlue,
                        onPressed: () {
                             navigate();
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
                        
                    ],
                  );
            },
          ),
          /*  Center(
              child: new Container(
                child: Column(
                  children: <Widget>[
                     GridView.builder(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(10.0),
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: (10 / 10),
              ),
              //itemBuilder: null
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: new Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new Container(
                            child: GestureDetector(
                           
                                                          child: SingleChildScrollView(
                                  child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  new Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
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
                                        Text("Name : "+
                                          "${list[index]['cartitem']['product_name']}",
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
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
                                          height:10.0,
                                        ),
                                         Text("Quantity : "+"${list[index]['cartitem']['product_qty']}",
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
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
    new RaisedButton(
                        child: new Text(
                          "Checkout",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        color: Colors.lightBlue,
                        onPressed: () {
                             navigate();
                        }),
                  ],
                ),
              ),
            ),*/
          ],
        )
        ),
      ),
    );
  }
}
