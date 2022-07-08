import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Bill extends StatefulWidget {
  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {
  String accesstoken;
  SharedPreferences sharedPreferences;

  //Completer<WebViewController> _controller = Completer<WebViewController>();

  //String url = "https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token=$accesstoken&mobile=mobile&currency=''&tmpl=component";
//print("url+ $url");
  void getlocalstorage() async {
    sharedPreferences = await SharedPreferences.getInstance();
    accesstoken = sharedPreferences.getString("accesstoken").toString();
    print(accesstoken);
  }

  void initState() {
//    getauthcart();
    getlocalstorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(),
      /* WebView(
        initialUrl:
            'https://w3cert.net/outfit/index.php?option=com_j2store&view=checkout&access_token=$accesstoken&mobile=mobile&currency='
            '&tmpl=component',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),*/
    );
  }
}
