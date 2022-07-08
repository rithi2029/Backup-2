import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_view/gallery_view.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ims/LeadRegister/leadregister.dart';
import 'package:ims/Leaddetails/Leaddetails.dart';
import 'package:ims/Login/login.dart';
import 'package:ims/const/constant.dart';
import 'package:http/http.dart' as http;
import 'package:ims/leadedit/leadedit.dart';
import 'package:ims/onboardscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:intl/intl.dart';

class ProductimagegalleryScreen extends StatefulWidget {
  var id;
  var category_name;
  @override
  ProductimagegalleryScreen({this.id,this.category_name});
  _ProductimagegalleryScreenState createState() => _ProductimagegalleryScreenState();
}

class _ProductimagegalleryScreenState extends State<ProductimagegalleryScreen> {
  var leadresponse = [];
  var lead_source = [];
  var lead_accountindustries = [];

  String msg = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 // Map _product_image = {};
  var _product_image = [];

  final formKey = GlobalKey<FormState>();
  var accesstoken;

  SharedPreferences sharedPreferences;
  var _productlist =[];
   getproductslist() async {
    print("inside getproductslist");
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("access_token") ?? "_";
    print("accesstoken" + accesstoken);
    if (accesstoken == "_") {
      print("insode if no access token ");
    } else {
       
      print("inside else" + accesstoken);

      Uri url = Uri.parse(siteurl + "api/productgallery");

      print("urlurlurl" + url.toString());
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
            // {
            //     resBody
            /*"name": resBody[i]['name'],
              "user_id": resBody[i]['user_id'],
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
              "created_from": resBody[i]['created_from'],*/
            // "location_latitude": resBody[i]['location_latitude'],
            //"location_longitude": resBody[i]['location_longitude'],
            // "updated_at": resBody[i]['updated_at'],
            //  "created_at":resBody[i]['created_at'],
            //}
            //  );
            _productlist.add(resBody[i]);

            setState(() {
              if (_productlist[i]['status'] == "0") {
                setState(() {
                  _productlist[i]['status'] = "Available";
                  contcolor = Colors.blue;
                });
              } else if (_productlist[i]['status'] == "1") {
                setState(() {
                  _productlist[i]['status'] = "Unavailable";
                  //  contcolor = Colors.teal;
                });
              }
            });
          }
        });

        print("lead_accountindustries id is" + _productlist.toString());
        print(_productlist.toString());
        setState(() {});
        return _productlist;
      } else if (response.statusCode == 401) {
        sharedPreferences = await SharedPreferences.getInstance();
        accesstoken = sharedPreferences.setString("access_token", "_");

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
var _galllery_img  =[];
var _gallery_id = [];
var _galllery_img1  =[];
  getproductsimages() async {
    print("inside getproductsimages" + widget.id.toString());
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("access_token") ?? "_";
    print("accesstoken" + accesstoken);
    if (accesstoken == "_") {
      print("insode if no access token ");
    } else {
      print("inside else" + accesstoken);

      Uri url = Uri.parse(siteurl + "api/productgallery");

      print("urlurlurlurl" + url.toString());
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      });
      if (response.statusCode == 200) {
        setState(() {
          var resBody = json.decode(response.body);
          _product_image = json.decode(response.body);
          setState(() {
            for(int k =0;k< _product_image.length;k++){
     _galllery_img.add(_product_image[k]['galleryitems']);
            }
       
          });
          setState(() {
              for(int j =0;j<_galllery_img[0].length;j++){
          print("ji");
          _galllery_img1.add(_galllery_img[0][j]['gallery_image']);
_gallery_id.add(_galllery_img[0][j]['category_id']);
        }
          });
        print(_galllery_img[0].length.toString());
      
        print("jdkdk"+_galllery_img1[0].toString());

          print("resBodyresBodyresBody" + resBody.toString());
//print("_gallery_id[index]"+_gallery_id[0].toString());
          /*for (int i = 0; i < resBody.length; i++) {
            _product_image.add(resBody[i]);
          }*/
        });
      //  print("_product_image_product_image" + _product_image.toString());
//http://humbletree.in/lms/api/products/2
        return _product_image;
      } else if (response.statusCode == 401) {
        sharedPreferences = await SharedPreferences.getInstance();
        accesstoken = sharedPreferences.setString("access_token", "_");

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

  Uint8List _bytesImage;

  Future a;
  initState() {
    a = getproductsimages();
    // getleadlist();

    super.initState();
  }

  int dynamiccrosscount = 1;

  var contcolor = Colors.white;
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
        title: Text(widget.category_name.toString()),
        //title: Text("Product Gallery"),
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
                  
                      ? 
                      Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                   GridView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                  //1,
                                      _gallery_id.length,
                                  //  itemCount: 1,
                                  gridDelegate:
                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                 //   crossAxisCount: dynamiccrosscount,
                                     crossAxisCount: 2,
                                       crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                         //   crossAxisCount: 2,
                                   childAspectRatio: MediaQuery.of(context)  .size  .width /
                                        (MediaQuery.of(context).size.height /
                                            2.2),
                                  /*  mainAxisSpacing: 20.0,

                                    crossAxisSpacing: 20.0,*/
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    //itemCount: _product_image["productimage"].length,
                                   // _bytesImage = Base64Decoder().convert(  "${_product_image["productimage"][index]["images"]}");
                                        //print("imgurlimgurlimgurl"+"https://humbletree.in/lms/storage/uploads/product/${_product_image["productimage"][index]["product_id"]}/${_product_image["productimage"][index]["images"]}".toString());
                              
                                    return new Container(
                                      color: Color(maincolor),
                                      //height: 300.0,
                                      child:  Card(
                            elevation: 10.0,
                            child: new Container(
                              padding: EdgeInsets.all(8.0),
                           
                                  
                                  child: InkWell(
                                    onTap: (){
                                       Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return DetailScreen(
                                  productimage: "https://humbletree.in/sales/storage/uploads/gallery/${_gallery_id[index]}/${_galllery_img1[index]}"
                                );
                              }));
                                    },
                                    child: Flexible(
                                      child: Image.network( "https://humbletree.in/sales/storage/uploads/gallery/${_gallery_id[index]}/${_galllery_img1[index]}",
                                                        height: 150.0,
                                                        width: screenWidth/2 ,
                                                        fit: BoxFit.cover,
                                                         ),
                                    ),
                                  )
                                 /* GalleryView(
                               // crossAxisCount:2,
                                //_gallery_id.length ,
                                    imageUrlList: [
                                    "https://humbletree.in/sales/storage/uploads/gallery/${_gallery_id[index]}/${_galllery_img1[index]}",
                          ],
                                    key: null, //key: null,
                                  ),*/
                               // ),
                          
                          //          ]),
                            ),
                          ),
                    
                                    );
                                  }),
                       
                    /*  FutureBuilder(
                        future: a,
                        builder: (context, snapshot) {
                          return Card(
                            elevation: 10.0,
                            child: new Container(
                              padding: EdgeInsets.all(10.0),
                              color: Color(maincolor),
                              height: 300.0,
                              child: Row(children: [
                                for(int i = 0;i<_product_image["galleryitems"].length;i++)
                                Expanded(
                                  
                                  child: GalleryView(
                                crossAxisCount: 1,
                                    imageUrlList: [
                                      "https://humbletree.in/sales/storage/uploads/gallery/${_product_image[0]["galleryitems"][i]["category_id"]}/${_product_image[0]["productimage"][i]["gallery_image"]}",
                          ],
                                    key: null, //key: null,
                                  ),
                                ),
                          
                                /*Container(
                                      height: 300.0,
                                      width: 200.0,
                                      child: Image.memory(_bytesImage
                                       
                                        
                            
                                        /*  Container(
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
                                                        "${_product_image[index]['status']}",
                                                      ),
                                                      // "${_product_image[index]['name']}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      // softWrap: false,
                                                      style:
                                                          new TextStyle(
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
                                      */
                                      )
                                    )
                                  */
                              ]),
                            ),
                          );
                        }
                      ),*/
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
class DetailScreen extends StatefulWidget {
  String productimage;

  @override
  DetailScreen({
    this.productimage,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.productimage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
         
        //title: Text("Product Gallery"),
      ),
     
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.productimage,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

