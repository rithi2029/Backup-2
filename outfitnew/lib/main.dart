import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sampleproject/singleproduct.dart';
import 'package:sampleproject/splashscreen.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  //  MaterialColor colorCustom = MaterialColor(0xffF6846C, color);
  MaterialColor colorCustom = MaterialColor(0xff88be4c, color);
    return MaterialApp(
        
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       // primarySwatch: Colors.white,
      
   primarySwatch: colorCustom,
        //  Color(0xFF45A1C9),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //   home: MyHomePage(title: 'Flutter Demo Home Pag
     // home: Home1(),
     home:SplashScreen(),
         //  home: HomePage1(),
           );

    
  }
}

class MyHomePage extends StatefulWidget {
  
  final String cat_id;
//MyHomePage({Key key}) : super(key: key);
MyHomePage({Key key, this.cat_id}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic data = [];
  static const String imageURL = "https://w3cert.net/outfit/";

  //Future<List<Map<String, dynamic>>>  getData() async {

  int _currentIndex = 0;
  /* final List<String> images = [
    'https://w3cert.net/outfit/images/themeparrot/clothing_products_11.png',
        'https://w3cert.net/outfit/images/themeparrot/clothing_products_11.png',
  ];*/
  /*Future<String> getTitle() async {
    var res = await http
        .get(Uri.encodeFull(), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody; //This line changed from data = resBody[" "];
    });

    return "Success!";
}*/
  //Future<http.Request> getData() async {\
  Future a;
     Future getData() async {
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
  }
/*
  Widget infoProduct = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(item.name ?? '',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1),
        const SizedBox(height: 6),
        Wrap(
          children: <Widget>[
            Text(
              item.type == 'grouped'
                  ? '${S.of(context).from} ${Tools.getPriceProduct(item, currencyRate, currency, onSale: true)}'
                  : priceProduct == '0.0'
                      ? S.of(context).loading
                      : Tools.getPriceProduct(item, currencyRate, currency,
                          onSale: true),
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: priceFontSize,
                    color: theme.accentColor,
                  ),
            ),
            if (isSale) ...[
              const SizedBox(width: 5),
              Text(
                item.type == 'grouped'
                    ? ''
                    : Tools.getPriceProduct(item, currencyRate, currency,
                        onSale: false),
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: priceFontSize,
                      color: Theme.of(context).accentColor.withOpacity(0.6),
                      decoration: TextDecoration.lineThrough,
                    ),
              ),
            ]
          ],
        ),
        const SizedBox(height: 3),
        Align(
          alignment: Alignment.bottomLeft,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (kAdvanceConfig['showStockStatus'] &&
                        !item.isEmptyProduct())
                      item.backOrdered != null && item.backOrdered
                          ? Text(
                              '${S.of(context).backOrder}',
                              style: const TextStyle(
                                color: kColorBackOrder,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            )
                          : Text(
                              item.inStock
                                  ? S.of(context).inStock
                                  : S.of(context).outOfStock,
                              style: TextStyle(
                                color: item.inStock
                                    ? kColorInStock
                                    : kColorOutOfStock,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                    const SizedBox(height: 2),
                    if (kAdvanceConfig['EnableRating'])
                      if (kAdvanceConfig['hideEmptyProductListRating'] ==
                              false ||
                          (item.ratingCount != null && item.ratingCount > 0))
                        SmoothStarRating(
                            allowHalfRating: true,
                            starCount: 5,
                            rating: item.averageRating ?? 0.0,
                            size: starSize,
                            color: kColorRatingStar,
                            borderColor: kColorRatingStar,
                            label: Text(
                              item.ratingCount == 0 || item.ratingCount == null
                                  ? ''
                                  : '${item.ratingCount}',
                              style: TextStyle(
                                fontSize: ratingCountFontSize,
                              ),
                            ),
                            spacing: 0.0),
                  ],
                ),
                const SizedBox(width: 10),
                if (showCart &&
                    !item.isEmptyProduct() &&
                    item.inStock &&
                    item.type != "variable")
                  IconButton(
                      icon: Icon(Icons.add_shopping_cart, size: iconSize),
                      onPressed: () {
                        String message =
                            addProductToCart(product: item, context: context);
                        _showFlashNotification(item, message, context);
                      }),
              ],
            ),
          ),
        ),
      ],
    );*/
  void initState() {
  /*  WidgetsBinding.instance.addPostFrameCallback((_) {
      // print(img1);
    });*/
    a=getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
          final screenSize = MediaQuery.of(context).size;
    final screenWidth =screenSize.width / (2 / (screenSize.height / screenSize.width));
    return Scaffold(
      
       appBar: AppBar(
         backgroundColor: Color(0xff88be4c),
         leading: InkResponse(

                    child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
        title: Text('Products',
          style: new TextStyle(
            fontSize: 22.0,
            color: Colors.white,
         //   fontWeight: FontWeight.bold,
          ),
        ),

        actions: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: InkResponse(

                    child: Icon(Icons.menu,color: Colors.white,),
                    onTap: () {
                      
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      //resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
          child:FutureBuilder(
          //child: FutureBuilder(
           future: a,
            //  future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              ///  snapshot.data.child(product_name).getValue() != null;
              /// print
              print("snapshot.hasData");
             print(snapshot.hasData.toString());
           //   print("snapshot.data"+snapshot.data);
              return snapshot.hasData

                  /*? new ItemList(
                      list: snapshot.data,  
                    )*/
                  ? Container(
                    child: Column(
            
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          GridView.builder(
              shrinkWrap: true,
              primary: false,
              //  padding: const EdgeInsets.all(10.0),
              scrollDirection: Axis.vertical,
              itemCount: data['data']['products'].length,
            //  itemCount: data.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (3/ 5),
              ), //itemBuilder: null
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                    child: Container(
                           width: screenWidth * 0.9,
                                 height:  screenWidth * 2,
                            //    color:Colors.red,
                            /* decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),*/
                            child: new Card(
                          // color: Colors.green,
                          child: new Container(
                              child: GestureDetector(
                                onTap: () {
                                  print(data['data']['products']);
                                  print("${data['data']['products'][index]['price']}");
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
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: new Container(
                                     // width: 1500,
                                     width: screenWidth * 0.9,
                                     height:  screenWidth * 0.9,
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.start,
                                        //crossAxisAlignment:        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Flexible(
                                                                                              child: Container(
                                                  child:Column(
                                                    children: [
                                                      Image.network(
                    imageURL +
                      '${data['data']['products'][index]['main_image']}',
                     width: screenWidth * 0.6,
                                     height:  screenWidth * 0.7,
                                                ),
                                               /*   IconButton(
        onPressed: () {
          
          setState(() {});
        },
        icon: CircleAvatar(
         // backgroundColor: Colors.white.withOpacity(0.3),
          child: Icon(FontAwesomeIcons.heart,
           //   color: Theme.of(context).accentColor.withOpacity(0.5),
              size:   1.0),
        ),
      ),*/
                                                    ],
                                                  )
                                                ),
                                              ),
                                              
                                            ],
                                          ),

                                     /*      Stack(children: <Widget>[
       Positioned(
           bottom: 12.0,
           left: 16.0,
            child: Text("Welcome to OUTFIT",
        /*   child:  
                                           IconButton(
        onPressed: () {
          
          setState(() {});
        },
        icon: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.3),
          child: Icon(FontAwesomeIcons.heart,
              color: Theme.of(context).accentColor.withOpacity(0.5),
              size:   16.0),
        ),
      ),*/
           ),)
     ]),*/
       

                                          
                       Padding(
                       padding: const EdgeInsets.all(3.0),
                       child: Container(
                         child: Row(
                           children: [
                               Text(
                                        //    "hai",
                    "${data['data']['products'][index]['product_name']}",
                    style: new TextStyle(
                      fontSize: 13.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                                          ),
                           ],
                         ),
                       ),
                       ),
    Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        child: Row(
                           children: [
                               Text(
                    //    "hai",
                    //data['data']['products'][index]['price']
                                          double.parse("${data['data']['products'][index]['price']}").toStringAsFixed(2),
                                          
                      //"${data['data']['products'][index]['price']}",
                      style: new TextStyle(
                        fontSize: 13.0,
                        color: Colors.blueGrey,
                       // fontWeight: FontWeight.bold,
                      ),
                      ),
                      Spacer(),
                                  IconButton(
            icon: Icon(
              Icons.add_shopping_cart,
            ),
            iconSize: 18.0,
            color: Colors.black,
           // splashColor: Colors.purple,
            onPressed: () {
              print("object");
            },
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
                        )),
                );
              }),
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
          
           /*Column(
            
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          GridView.builder(
              shrinkWrap: true,
              primary: false,
              //  padding: const EdgeInsets.all(10.0),
              scrollDirection: Axis.vertical,
              itemCount: data['data']['products'].length,
            //  itemCount: data.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (5 / 5),
              ), //itemBuilder: null
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
                      child: GestureDetector(
                        onTap: () {
                       //   print("${data['data']['products'][index]['product_name']}"); 
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new SingleproductPage(
                                    /*
productprice:"",
productname:"",
productimage:"",
productlongdesc:"",
producttype:"",
productid:"".toString(),*/

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
                            width: 1500,
                            height: 1500,
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
                                     Text(
                              //    "hai",
                                  "${data['data']['products'][index]['product_name']}",
                                  style: new TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                         
                             
                              ],
                            ),
                          ),
                      ),
                    ),
                  )),
                );
              }),
        ],
      )*/
      ),
     
       );
  }
}
