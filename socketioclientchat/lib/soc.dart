 import 'package:flutter/material.dart';
 
//import 'package:flutter_socket_io/socket_io_manager.dart' as ;
import 'package:socket_io_client/socket_io_client.dart';
 
 
class Socketconn extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  _Socketconn createState() => _Socketconn();
}

class _Socketconn extends State<Socketconn> {
    Socket socket; //initalize the Socket.IO Client Object 
void initializeSocket() {
  print("hi inside initializeSocket");
      socket =
          io(
            "https://production-build.herokuapp.com",
            
             //"http://127.0.0.1:3000/", 
            <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": true,
      });
  print("socket.connected b4") ;

      socket.connect();  //connect the Socket.IO Client to the Server
  print("socket.connected aftr");

      //SOCKET EVENTS
      // --> listening for connection 
      socket.on('connect', (data) {  
        print("socket.connected"+socket.connected.toString());
   sendMessage( "message") ;

      });

      //listen for incoming messages from the Server. 
      socket.on('message', (data) {
     sendMessage( "message") ;
       print(data); //
      });
    

      //listens when the client is disconnected from the Server 
      socket.on('disconnect', (data) {
        print('disconnect');
      });
  }
     sendMessage(String message) {
       print("inside send msg");
      socket.emit("message",
        {
          "id": socket.id,
          "message": message, //--> message to be sent
          "username": "div",
          "sentAt": DateTime.now().toLocal().toString().substring(0, 16),
        },
      );
  }
  @override
  void initState() {
    super.initState();
    initializeSocket(); //--> call the initializeSocket method in the initState of our app.
  }

  @override
  void dispose() {
    socket.disconnect(); // --> disconnects the Socket.IO client once the screen is disposed 
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("ijijij"),
      ),
    );
  }
}