import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class ChatPage extends StatefulWidget {
  String name; 
   ChatPage({super.key , required this.name});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  IO.Socket? socket; 

  @override
  initState(){
    super.initState();
    connect();
  }

  connect(){
    socket = IO.io("http://192.168.0.113:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    
    print("we are here"); 
    socket!.onConnect((_){
      print("connected fronted to backed"); 
      // sending msg 
       socket!.emit('sendMsg','test emit event');
    });
    socket!.onError((error) {
  print('Socket error: $error');
});
    socket!.connect();
    print("socket isnot working");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5D9FE),
      appBar: AppBar(
        title: const Text("groupchat"),
      ),
      body: Column(
        children:const [
           SizedBox(height: 10),
           Expanded(
            child: Text("chats"),
          ),
          bottomTextField(), 

           SizedBox(height: 5)
        ],
      ),
    );
  }
}

class bottomTextField extends StatelessWidget {
  const bottomTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                // color: Color(0xFFD5D9FE),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  const BoxShadow(
                    color: Color.fromARGB(255, 166, 86, 153),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset:  Offset(-5, 2),
                  ),
                  BoxShadow(
                    color:const Color.fromARGB(39, 0, 0, 0)..withOpacity(.1),
                    offset: const Offset(-8, 8),
                  )
                ]),
            child: const TextField(
              decoration: InputDecoration(
                  // fillColor: Color(0xFFD5D9FE),
                  // filled: true,
                  // border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //     borderSide:
                  //         BorderSide(width: 0, color: Colors.white)),

                  border: InputBorder.none,
                  hintText: "nothing"),
            ),
          )),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.send)
        ],
      ),
    );
  }
}
