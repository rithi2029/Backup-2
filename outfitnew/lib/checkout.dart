import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_widget.dart';
 

//import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
class Checkout extends StatefulWidget {
  String url;
  @override
  Checkout({
    this.url,
  });
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  SharedPreferences sharedPreferences;
    StreamSubscription<String> _onUrlChanged;
  TextEditingController coupon = new TextEditingController();
  //final flutterWebviewPlugin = new FlutterWebviewPlugin();

  dynamic data = [];
  static const String com_j2store = "com_j2store";
  static const String checkout = "checkout";
  static const String component = "component";
  static const String mobile = "mobile";
  //static const String com_j2store = "com_j2store";
  //  InAppWebViewController webView;
  String url = "";
  double progress = 0;
  String cart_id = "";
  static const String imageURL = "https://w3cert.net/outfit/";
  var list = new List();
  var accesstoken;
  String grandtotal = "";
  String url1;
  //https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token='+localaccesstoken+'&mobile=mobile&currency='+currencycode+'&tmpl=component
  openBrowserTab() async {
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("accesstoken").toString();
    print("accesstoken" + accesstoken);
    // url1 = "https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=checkout&access_token=$accesstoken&mobile='mobile'&currency=''&tmpl='component'";
    setState(() {
      url1 =
          "https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=checkout&access_token=$accesstoken&mobile='mobile'&currency=''&tmpl='component'";
    });
    //await FlutterWebBrowser.openWebPage(url: url1, androidToolbarColor: Colors.deepPurple);
  }

  InAppWebViewController webView;
  Future lurl() async {
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("accesstoken").toString();
    print("accesstoken" + accesstoken);
    String url1 =
        "https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=checkout&access_token=$accesstoken&mobile='mobile'&currency=''&tmpl='component'";
    /*
https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=checkout&access_token=%27+IzvOYaW2aMnrfLAuh9Gm4oN9XQ3J5kagnXL4HAkm+%27&mobile=mobile&currency=%27+currencycode+%27&tmpl=component%27,%20%27_self%27,%20%27hideurlbar=yes,location=no%27);
 https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=checkout&access_token=%27+5VcRMtvpwHBfwEayESqOyKs9Rq6TlzUvpmlLyFju+%27&mobile=mobile&currency=%27+currencycode+%27&tmpl=component%27,%20%27_self%27,%20%27;
 
 */

    print(url1);
  }
/*
checkout url

https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=myprofile&mobile=mobile
 */
  Future<void> _launchInBrowser1() async {
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("accesstoken").toString();
    print("accesstoken" + accesstoken);
//  String url1 = "https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token=${accesstoken}&mobile=mobile&currency=''&tmpl=component&"

    //const browser = this.iab.create('
    //https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token='+IzvOYaW2aMnrfLAuh9Gm4oN9XQ3J5kagnXL4HAkm+'&mobile=mobile&currency='+currencycode+'&tmpl=component', '_self', 'hideurlbar=yes,location=no');
    //String url1 = "https://w3cert.net/outfit/index.php?option='com_j2store'&view='checkout'&access_token=$accesstoken&mobile='mobile'&currency=''&tmpl='component'";
    //  String url1 = "https://w3cert.net/outfit/index.php/en/component/j2store/checkout?option=com_j2store&view=checkout&access_token=$accesstoken&mobile='mobile'&currency=''&tmpl='component'";
//IzvOYaW2aMnrfLAuh9Gm4oN9XQ3J5kagnXL4HAkm
/*
https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=checkout&access_token=%27+IzvOYaW2aMnrfLAuh9Gm4oN9XQ3J5kagnXL4HAkm+%27&mobile=mobile&currency=%27+currencycode+%27&tmpl=component%27,%20%27_self%27,%20%27hideurlbar=yes,location=no%27);
 */
    String url1 =
        "https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=checkout&access_token=$accesstoken&mobile='mobile'&currency=''&tmpl='component'";

    print(url1);
    //https://w3cert.net/outfit/index.php/en/component/j2store/checkout
    //  js.context.callMethod("open", [url1]);
   // flutterWebviewPlugin.close();
    //flutterWebviewPlugin.launch(url1);

//html.window.location.href ="https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token=$accesstoken&mobile=mobile&currency=''&tmpl=component";
  }

  Future<void> _launchInBrowser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("accesstoken").toString();
    print(accesstoken);

    //String url = "https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token=PFG5f1zjqZx4ySgesB2Lg7i7f4AVgmRCxe7mqJUK&mobile=mobile&currency=''&tmpl=component";
//print("url+ $url");
    var queryParameters = {
      'option': 'com_j2store',
      'view': 'checkout',
      'access_token': '$accesstoken',
      'mobile': 'mobile',
      'currency': '',
      'tmpl': 'component'
    };
    Uri uri = Uri.https('www.w3cert.net', 'outfit/index.php', queryParameters);
//  String url1 = "https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token=${accesstoken}&mobile=mobile&currency=''&tmpl=component&"

    //const browser = this.iab.create('
    //https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token='+localaccesstoken+'&mobile=mobile&currency='+currencycode+'&tmpl=component', '_self', 'hideurlbar=yes,location=no');
    String url1 =
        "https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token=$accesstoken&mobile=mobile&currency=''&tmpl=component";
    print(url1);
    String url = uri.toString();
    print(uri.toString());
    final String encodedURl = Uri.encodeFull(url1);
    print("encodeurl" + encodedURl);

    ///html.window.open(url1, 'new tab');
//html.window.location.href ="https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token=$accesstoken&mobile=mobile&currency=''&tmpl=component";//

/*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebView(url1
                                          //url: "https://businessmela.com/my-account/",
                                        
                                          ),
                                    ));*/
    /*if (await canLaunch(encodedURl)) {
      await launch(
      //  encodedURl,
      url1,
        forceSafariVC: true,
        forceWebView: true,
      //  headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }*/
  }

  void initState() {
    print(widget.url);
    //  openBrowserTab();
    super.initState();
  }
      /*if(this.url =="https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=myprofile&mobile=mobile"){
                                  print("insideif");
                                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) => new Categories(),
    ));
                              }
                              else{
                                print("inside else");
                              }*/
   void dispose() {
    // Every listener should be canceled, the same should be done with this stream.

    //flutterWebviewPlugin.dispose();
   _onUrlChanged.cancel();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              Container(
                  //   height:double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                        height: 2000.0,
//width: 500.0,
                        // margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)),
                        child: InAppWebView(
                          initialUrl: widget.url,
                        // initialUrl: "https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=checkout&access_token=%27+N8NSirEdsMVTHgD3YmfY6ZTp2wFPW2vdRcnxiUw9+%27&mobile=mobile&currency=%27+currencycode+%27&tmpl=component",
                          initialHeaders: {},
                          initialOptions: InAppWebViewGroupOptions(
                              crossPlatform: InAppWebViewOptions(
                            debuggingEnabled: true,
                          )),
                          onWebViewCreated:
                              (InAppWebViewController controller) {
                            print("onWebViewCreated" + widget.url);
                            print(controller);
                            webView = controller;
                          },
                          
                          onLoadStart:
                              (InAppWebViewController controller, String url) {
                            /*    _urlLoadingListner(url,context);
                                setState(() {
                                  this.redirecturl = url;
                                }); */
                            setState(() {
                              print("divya");
                              print(this.url);
                              print("onLoadStart" + this.url);
                              this.url = url;
                            });
                          },
                          onLoadStop: (InAppWebViewController controller,
                              String url) async {
                                if(this.url =="https://w3cert.net/outfit/index.php/en/?option=com_j2store&view=myprofile&mobile=mobile"){
                                  print("insideif of onstop");
                                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
     
      builder: (BuildContext context) => new HomePage1(),
    ));
                              }
                              else{
                                print("inside else");
                                  print("onLoadStop inside else" + this.url);
                          
                              this.url = url;
                              }
                            setState(() {
                              print("onLoadStop" + this.url);
                          
                              this.url = url;
                            });
                            
                          },
                     
                          onProgressChanged: (InAppWebViewController controller,
                              int progress) {
                            setState(() {
                              this.progress = progress / 100;
                            });
                          },
                          // ignore: missing_return
        
                         /* shouldOverrideUrlLoading: (InAppWebViewController controller, String url) {
             // LogUtil.v("shouldOverrideUrlLoading $url");
          }*/
                        ),
                      ),
                    ),
                    // ),
                  ])),
              new RaisedButton(
                  child: new Text(
                    "Checkout",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  color: Colors.lightBlue,
                  onPressed: () {
                    openBrowserTab();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
