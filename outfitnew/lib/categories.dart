import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/singleproduct.dart';

class Categories extends StatefulWidget {
  Categories({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> images = [
    'assets/img/slider1.jpg',
    //'assets/img/slider4.jpg',
    'assets/img/image(3).jpg',
    //'assets/img/image(4).jpg',
    //'assets/img/image(5).jpg',
  ];
    List<String> images1 = [
    'assets/img/ofrbnr1.jpg',
    'assets/img/ofrbnr.jpg',
    
  ];
  dynamic data = [];
    dynamic data1 = [];
        dynamic data2 = [];
 //  List data = [];
 Future a;
 Future b;
 Future c;
    /*  Future getData() async {
    print('Inside getData in main.dart');
   var url  = "https://w3cert.net/outfit/index.php/api/v1/products?filter_catid=${widget.cat_id}";
   final response = await 
   http.get(Uri.encodeFull(url), 
   headers: {"Accept": "application/json"});
       if (response.statusCode == 200) {
     // print('response.body:' + response.body);
    setState(() {
      var resBody = json.decode(response.body);
      data = resBody; //This line changed from data = resBody[" "];
    });
return data;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }*/
  
     Future getData() async {
    print('Inside getData in main.dart');
   var url  = "https://w3cert.net/outfit/index.php/api/v1/products?filter_catid=${8}";
   final response = await 
   http.get(Uri.encodeFull(url), 
   headers: {"Accept": "application/json"});
       if (response.statusCode == 200) {
     // print('response.body:' + response.body);
    setState(() {
      var resBody = json.decode(response.body);
      data = resBody; //This line changed from data = resBody[" "];
    });
return data;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
       Future getData1() async {
  print('Inside getData1 in main.dart');
   var url  = "https://w3cert.net/outfit/index.php/api/v1/products?filter_catid=${9}";
   final response = await 
   http.get(Uri.encodeFull(url), 
   headers: {"Accept": "application/json"});
       if (response.statusCode == 200) {
     // print('response.body:' + response.body);
    setState(() {
      var resBody1 = json.decode(response.body);
      print(resBody1);
      data1 = resBody1; //This line changed from data = resBody[" "];
    });
return data1;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

     Future getData2() async {
  print('Inside getData1 in main.dart');
   var url  = "https://w3cert.net/outfit/index.php/api/v1/products?filter_catid=${11}";
   final response = await 
   http.get(Uri.encodeFull(url), 
   headers: {"Accept": "application/json"});
       if (response.statusCode == 200) {
     // print('response.body:' + response.body);
    setState(() {
      var resBody1 = json.decode(response.body);
      print(resBody1);
      data2 = resBody1; //This line changed from data = resBody[" "];
    });
return data2;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static const String imageURL = "https://w3cert.net/outfit/";
   
  void initState() {
  a =  getData();
  b = getData1();
 c = getData2();

     WidgetsBinding.instance.addPostFrameCallback((_) {
      // print(img1);

      images.forEach((imageUrl) {
        precacheImage(ExactAssetImage(imageUrl), context);
      });
    });
    super.initState();
  }
Swiper imageSlider(context){
 
return new Swiper(
  autoplay: true,
  itemBuilder: (BuildContext context, int index) {
    return new  Image.asset(images[index],);
    /*Image.network(
      "https://images.unsplash.com/photo-1595445364671-15205e6c380c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=764&q=80",
      fit: BoxFit.fitHeight,
    );*/
 
  },
  //itemCount: 10,
  itemCount: images.length,
  viewportFraction: 0.8,
  scale: 0.9,
);
 
}
  @override
  Widget build(BuildContext context ) {
      final screenSize = MediaQuery.of(context).size;
    final screenWidth =screenSize.width / (2 / (screenSize.height / screenSize.width));
   // final screenWidth = MediaQuery.of(context).size.width;
     // var screenWidth = constraints.maxWidth;

    return Scaffold(
         resizeToAvoidBottomInset: false,

    //  resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
    
                  
Container(
 
          constraints: BoxConstraints.expand(
            height: 200
          ),
          child: imageSlider(context)),
    
 
SizedBox(

  height: 20.0,
),

          
          Container(child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(child: Image.asset("assets/img/slider1.png"),
            onTap: (){
                var cid = "8";
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MyHomePage(cat_id: cid)));
            },),
          )),
          SingleChildScrollView(
            child: Container(
               
                child: SingleChildScrollView(
              child: GridView.count(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                // childAspectRatio: screenWidth/100.0,
                //    childAspectRatio: 3/5,
                //  crossAxisCount: 2,
                crossAxisCount: 2,
                padding: EdgeInsets.all(4.0),
                childAspectRatio: 8.0 / 9.0,
                //0crossAxisSpacing: 5.0,
                // mainAxisSpacing: 5.0,

                children: <Widget>[
                  GestureDetector(
                    child: SingleChildScrollView(
                      child: Container(
                         padding: const EdgeInsets.all(10.0),
                          child: Column(children: <Widget>[
                        // SizedBox(height:20.0),

                        Container(
                          decoration: BoxDecoration(
                            //border: Border.all(
                          //    color:  Color(0xffF6846C),
                            //  width: 1.0,
                          //  ),
                          ),
                          //width: 2000.0,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'assets/img/women.jpg',
                                  fit: BoxFit.fitWidth,
                                 /*width: 150.0,
                                  height: 180.0,*/
                                ),
                             /*   SizedBox(
                                  height: 20.0,
                                  child: /*Container(
                                    color:  Color(0xffF6846C),
                                    child: Center(
                                      child: Text('Women',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0)),
                                    ),
                                  ),*/
                                  Stack(children: <Widget>[
       Positioned(
           bottom: 1.0,
           left: 36.0,
           // child: Text("Welcome to OUTFIT",
           child: Text("Women",
               style: TextStyle(
                   color: Colors.black,
                   fontSize: 15.0,
                   fontWeight: FontWeight.w500))),
     ])
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      ])),
                    ),
                    onTap: () {
                      var cid = "8";
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MyHomePage(cat_id: cid)));
                      //      new MyHomePage()));
                    },
                  ),
                  GestureDetector(
                    child: SingleChildScrollView(
                      child: Container(
                         padding: const EdgeInsets.all(10.0),
                          child: Column(children: <Widget>[
                        // SizedBox(height:20.0),

                        Container(
                         
                          decoration: BoxDecoration(
                          /*  border: Border.all(
                              color:  Color(0xffF6846C),
                              width: 1.0,
                            ),*/
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'assets/img/men.jpg',
                                  fit: BoxFit.fitWidth,
                                   /* width: 150.0,
                                  height: 180.0,*/
                                ),
                               /* SizedBox(
                                  height: 20.0,
                                  child: /*Container(
                                    color:  Color(0xffF6846C),
                                    child: Center(
                                      child: Text('Men',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0)),
                                    ),
                                  ),*/
                                                   Stack(children: <Widget>[
       Positioned(
           bottom: 1.0,
           left: 50.0,
           // child: Text("Welcome to OUTFIT",
           child: Text("Men",
               style: TextStyle(
                   color: Colors.black,
                   fontSize: 15.0,
                   fontWeight: FontWeight.w500))),
     ])
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      ])),
                    ),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new MyHomePage(cat_id: "9")));
                    },
                  ),
               
        
                ],
              ),
            )),
          ),
             
          SizedBox(
            height:20.0,
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.end,

              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text('Latest Collections',
 style: new TextStyle(
                                                              fontSize: 20.0,
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),),
                  ),
                ),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     FlatButton(onPressed:() {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MyHomePage(cat_id: "8")));
                        }, child:   Text('See All',
 style: new TextStyle(
                                                                fontSize: 14.0,
                                                                color: Color(0xff88be4c),
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                              ),),),
                   ],
                 ),
                
              ],
            ),

           SizedBox(
            height:20.0,
          ),
          Container(
            child:Column(children: [
            
                                              FutureBuilder(
        
           future: a,
           
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              ///  snapshot.data.child(product_name).getValue() != null;
              /// print
              print("snapshot.hasData in catego");
             print(snapshot.hasData.toString());
           //   print("snapshot.data"+snapshot.data);
              return snapshot.hasData

                  /*? new ItemList(
                      list: snapshot.data,  
                    )*/
                  ? Container(
                     height: 200.0,
               //     width: double.infinity,
                 
                    child: Row(
        children: <Widget>[
          
          Flexible(
                      child: ListView.builder(
         
                  scrollDirection: Axis.horizontal,
                itemCount: data['data']['products'].length,
         //       itemCount: 4,
         
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                      child: Container(
                          //    color:Colors.red,
                          /* decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),*/
                          child: new Card(
                        // color: Colors.green,
                        child: new Container(
                           width: screenWidth * 0.4,
                          child: GestureDetector(
                            onTap: () {
                             // print(data['data']['products'][index]['price']);
                              print(data['data']['products'].length);
                              print("${data['data']['products'][index]['price']}");
                              print("${data['data']['products'][index]['product_name']}"); 
                            
                              print("${data['data']['products'][index]['product_name']}"); 
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new SingleproductPage(
                        


                                       productprice: "${data['data']['products'][index]['price']}",
                                 
                                          productname: "${data['data']['products'][index]['product_name']}",
                                          productimage: "${data['data']['products'][index]['main_image']}",
                                          productlongdesc: "${data['data']['products'][index]['product_long_desc']}",
                                          producttype: "${data['data']['products'][index]['product_type']}",
                                //            productid:int.tryParse("${data['data']['products'][index]['j2store_product_id']}"),
                                 productid:"${data['data']['products'][index]['j2store_product_id']}",
                                          
                                               )));
                            },
                            child: new Container(
                                //  width: 1500,
                                  //height: 1500,
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    //crossAxisAlignment:        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.network(
                                        imageURL +
                                            '${data['data']['products'][index]['main_image']}',
                                        width: 200.0,
                                        height: 150.0,
                                      ),


                                           Column(
                                               children: [
                                                 Row(
                                                   children: [
                                                     Text(
                                    //    "hai",
                                        "${data['data']['products'][index]['product_name']}",
                                         overflow: TextOverflow.ellipsis,
                                        style: new TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                                   ],
                                                 ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(double.parse("${data['data']['products'][index]['price']}").toStringAsFixed(2),
                                     // Text("${data['data']['products'][index]['price']}",
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                                      ],
                                                    )
                                               ],
                                             ),
                                       //price = double.parse(data['price']).toStringAsFixed(2);
                                    

                               
                                   
                                    ],
                                  ),
                                ),
                          ),
                        ),
                      )),
                  );
                }),
          ),
        ],),
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
            ],)
          ),
                SizedBox(
            height:20.0,
          ),
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.end,

              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text('Sale',
 style: new TextStyle(
                                                              fontSize: 20.0,
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),),
                  ),
                ),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     FlatButton(onPressed:() {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MyHomePage(cat_id: "9")));
                        }, child:   Text('See All',
 style: new TextStyle(
                                                                fontSize: 14.0,
                                                                  color: Color(0xff88be4c),
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                              ),),),
                   ],
                 ),
                
              ],
            ),

           SizedBox(
            height:20.0,
          ),
          Container(
            child:Column(children: [
            
                                              FutureBuilder(
        
           future: b,
           
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              ///  snapshot.data.child(product_name).getValue() != null;
              /// print
              print("snapshot.hasData");
             print(snapshot.hasData.toString());
     
              return snapshot.hasData
 
                  ? Container(
                    height: 200.0
                    ,
                    width: double.infinity,
                    child: Row(
            
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          Flexible(
                      child: ListView.builder(
            
                scrollDirection: Axis.horizontal,
                
               // itemCount: 3,
               itemCount: data['data']['products'].length,
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                      child: Container(
                         
                          child: new Card(
                     
                    
                        child: new Container(
                          width: screenWidth * 0.6,
                          child: GestureDetector(
                            onTap: () {
                             
                              print(data1['data']['products']);
                            
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new SingleproductPage(
                        


                                       productprice: "${data1['data']['products'][index]['price']}",
                                 
                                          productname: "${data1['data']['products'][index]['product_name']}",
                                          productimage: "${data1['data']['products'][index]['main_image']}",
                                          productlongdesc: "${data1['data']['products'][index]['product_long_desc']}",
                                          producttype: "${data1['data']['products'][index]['product_type']}",
                                //            productid:int.tryParse("${data['data']['products'][index]['j2store_product_id']}"),
                                 productid:"${data1['data']['products'][index]['j2store_product_id']}",
                                          
                                               )));
                            },
                            child: new Container(
                            //    width: 500.0,
                              //  height: 500.0,
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment:        CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.network(
                                      imageURL +
                                          '${data1['data']['products'][index]['main_image']}',
                                      width: 200.0,
                                      height: 150.0,
                                    ),
                                       
 Column(
                                             children: [
                                               Row(
                                                 children: [
                                                   Text(
                                  //    "hai",
                                      "${data1['data']['products'][index]['product_name']}",
                                      style: new TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                                 ],
                                               ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(double.parse("${data1['data']['products'][index]['price']}").toStringAsFixed(2),
                                   // Text("${data['data']['products'][index]['price']}",
                                      style: new TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                                    ],
                                                  )
                                             ],
                                           ),
                             
                                 
                                  ],
                                ),
                              ),
                          ),
                        ),
                      )),
                  );
                }),
          ),
        ],),
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
            ],)
          ),
  SizedBox(
            height:20.0,
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.end,

              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text('New Collections',
 style: new TextStyle(
                                                              fontSize: 20.0,
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),),
                  ),
                ),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     FlatButton(onPressed:() {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MyHomePage(cat_id: "8")));
                        }, child:   Text('See All',
 style: new TextStyle(
                                                                fontSize: 14.0,
                                                                  color: Color(0xff88be4c),
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                              ),),),
                   ],
                 ),
                
              ],
            ),
   SizedBox(
            height:20.0,
          ),
          Container(
            child:Column(children: [
            
                                              FutureBuilder(
        
           future: c,
           
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              ///  snapshot.data.child(product_name).getValue() != null;
              /// print
              print("snapshot.hasData");
             print(snapshot.hasData.toString());
     
              return snapshot.hasData
 
                  ? Container(
                    height: 200.0
                    ,
                    width: double.infinity,
                    child: Row(
            
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          Flexible(
                      child: ListView.builder(
            
                scrollDirection: Axis.horizontal,
                
               // itemCount: 3,
               itemCount: data2['data']['products'].length,
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                      child: Container(
                         
                          child: new Card(
                     
                    
                        child: new Container(
                          width: screenWidth * 0.6,
                          child: GestureDetector(
                            onTap: () {
                             
                              print(data2['data']['products']);
                            
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new SingleproductPage(
                        


                                       productprice: "${data2['data']['products'][index]['price']}",
                                 
                                          productname: "${data2['data']['products'][index]['product_name']}",
                                          productimage: "${data2['data']['products'][index]['main_image']}",
                                          productlongdesc: "${data2['data']['products'][index]['product_long_desc']}",
                                          producttype: "${data2['data']['products'][index]['product_type']}",
                                //            productid:int.tryParse("${data['data']['products'][index]['j2store_product_id']}"),
                                 productid:"${data2['data']['products'][index]['j2store_product_id']}",
                                          
                                               )));
                            },
                            child: new Container(
                            //    width: 500.0,
                              //  height: 500.0,
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment:        CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.network(
                                      imageURL +
                                          '${data2['data']['products'][index]['main_image']}',
                                      width: 200.0,
                                      height: 150.0,
                                    ),
                                         
                        Column(
                                             children: [
                                               Row(
                                                 children: [
                                                   Text(
                                  //    "hai",
                                      "${data2['data']['products'][index]['product_name']}",
                                      style: new TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                                 ],
                                               ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                   //   Text(double.parse("${data2['data']['products'][index]['price']}").toStringAsFixed(2),
                                   Text("${data2['data']['products'][index]['price']}",
                                      style: new TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                                    ],
                                                  )
                                             ],
                                           ),
                                  ],
                                ),
                              ),
                          ),
                        ),
                      )),
                  );
                }),
          ),
        ],),
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
            ],)
          ),


        ],

      )
      ),
    );
  }
}
