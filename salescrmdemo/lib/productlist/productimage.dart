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
import 'package:ims/const/constant.dart';

//import 'package:intl/intl.dart';

class ProductimageScreen extends StatefulWidget {
  var id;
  @override
  ProductimageScreen({this.id});
  _ProductimageScreenState createState() => _ProductimageScreenState();
}

class _ProductimageScreenState extends State<ProductimageScreen> {
  var leadresponse = [];
  var lead_source = [];
  var lead_accountindustries = [];

  String msg = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map _product_image = {};

  final formKey = GlobalKey<FormState>();
  var accesstoken;

  SharedPreferences sharedPreferences;
  getproductsimages() async {
    print("inside getproductsimages" + widget.id.toString());
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("access_token") ?? "_";
    print("accesstoken" + accesstoken);
    if (accesstoken == "_") {
      print("insode if no access token ");
    } else {
      print("inside else" + widget.id.toString());

      Uri url = Uri.parse(siteurl + "api/products/${widget.id}");

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
          print("resBodyresBodyresBody" + resBody.toString());

          /*for (int i = 0; i < resBody.length; i++) {
            _product_image.add(resBody[i]);
          }*/
        });
        print("_product_image_product_image" + _product_image.toString());
        if(_product_image['productimage'].length == 0){
          setState(() {
            displaynoimgmsg = true;
            dispimggrid = false;

          });
        }
        else{
          setState(() {
            displaynoimgmsg = false;
            dispimggrid = true;

          });
        }
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
bool displaynoimgmsg = false;
bool dispimggrid = false;
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
        title: Text("Product Gallery"),
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
                  print("_product_imagesize" +
                      _product_image["productimage"].toString());
                                                //      print("length"+_product_image["productimage"].length.toString());

/*if(_product_image["productimage"] == null){

}
else{
  
}*/
 /* if (_product_image.length == 0)
                                  Center(
                                      child: Text(
                                    "No image",
                                    style: TextStyle(color: Colors.black),
                                  ));*/
                  if (snapshot.hasData == true) {
                    
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Visibility(
                            visible: displaynoimgmsg,
                            child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150.0,
                        ),
                        new Center(
                          child: new Text("No Image Available"),
                        ),
                      ],
                    ),
                          ),
                          Visibility(
                            visible:dispimggrid,
                            child: Card(
                              elevation: 10.0,
                              child: new Container(
                                padding: EdgeInsets.all(10.0),
                                color: Color(maincolor),
                                height: 300.0,
                                child: Row(
                                  children: [
                                  //_product_image["productimage"]
                                

                                  for (int i = 0;
                                      i < _product_image["productimage"].length;
                                      i++)
                                    Expanded(
                                      child: GalleryView(
                                        crossAxisCount: 1,
                                        imageUrlList: [
                                          //https://sales.humbletree.in/storage/uploads/product/10/image20220121064732.jpeg
                                          imgurl +
                                              "/${_product_image["productimage"][i]["product_id"]}/${_product_image["productimage"][i]["image"]}",
                                        ],
                                        key: null, //key: null,
                                      ),
                                    ),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } /*else if (_product_image["productimage"].length == 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150.0,
                        ),
                        new Center(
                          child: new Text("No Image"),
                        ),
                      ],
                    );
                  } */else if(snapshot.hasData == true && _product_image["productimage"].length == 0){
                     return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150.0,
                        ),
                        new Center(
                          child: new Text("No Image"),
                        ),
                      ],
                    );}
                    else{

                    return Column(
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
                  }
                  /*return snapshot.hasData == true
                      ? Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                elevation: 10.0,
                                child: new Container(
                                  padding: EdgeInsets.all(10.0),
                                  color: Color(maincolor),
                                  height: 300.0,
                                  child: Row(children: [
                                    //_product_image["productimage"]
                                    for (int i = 0;
                                        i <
                                            _product_image["productimage"]
                                                .length;
                                        i++)
                                      Expanded(
                                        child: GalleryView(
                                          crossAxisCount: 1,
                                          imageUrlList: [
                                            //https://sales.humbletree.in/storage/uploads/product/10/image20220121064732.jpeg
                                            imgurl +
                                                "/${_product_image["productimage"][i]["product_id"]}/${_product_image["productimage"][i]["image"]}",
                                          ],
                                          key: null, //key: null,
                                        ),
                                      ),

                          ]),
                                ),
                              ),
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
                        );*/
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
