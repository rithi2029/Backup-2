import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
//import 'package:flutter_socket_io/socket_io_manager.dart' as ;
import 'package:socket_io_client/socket_io_client.dart';
import 'dart:convert';
import './User.dart';
import './Message.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;


class ChatModel extends Model {
  List<User> users = [
    User('IronMan', '111'),
    User('Captain America', '222'),
    User('Antman', '333'),
    User('Hulk', '444'),
    User('Thor', '555'),
  ];

  User currentUser;
  List<User> friendList = List<User>();
  List<Message> messages = List<Message>();
  SocketIO socketIO;
 createchat() async {
   print("Hi inside the create chat function");
  //  var url = _getOAuthURL("POST", "token", 3);
    var url = Uri.parse("https://production-build.herokuapp.com/api/chatList/createChat");
 print(url);
  
    var response = await http.post(url, headers: {
     // 'Content-type': 'application/json',
      //'Accept': 'application/json',
    },
        //  headers: {"Accept": "application/json"},
        body: {
          "sendTo": "61c00d7130cfc00023dbea13".toString(),
          
        });
    print("responseeee");
    print(response.body.toString());
    print(response.statusCode);
 
  
    if (response.statusCode == 200) {
      print('response.body:' + response.body.toString());

      //  Navigator.pop(context);
    } else {
      print(response.statusCode);
     
  }}
  Socket socket;
    // Listen to Location updates of connected usersfrom server
  handleLocationListen(Map<String, dynamic> data) async {
    print(data);
  }
  // Listen to update of typing status from connected users
  void handleTyping(Map<String, dynamic> data) {
    print(data);
  }
    // Listen to all message events from connected users
  void handleMessage(Map<String, dynamic> data) {

   
    print(data);
  }
  void init() {
    currentUser = users[0];
    friendList =
        users.where((user) => user.chatID != currentUser.chatID).toList();

    this.socketIO = SocketIOManager().createSocketIO(
        'https://production-build.herokuapp.com', '/',
        query: 'chatID=${currentUser.chatID}');
    socketIO.init();

    socketIO.subscribe('receive_message', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      messages.add(Message(
          data['content'], data['senderChatID'], data['receiverChatID']));
      notifyListeners();
    });

    socketIO.connect();
    socketIO.sendMessage("event", "message");
  }

 /* void init(){
    print("hihlo");
  /*  Socket socket = io('https://production-build.herokuapp.com', 
    OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .enableAutoConnect()  // disable auto-connection
      .setExtraHeaders({'foo': 'bar'}) // optional
      .build()
  );
socket.connect();
   socket.onConnect((_) {
     print('init connect');
     socket.emit('msg', 'test');
    });*/
    socket = io("https://production-build.herokuapp.com", <String, dynamic>{
'transports': ['websocket'],
'autoConnect': true,
});
socket.connect();
socket.on('connect', (_) {
  print("Socket connect");
});

  }
  */
  /*void init()
{
  print("hi from inint");
   currentUser = users[0];
    friendList =
        users.where((user) => user.chatID != currentUser.chatID).toList();
    try {
     
      // Configure socket transports must be sepecified
      /*socket = io('https://production-build.herokuapp.com', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });*/
     IO.Socket socket = IO.io('https://production-build.herokuapp.com', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
});
    
// Dart client
socket.on('connect', (_) {
    print('connect');
});
socket.on('event', (data) => print(data));
socket.on('disconnect', (_) => print('disconnect'));
socket.on('fromServer', (_) => print(_));

// add this line
socket.connect();
   socket.emit("dummy","hi");
      // Connect to websocket
        print("hi from  socket.connect");
    /*  socket.connect();
            socket.on('connect', (_) => print('connect: ${socket}'));
            print('connect: ${socket}');
            
  /*    socket.on('location', handleLocationListen);
      socket.on('typing', handleTyping);
      socket.on('message', handleMessage);*/
      socket.on('message', (data) => createchat);
     // socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_+"fromServer".toString()));*/

     
      // Handle socket events
    /*  socket.on('connect', (_) => print('connect: ${socket.id}'));
      socket.on('location', handleLocationListen);
      socket.on('typing', handleTyping);
      socket.on('message', handleMessage);
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));*/
  //    socket.emit("event","");
   
        print("hi from  dummy.connect");

    } catch (e) {
      print(e.toString());
    }

} 

*/
/*void init() {
  /*  currentUser = users[0];
    friendList =
        users.where((user) => user.chatID != currentUser.chatID).toList();

    socketIO = SocketIOManager().createSocketIO(
        'https://production-build.herokuapp.com', '/',
        query: 'chatID=${currentUser.chatID}');
    socketIO.init();
    print("currentUser.chatIDcurrentUser.chatID"+currentUser.chatID.toString());

    socketIO.subscribe('receive_message', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      print("jsondata"+data.toString());
      print("data['senderChatID']"+data['senderChatID'].toString());
            print("data['senderChatID']"+data['senderChatID'].toString());

      print("data['receiverChatID']"+data['receiverChatID'].toString());

      print("data['content']"+data['content'].toString());
      messages.add(Message(
          data['content'], data['senderChatID'], data['receiverChatID']));
      notifyListeners();
    });

    socketIO.connect();*/
     // Socket socket;
     try {
     
      // Configure socket transports must be sepecified
      s = io('https://production-build.herokuapp.com', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
     
      // Connect to websocket
      socketIO.connect();
     socketIO.emit("dummy", "hiiiii");
      //("dummy","hi");

     
      // Handle socket events
    /*  socket.on('connect', (_) => print('connect: ${socket.id}'));
      socket.on('location', handleLocationListen);
      socket.on('typing', handleTyping);
      socket.on('message', handleMessage);
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));*/

    } catch (e) {
      print(e.toString());
    }

   
  }*/
   
  }

  /*void sendMessage(String text, String receiverChatID) {
    print("currentUser"+currentUser.toString());
    messages.add(Message(text, currentUser.chatID, receiverChatID));
    socketIO.sendMessage(
      'send_message',
      json.encode({
        'receiverChatID': receiverChatID,
        'senderChatID': currentUser.chatID,
        'content': text,
      }),
    );
    notifyListeners();
  }

  List<Message> getMessagesForChatID(String chatID) {
    return messages
        .where((msg) => msg.senderID == chatID || msg.receiverID == chatID)
        .toList();
  }*/
//}