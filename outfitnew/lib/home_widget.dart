import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sampleproject/cart.dart';
import 'package:sampleproject/categories.dart';
import 'package:sampleproject/login.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'listcategory.dart';


/*class Home1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home1> {
  int _currentIndex = 0;
  int _selectedIndex;

    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
switchBody(){
    if (_selectedIndex == 0) {
      print("navigate to Categories");
      
      return Categories(title: 'Outfit');
    } else if (_selectedIndex == 1) {
      print("navigate to search");

      return Text('Inside Search');
    } else if (_selectedIndex == 2) {
      print("navigate to cart");

      return Cart();
    }
  }
  navigate(){
    print("inside nav");
  Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new Categories(title: 'OutFit'),
    ));

  }
    void initState() {
    super.initState();
    
 //   this.navigate();
 
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  /*    appBar: AppBar(
        title: Text('Flutter Bottem Nav'),
      ),*/
      body: switchBody(),
      bottomNavigationBar: BottomNavigationBar(
           onTap: (index) => _onItemTapped(index),
        //currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Cart')
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
*/
 

class HomePage1 extends StatefulWidget {
  HomePage1({Key key}) : super(key: key);

  @override
  HomePage1State createState() => HomePage1State();
}

class HomePage1State extends State<HomePage1> {
  int selectedIndex = 0;
  final widgetOptions = [
  Categories(),
 Categorylist(),
  Center(child: Text('search screen')),
  Cart(),
   // Cart(),
    //Cart(),
  ];
    SharedPreferences sharedPreferences;
    var accesstoken;
    String loginname="";
  checklogin() async {
         sharedPreferences = await SharedPreferences.getInstance();
  //  accesstoken = sharedPreferences.getString("accesstoken").toString();
      accesstoken = sharedPreferences.getString("accesstoken") ?? "_";
    print("accesstoken"+accesstoken);
    if(accesstoken=="_"){
print("insode if");
setState(() {
  loginname ="Login";
});

    }
    else{
      print("inside else");
      setState(() {
         loginname ="Logout";
      });
    }
  }
  Widget createDrawerBodyItem(
   {IconData icon, String text, GestureTapCallback onTap}) {
 return ListTile(
   title: Row(
     children: <Widget>[
       Icon(icon),
       Padding(
         padding: EdgeInsets.only(left: 8.0),
         child: Text(text),
       )
     ],
   ),
   onTap: onTap,
 );
}
  Widget createDrawerHeader() {
 return DrawerHeader(
     margin: EdgeInsets.zero,
     padding: EdgeInsets.zero,
     decoration: BoxDecoration(
         image: DecorationImage(
             fit: BoxFit.fill,
             image:  AssetImage('assets/img/logo.png')
              //Image.asset('assets/img/logo.png',height: 150.0,width: 150.0,),
             )),
     child: Stack(children: <Widget>[
       Positioned(
           bottom: 12.0,
           left: 16.0,
           // child: Text("Welcome to OUTFIT",
           child: Text("",
               style: TextStyle(
                   color: Colors.white,
                   fontSize: 20.0,
                   fontWeight: FontWeight.w500))),
     ])
     );
}
    void initState() {
    super.initState();

 checklogin();
  
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey,
       appBar: AppBar(
         backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(
                Icons.blur_on,
                size: 35.0,
                color: Color(0xff88be4c),
              ),
              onPressed: () {
               // eventBus.fire('drawer');
             
                _scaffoldKey.currentState.openDrawer();
              },
            ),
        title: Center(
          child: Text('Outfit',
            style: new TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: InkResponse(

                    child: Icon(Icons.search,color: Colors.blueGrey,),
                    onTap: () {
                      
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            createDrawerHeader(),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home,color: Colors.black),
              ),
            ),
             InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.info, color: Colors.black),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Profile'),
                leading: Icon(Icons.person,color: Colors.black),
              ),
            ),
             InkWell(
              onTap: () {
                  Navigator.of(context).push(
               new MaterialPageRoute(
                   builder: (BuildContext context) =>
                       new Categorylist()));
              },
              child: ListTile(
                title: Text('Category List'),
                leading: Icon(Icons.person,color: Colors.black),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket,color: Colors.black),
              ),
            ),
            InkWell(
              onTap: () {
                if(loginname == "Login"){
                  print("loginname == login");

setState(() {
    Navigator.of(context).push(
               new MaterialPageRoute(
                   builder: (BuildContext context) =>
                       new Login()));
});
                }
                   
                       else{ 

                         print("loginname != login");
 
                         setState(() {
                            Navigator.of(context).pushReplacement(
               new MaterialPageRoute(
                   builder: (BuildContext context) =>
                       new SplashScreen()));
                         });
 
                       }
              },
              child: ListTile(
             //   title: Text('Login'),
             title: Text(loginname),
                leading: Icon(Icons.lock_open,color: Colors.black),
              ),
            ),
           
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Contact'),
                leading: Icon(
                  Icons.contacts,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(color: Colors.black,),
        ListTile(
                leading:   
                 IconButton(
        icon:   Icon(FontAwesomeIcons.facebook,
        size: 20,), onPressed: () {  }, 
       
    ),
                title: const Text("Facebook"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebView(
                        url: "https://www.facebook.com",
                        title: "Facebook",
                      ),
                    ),
                  );
                },
              ),
                 ListTile(
                leading:   
                 IconButton(
     // Use the FontAwesomeIcons class for the IconData
       icon:   Icon(FontAwesomeIcons.instagram,
        size: 20,), onPressed: () {  }, 
       
    ),
                title: const Text("Instagram"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebView(
                        url: "https://www.instagram.com",
                        title: "Instagram",
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      body: Container(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
       // items: <BottomNavigationBarItem>[
 items: [
          BottomNavigationBarItem( icon: Icon(Icons.home), title: Text('Home')),
          // BottomNavigationBarItem( icon: Icon(Icons.portable_wifi_off), title: Text('Categories')),
        //  BottomNavigationBarItem(icon: Icon(Icons.pie_chart_outlined), title: Text('Categories')),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Search')),
          BottomNavigationBarItem( icon: Icon(Icons.shopping_cart), title: Text('Cart')),
           
        ],
        currentIndex: selectedIndex,
      //  fixedColor: Colors.deepPurple,
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
 

class WebView extends StatefulWidget {
  final String url;
  final String title;

  WebView({Key key, this.title, @required this.url}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      withJavascript: true,
      url: widget.url,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      //  backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        title: Text(widget.title ?? ''),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Center(child: Container(child: CircularProgressIndicator())),
    );
  }
}
