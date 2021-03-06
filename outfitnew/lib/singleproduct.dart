import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sampleproject/cart.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SingleproductPage extends StatefulWidget {
  String productname, productimage, productlongdesc, producttype, productprice;
  String productid;

  @override
  SingleproductPage({
    this.productprice,
    this.productimage,
    this.productname,
    this.productlongdesc,
    this.productid,
    this.producttype,
  });
  @override
  _SingleproductPageState createState() => _SingleproductPageState();
}

class _SingleproductPageState extends State<SingleproductPage> {
  final formKey = GlobalKey<FormState>();
  //bool _validate = false;
  bool _validate = true;
  final scaffoldkey = GlobalKey<ScaffoldState>();

  static const String imageURL = "https://w3cert.net/outfit/";
  SharedPreferences sharedPreferences;
  int len, len1, optionIndex, optionvalueIndex;
  int qty = 1;
  List dropDownValues = [];
// List flexidropDownValues = [];
  List dropDownValues1 = [];
  var flexidropDownValues;
  //dynamic data = [];
  dynamic data = "";
  List drop_data = List();
  //List<Map> options= [];
  //List data2 = List();
List data2 = [];
List data3 = List();
  List data1 = List();
  String selectedSalutation;
  String _dropDownValue;
  bool displayaddtocart = false;
  bool displayprice = false;
//List  items;
//List<int> items = List<int>.generate(data2.length, (i) => "Item $i");

// final items = List<String>.generate(data2.length, (i) => "$i");
  List<String> myList = List<String>();

  // String _dropDownValue1;
  // String dropdownValuecolor, dropdownValuesize;
  String cart_id;
  //dynamic data1;

  List option_value1 = List();
  dynamic option_value = [];
  List selected_ddvalue = [];
  int i;
  int k;
  bool visibledropdown = false;
  bool visibleconfigdropdown = false;
  bool visibleflexdropdown = false;
  var list = new List();
  var variant_id;

  //List<Map> _myJson = [];
  Map<String, dynamic> map;
  Map<String, dynamic> map1;
  // Map<String, dynamic> data3;
  //String msg = "";
  String msg = '';
  String msg1 = '';
  String price = '';
  checkproducttype() {
    print(widget.producttype);

    if (widget.producttype == 'simple') {
      setState(() {
        displayaddtocart = true;
        displayprice = true;
      });
    } else if (widget.producttype == 'variable') {
      setState(() {
        displayaddtocart = true;
        displayprice = true;
      });
    } else if (widget.producttype == 'configarable') {
    } else if (widget.producttype == 'flexivariable') {}
  }

  Future<String> checkvarient1(dropDownValues1, i) async {
    print("inside check varient1111");
    print("dropDownValues1".toString());
    print(i);
    print(dropDownValues1[i]);
  }

  Future<String> checkvarient(i, myList) async {
    print("inside check varient");
    print("qty" + qty.toString());
    print(myList);
    print("pid" + widget.productid.toString());
    print("select id");
    print("dropdownvalue1[i]");
    print(dropDownValues1[i]);

    List index = new List();
    var id;
    for (k = 0; k < data['data']['product']['options'].length; k++) {
      id = data['data']['product']['options'][k]['productoption_id'];
      index.add(id);
      print(index);
    }
    Map newMap = {};
    for (k = 0; k < data['data']['product']['options'].length; k++) {
      print(dropDownValues1[k]);
      newMap["product_option[${index[k]}]"] = dropDownValues1[k].toString();
      print('RCB');
      print(dropDownValues1[k].toString());
    }

    print("new map0");
    print(newMap);

    // print(dropDownValues[k]);
    var quty = qty.toString();
    var pid = widget.productid;

    //product_option[18]=1&product_option[19]=3
    /*final response = await http.get(
        "http://w3cert.net/outfit/index.php/en/?option=com_j2store&view=product&task=update&$newMap&product_qty=$quty&product_id=$pid&option=com_j2store&ajax=1&cfe93d81c3fbe682d5e2f12acdaff1b6=1&product_id=$pid&_=160334299430");
*/

//product_option[18]=1&product_option[19]=3
    int j;
    Map newMap1 = {};
    print('RCB1');
    for (j = 0; j < data['data']['product']['options'].length; j++) {
      //  newMap["product_option[${index[k]}]"] = dropDownValues[k].toString();
      print(dropDownValues1);
      newMap1["product_option[${index[j]}]"] = dropDownValues1.toString();

      //   print(dropDownValues[k].toString());
    }
    print("object11111");
    print(newMap1);
    final response = await http.get(
        "http://w3cert.net/outfit/index.php/en/?option=com_j2store&view=product&task=update&product_option[18]=1&product_option[19]=3&product_qty=$quty&product_id=$pid&option=com_j2store&ajax=1&cfe93d81c3fbe682d5e2f12acdaff1b6=1&product_id=$pid&_=160334299430");

    if (response.statusCode == 200) {
      print('response.body:' + response.body);
      //print(object);
      data = json.decode(response.body);
      print(data);
      var data1 = data['error'];
      //print(data1);
      //  print("error" + data['error']);
      variant_id = data['variant_id'];
      print(variant_id);
      msg = data['error'];
      price = data['price'];
      if (msg != "Variant not available") {
        print("inside if Variant available");
        setState(() {
          variant_id = data['variant_id'];

          displayaddtocart = true;
          msg = "varient available";
          price = data['price'];
          var num1 = 10.12345678;
          price = double.parse(data['price']).toStringAsFixed(2);
          //   double num2 =  price.toStringAsFixed(2);
          //    print(num2);
          msg1 = price;
//var num2 = double.parse(price.toStringAsFixed(2));
//print(num2.toString());
          // var f = new NumberFormat("###.0#", "en_US");
//print(f.format(price));
          //  var num1 = 10.12345678;
          //price = double.parse(data['price'].toStringAsFixed(2)); // num2 = 10.12
        });
      } else {
        setState(() {
          msg = data['error'].toString();
          msg = data1.toString();
          print("msg" + msg);
        });
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  /*
    http://w3cert.net/outfit/index.php/en/component/j2store/carts/addItem?Itemid=192
    */

  Future checkproducttypeinsertproduct() {
    print("checkproducttypeinsertproduct");

    if (widget.producttype == "flexivariable") {
      print(widget.producttype);

      insertflexivariableproduct(i);
    } else if (widget.producttype == "variable") {
      insertvariableproduct(i);
    }
/*  else if(widget.producttype == "configrable")
{
 
}*/
    else if (widget.producttype == "simple") {
      print(widget.producttype);
      insertsimpleproduct();
    }
  }

  /*   Future getData() async {
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
  }*/
   //Future<http.Request> getProduct() async {
    // Future getProduct() async {
 Future  getProduct() async {
    print('Inside getProduct');
    print(widget.productid);
    var url  = "http://w3cert.net/outfit/index.php/api/v1/product/${widget.productid}";
    final response = await  http.get(Uri.encodeFull(url), 
     headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print('response.body:' + response.body);
      this.setState(() {
        data = json.decode(response.body);
      });
//print(data);
      /*  if (widget.producttype == "variable") {
        print("variable");
        map = json.decode(response.body);
        print(map);
        for (k = 0; k < data['data']['product']['options'].length; k++) {
          if (data['data']['product']['options'][k]['type'] == "select") {
            print("type is select inside variable");
            print(data['data']['product']['options'][k]['optionvalue'].length);
            print(data['data']['product']['options'][k]['productoption_id']);
            setState(() {
              visibledropdown = true;
              data2 = map['data']['product']['options'];
              // options = map['data']['product'];
              len1 =
                  data['data']['product']['options'][k]['optionvalue'].length;
              len = data['data']['product']['options'].length;
              for (int i = 0; i < data2.length; i++) {
                dropDownValues.add(data2[i]['optionvalue'][i]['product_optionvalue_id']);
              }
            });
          } else {
            print("other type");
            setState(() {
              visibledropdown = false;
            });
          }
        }
      }*/
      if (widget.producttype == "variable") {
        map1 = json.decode(response.body);
        print(map1);
        for (k = 0; k < data['data']['product']['options'].length; k++) {
          if (data['data']['product']['options'][k]['type'] == "select") {
            print("type is select");
            print(data['data']['product']['options'][k]['optionvalue'].length);
            print(data['data']['product']['options'][k]['productoption_id']);
            setState(() {
              print("jhoii");
              visibledropdown = true;
              data2 = map1['data']['product']['options'];
              //print(data2);
              // options = map['data']['product'];
            /*  len1 =
                  data['data']['product']['options'][k]['optionvalue'].length;
              len = data['data']['product']['options'].length;*/
            for (int i = 0; i < data2.length; i++) {
                dropDownValues.add(data2[i]['optionvalue'][i]['product_optionvalue_id']);
              }
            });
          } else {
            print("other type");
            setState(() {
              visibledropdown = false;
            });
          }
        }
      } else if (widget.producttype == "flexivariable") {
        print(" getting product inside else if flexivariable product");
        print("product type" + widget.producttype);

        map = json.decode(response.body);
        print(map);
        for (k = 0; k < data['data']['product']['options'].length; k++) {
          if (data['data']['product']['options'][k]['type'] == "select") {
            print("type is select");
            print(data['data']['product']['options'][k]['optionvalue'].length);
            print(data['data']['product']['options'][k]['productoption_id']);
            setState(() {
              for (i = 0; i < data2.length; i++) {
                flexidropDownValues = data3[i]['option_value'];
                print(flexidropDownValues);
                flexidropDownValues.forEach(
                  (opt) =>
                      //      print("opt"),
                      // print("opt"+'${opt['j2store_optionvalue_id']}'),
                      // dropDownValues.add(data2[i]['optionvalue'][i]['product_optionvalue_id']);
                      dropDownValues1.add('${opt['j2store_optionvalue_id']}'),
                );
              }
              //
              visibleflexdropdown = true;
              data3 = map['data']['product']['options'];
              myList = List<String>.generate(data3.length, (i) => "$i");
              //    items = List<String>.generate(data2.length, (i) => "$i");
              // print(items);
              print(data3);
              print('usrMap');

              for (i = 0; i < data2.length; i++) {
                dropDownValues.add(data3[i]['optionvalue'][i]['product_optionvalue_id']); //b4crct
                // dropDownValues.add(data2[i]['option_value'][i]['j2store_optionvalue_id']);
              }
              //    print(flexidropDownValues);
              /*   for (int i = 0; i < data2.length; i++) {  
                for (k = 0; k < data['data']['product']['options'].length; k++) {

                       print("data2.length");
                       print(k);
                
        print(data2[i]['option_value'][i]['j2store_optionvalue_id']);

            //   dropDownValues.add(data2[i]['optionvalue'][i]['product_optionvalue_id']); //crct b4
              flexidropDownValues.add(data2[i]['option_value'][k]['j2store_optionvalue_id']);
     // dropDownValues.add(data2[i]['optionvalue'][k]['optionvalue_id']);
              
               
              }}*/
              //   print("flexidropDownValues"+flexidropDownValues.toString());

              // )
              // print(dropDownValues);
            });
          } else {
            print("other type");
            setState(() {
              visibleflexdropdown = false;
            });
          }
        }
      } /*else if (widget.producttype == "configurable") {
        print("inside config product display ");
        map = json.decode(response.body);
        print(map);
        for (k = 0; k < data['data']['product']['options'].length; k++) {
          if (data['data']['product']['options'][k]['type'] == "select") {
            print("type is select");
            print(data['data']['product']['options'][k]['optionvalue'].length);
            print(data['data']['product']['options'][k]['productoption_id']);
            setState(() {
              visibleconfigdropdown = true;
              data2 = map['data']['product']['options'];
              print(data2);

              for (i = 0; i < data2.length; i++) {
                //dropDownValues.add(data2[i]['optionvalue'][i]['product_optionvalue_id']); //b4crct
                // dropDownValues.add(data2[i]['option_value'][i]['j2store_optionvalue_id']);
              }
            });
          } else {
            print("other type");
            setState(() {
              visibleconfigdropdown = false;
            });
          }
        }
      } */
      else {
        print("check product type inside else simple product");

        print("product type" + widget.producttype);

        setState(() {
          visibledropdown = false;
        });
      }
      return json.decode(response.body);
//return map;

    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

//variant_id
  Future<String> insertflexivariableproduct(i) async {
    print(i);
    print("inside insertflexivariableproduct func");
    print("qty" + qty.toString());
    print("pid" + widget.productid.toString());
    print("select id");
    print(dropDownValues.toString());
    var id;
    sharedPreferences = await SharedPreferences.getInstance();
    cart_id = sharedPreferences.getString("cartid") ?? "_";
    List index = new List();
    for (k = 0; k < data['data']['product']['options'].length; k++) {
      id = data['data']['product']['options'][k]['productoption_id'];
      index.add(id);
      print(index);
      // print(index[i]);
      print("k value" + k.toString());
    }

    // if (widget.producttype == "variable") {
    print("flexi variable prodct");
    if (cart_id == "_") {
      print("cart_id is null");

      Map payload = {};

      Map newMap = {};
      for (k = 0; k < data['data']['product']['options'].length; k++) {
        // newMap["product_option[${index[k]}]"] = dropDownValues[k].toString();
        newMap = {"product_option[18]": "1", "product_option[19]": "3"};
      }
      print(newMap);
      // {product_option[18]: 38, product_option[19]: 41}

      payload = {
        "product_id": widget.productid.toString(),
        "product_qty": qty.toString(),
        "cart_id": "",
        "variant_id": "58",
//"product_option[18]": "1",
//"product_option[19]": "3"
      };
      payload.addAll(newMap);
      print(payload);
      final response = await http.post(
        "https://w3cert.net/outfit/index.php/api/v1/cart",
        body: payload,
      );

      print('response.body' + response.body);
      this.setState(() {
        data = json.decode(response.body);
      });
      print(data);
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        sharedPreferences.setString("cartid", data["cart_id"].toString());
        //sharedPreferences.commit();
      });
      //  });
      // navigate1();
    } else {
      print("cart_id have value");

      sharedPreferences = await SharedPreferences.getInstance();

      Map payload = {};
      //  List payload = [];
      Map list1 = {};
      Map newMap = {};
      for (k = 0; k < data['data']['product']['options'].length; k++) {
        // id = data['data']['product']['options'][k]['product_optionvalue_id'];
        //  newMap["product_option[${index[k]}]"] = dropDownValues[k].toString();
        //     print(k);
        newMap = {"product_option[18]": "1", "product_option[19]": "3"};
      }
      payload = {
        "product_id": widget.productid.toString(),
        "product_qty": qty.toString(),
        "cart_id": sharedPreferences.getString("cartid").toString(),
        "variant_id": "58",
        // "product_option[18]": "1",
//"product_option[19]": "3"
      };
      payload.addAll(newMap);
      print(payload);
      final response = await http.post(
        "https://w3cert.net/outfit/index.php/api/v1/cart",
        body: payload,
      );
      print('response.body' + response.body);
      this.setState(() {
        data = json.decode(response.body);
      });
      // print( "product_option[$id]" );
      print(data);
      //  print( "product_option[$id]" )
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        sharedPreferences.setString("cartid", data["cart_id"].toString());
        //sharedPreferences.commit();
      });
      // });
// }
      // navigate1();
    }
  }

  Future<String> insertvariableproduct(i) async {
    print(i);
    print("inside insertvariableproduct func");
    print("qty" + qty.toString());
    print("pid" + widget.productid.toString());
    print("select id");
    print(dropDownValues.toString());
    var id;
    sharedPreferences = await SharedPreferences.getInstance();
    cart_id = sharedPreferences.getString("cartid") ?? "_";
    List index = new List();
    print(data['data']['product']['options'].length);
    print(data['data']['product']['options'][0]['productoption_id']);
    for (k = 0; k < data['data']['product']['options'].length; k++) {
      id = data['data']['product']['options'][k]['productoption_id'];
      index.add(id);
      print(index);
      // print(index[i]);
      print("k value" + k.toString());
    }

    // if (widget.producttype == "variable") {
    print("variable prodct");
    if (cart_id == "_") {
      print("cart_id is null in variable prod");

      Map payload = {};

      Map newMap = {};
      for (k = 0; k < data['data']['product']['options'].length; k++) {
        newMap["product_option[${index[k]}]"] = dropDownValues[k].toString();
      }
      print("variable prodct new map value");
      print(newMap);
      payload = {
        "product_id": widget.productid.toString(),
        "product_qty": qty.toString(),
        "cart_id": "",
      };
      payload.addAll(newMap);
      print("payload" + payload.toString());
      final response = await http.post(
        "https://w3cert.net/outfit/index.php/api/v1/cart",
        body: payload,
      );

      print('response.body' + response.body);
      this.setState(() {
        data = json.decode(response.body);
      });
      print(data);
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        sharedPreferences.setString("cartid", data["cart_id"].toString());
        //sharedPreferences.commit();
      });
      //  });
      // navigate1();
    } else {
      print("cart_id have value in variable prod");

      sharedPreferences = await SharedPreferences.getInstance();

      Map payload = {};
      //  List payload = [];
      Map list1 = {};
      Map newMap = {};
      for (k = 0; k < data['data']['product']['options'].length; k++) {
        // id = data['data']['product']['options'][k]['product_optionvalue_id'];
        newMap["product_option[${index[k]}]"] = dropDownValues[k].toString();
        //     print(k);

      }
      payload = {
        "product_id": widget.productid.toString(),
        "product_qty": qty.toString(),
        "cart_id": sharedPreferences.getString("cartid").toString(),
      };
      payload.addAll(newMap);
      print(payload);
      final response = await http.post(
        "https://w3cert.net/outfit/index.php/api/v1/cart",
        body: payload,
      );
      print('response.body111' + response.body);
      this.setState(() {
        data = json.decode(response.body);
      });
      // print( "product_option[$id]" );
      print(data);
      //  print( "product_option[$id]" )
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        sharedPreferences.setString("cartid", data["cart_id"].toString());
        //sharedPreferences.commit();
      });
      // });
// }
      // navigate1();
    }
  }

  Future insertsimpleproduct() async {
    //simple product
    print("inside insertsimpleproduct");
    print(widget.producttype);
    print("simple product");
    sharedPreferences = await SharedPreferences.getInstance();
    cart_id = sharedPreferences.getString("cartid") ?? "_";
    print(cart_id);
    if (cart_id == "_") {
      print("cart_id is null");

      final response = await http
          .post("https://w3cert.net/outfit/index.php/api/v1/cart", body: {
        'product_id': widget.productid.toString(),
        'product_qty': qty.toString(),
        'cart_id': ""
      }); //whenComplete(() => navigate1());
      print('response.body' + response.body);
      this.setState(() {
        data = json.decode(response.body);
      });
      print(data);
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        sharedPreferences.setString("cartid", data["cart_id"].toString());
        //sharedPreferences.commit();
      });
      print(sharedPreferences.getString("cartid").toString());
      print(data["cart_id"]);
      navigate1();
    } else {
      print("cart_id have value");
      print("cccccidddd");
      print(data["cart_id"]);
      sharedPreferences = await SharedPreferences.getInstance();
      print(
        sharedPreferences.getString("cartid").toString(),
      );
      final response = await http
          .post("https://w3cert.net/outfit/index.php/api/v1/cart", body: {
        'product_id': widget.productid.toString(),
        'product_qty': qty.toString(),
        'cart_id': sharedPreferences.getString("cartid").toString(),
      });
      print('response.body' + response.body);
      this.setState(() {
        data = json.decode(response.body);
      });
      print(data);

      navigate1(); //rm yds
    } //sproduc
  }

  getlocalstorage() async {
    print("inside getlocalstorage");
    sharedPreferences = await SharedPreferences.getInstance();
    cart_id = sharedPreferences.getString("cartid").toString();
    print(cart_id);
  }

  navigate1() async {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new Cart(),
    ));
  }

  Future a;
  bool _autovalidate = true;
  void initState() {
    //   print(widget.productprice);
    /*  print(widget.productid);
     print(widget.productlongdesc);
      print(widget.productname);
       print(widget.productprice);*/

    //   myList= List<String>.generate(data2.length, (i) => "$i");
    checkproducttype();
    a = getProduct();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder(
            //child: FutureBuilder(
           // future: a,
             future: getProduct(),
            //    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            builder: (BuildContext context, AsyncSnapshot  snapshot) {
              // builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              print("snapshot.hasData1");
              print(snapshot.hasData);
              print(snapshot.data);
              if (snapshot.hasData) {
                return Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: Form(
                          key: formKey,
                          autovalidate: _validate,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  Image.network(
                                    imageURL + widget.productimage,
                                    //'${data['data']['products'][index]['main_image']}',
                                    width: 500.0,
                                    height: 300.0,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                     Visibility(
                                    child: Column(children: [
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                         width: 200.0,
                                        child: Column(
                                          children: [
                                            Column(children: [
                                         
                                              for (i = 0; i < data3.length; i++)
                    
                                              
                                                Column(
                                                  children: [
                                                      Text(data3[i]['option_name']),
                                                     SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    DropdownButtonFormField<
                                                            String>(
 
                                                        hint: Text(
                                                          'Select',
                                                        ),
                                                   
                                                        items: data3[i]
                                                                ['option_value']
                                                            .map<
                                                                    DropdownMenuItem<
                                                                        String>>(
                                                                (optionValue1) {
                                                         
                                                          return DropdownMenuItem<
                                                              String>(
                                                                
                                                         
                                                            child: Text(optionValue1[
                                                                'optionvalue_name']),
                                                             value: optionValue1['j2store_optionvalue_id'],
                                                           );

                                                        }).toList(),
                                                        validator: (value) =>
                                                            value == null
                                                                ? 'field required'
                                                                : null,
                                                         onChanged: (newValue) {
                                                          print("insode on change");
                                                          print(i);
                                                        
                                                       
                                                        for( i=0;i<data2.length;i++){
                                          //  myList.insert(i,newValue);  

                                         //  myList[i] = newValue; //=>> intha newvalues variable la namba yatha select panurom oh athoda id varum pa 
                                          myList[i] =  dropDownValues1[i]; //=> intha variable la [1234] irukum paa
                                                         }
                                                         
                                               // List.insertAll([Itearble])
                                                       //   myList.;
                                                        //  myList.add(newValue);
                                                        print("myList");
                                                          print(myList);
                                                      
                                                        
                                                          print("newValue" +
                                                              newValue);
                                                          setState(() {
                                                          dropDownValues1[i] = newValue;
                                                    
                                                          });
                                                         

                                                          if (formKey.currentState
                                                              .validate()) {
                                                                  formKey.currentState.save();
                                                            print(
                                                                "inside formKey.currentState.validate");
                                                            print(newValue);
                                                       print(myList);
                                                            print(dropDownValues1[i]);
                                                           checkvarient1(dropDownValues1[i],i);
                                                          }
                                                        })
                                                  ],
                                                )
                                            ]),
                                            // _actionDropDown(data2[i]('optionvalue'))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        msg,
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                    ]),
                                    visible: visibleflexdropdown,
                                  ),
                                 Visibility(
                                    child: Column(children: [
                                      Container(
                                        width: 200.0,
                                        child: Column(
                                          children: [
                                     //       Text("data"),
                                           Column(children: [
                                              for (i = 0; i < data2.length; i++)
                                                //  print("object");
                                                Column(
                                                  children: [
                                                    Text(data2[i]['option_name']),
                                                    DropdownButtonFormField<
                                                            String>(
                                                        items: data2[i]
                                                                ['optionvalue']
                                                            .map<
                                                                    DropdownMenuItem<
                                                                        String>>(
                                                                (optionValue1) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            child: Text(optionValue1[
                                                                'optionvalue_name']),
                                                            value: optionValue1[
                                                                'product_optionvalue_id'],
                                                          );
                                                        }).toList(),
                                                        validator:
                                                            (String value) {
                                                          if (value?.isEmpty ??
                                                              true) {
                                                            return 'Please ${data2[i]['option_name']}';
                                                          }
                                                          return null;
                                                        },
                                                        value: dropDownValues[i],
                                                        onChanged: (newValue) {
                                                          print(
                                                              "newValue of variable product " +
                                                                  newValue);
                                                          //print("selected dropDownValues value"+selected_ddvalue[i]);
                                                          setState(() {
                                                            dropDownValues[i] =
                                                                newValue;
                                                            // selected_ddvalue[i] =newValue;
                                                          });
                                                          print(
                                                              dropDownValues[i]);
                                                          //print( selected_ddvalue[i] );
                                                        })
                                                  ],
                                                )
                                            ]),
                                            // _actionDropDown(data2[i]('optionvalue'))
                                          ],
                                        ),
                                      )
                                    ]),
                                    visible: visibledropdown,
                                  ),

 
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        //  flex: 10,
                                        child: Text(
                                          //    "divya",
                                          //map['data']['product']['options']
                                          "Name : " + widget.productname,
                                          //  "${map['data']['product']['product_name']}",
                                          //  "Name : " + "${data['data']['product']['product_name']}",
                                          //  "Name : " "${data['data']['product']['product_name']}",
//"Name : " +"${data['data']['product']['options']['productoption_id']}",
                                          textAlign: TextAlign.start,
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          "Description : " +
                                              widget.productlongdesc,
                                          //   "${data['data']['product']['product_long_desc']}",
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  /*   Row(
                            children: <Widget>[
                              Expanded(
                                flex: 7,
                                child: Text(
                                  "Price : ??? " + widget.productprice,
                                  //data['data']['products']['price'],
                                  style: new TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                        ),*/
                                  Visibility(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 7,
                                          child: Text(
                                            "Price : ??? " +
                                           double.parse(widget.productprice).toStringAsFixed(2),
                                   
                                                //widget.productprice.toString(),
                                            //data['data']['products']['price'],
                                            style: new TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    visible: displayprice,
                                  ),
                                  Visibility(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 7,
                                          child: Text(
                                            "Price : ??? " + price.toString(),
                                            //data['data']['products']['price'],
                                            style: new TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    visible: displayaddtocart,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "Quantity : ",
                                        style: new TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      new IconButton(
                                        icon: new Icon(Icons.remove),
                                        onPressed: () => setState(() {
                                          // qty = int.tryParse(qty.toString());
                                          qty--;
                                        }),
                                      ),
                                      new Text(
                                        qty.toString(),
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      new IconButton(
                                        icon: new Icon(Icons.add),
                                        onPressed: () => setState(() {
                                          // qty = int.tryParse(qty.toString());
                                          qty++;

                                          new Text(
                                            qty.toString(),
                                            style: new TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    child: new RaisedButton(
                                        child: new Text(
                                          "Add to Cart",
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        color: Colors.lightBlue,
                                        onPressed: () {
                                          if (formKey.currentState.validate()) {
                                            formKey.currentState.save();
                                            checkproducttypeinsertproduct();
                                          } else {
                                            // validation error
                                            scaffoldkey.currentState
                                                .showSnackBar(SnackBar(
                                              content: Text("Failed to Add Cart"),
                                            ));
                                            setState(() {
                                              _validate = true;
                                            });
                                          }
                                        }),
                                    visible: displayaddtocart,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 150.0),
                    //Text("data"),
                    new Center(
                      child: new CircularProgressIndicator(),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
