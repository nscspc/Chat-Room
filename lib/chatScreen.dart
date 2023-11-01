import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nodejschatapp_cwh/Message.dart';
import 'package:nodejschatapp_cwh/chatController.dart';
import 'package:nodejschatapp_cwh/notificationDesign.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'MessageItem.dart';

// ignore: camel_case_types
class chatScreen extends StatefulWidget {
  const chatScreen({Key? key}) : super(key: key);

  @override
  State<chatScreen> createState() => _chatScreenState();
}

// ignore: camel_case_types
class _chatScreenState extends State<chatScreen> {
  TextEditingController msgInputController = TextEditingController();
  TextEditingController nameInputController = TextEditingController();
  late IO.Socket socket;
  // late String name;
  ChatController chatController = ChatController();
  //  = IO.io(
  //     'http://localhost:4000',
  //     IO.OptionBuilder()
  //         .setTransports(['websocket'])
  //         .disableAutoConnect()
  //         .build());

  @override
  void initState() {
    // socket = IO.io('http://localhost:4000');
    // socket.onConnect((_) {
    // print('connect');
    //   // socket.emit('msg', 'test');
    // });
    // print("yr");
    socket = IO.io(
        'http://localhost:8000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();

    // socket.onConnect((_) {
    print('connect');
    // });
    // socket.emitWithAck('msg', 'init', ack: (data) {
    // print('ack $data');
    //     if (data != null) {
    // print('from server $data');
    //     } else {
    // print("Null");
    //     }
    // });
    // });

    setUpSocketListener();

    // setUpSocketListener2();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.purple,
                  controller: nameInputController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                      ),
                      child: IconButton(
                        onPressed: () {
                          sendName(nameInputController.text);
                          // print(nameInputController.text);
                          nameInputController.text = "";
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child:
                  // Obx(
                  //   () =>
                  Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Connected User : ", //${chatController.connectedUser}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
              // ),
            ),
            // Expanded(
            //     flex: 9,
            //     child: Obx(
            //       () => ListView.builder(
            //           itemCount: chatController.chatMessages.length,
            //           itemBuilder: ((context, index) {
            //             var currentItem = chatController.chatMessages[index];
            //             return MessageItem(
            //               name: currentItem.name,
            //               sentByMe: currentItem.sentByMe == socket.id,
            //               message: currentItem.message,
            //             );
            //           })),
            //     )),
            Expanded(
              flex: 9,
              child: Obx(
                () => ListView.builder(
                  itemCount: chatController.chatMessages.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var currentItem = chatController.chatMessages[index];
                    return currentItem.notification
                        ? Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, top: 8, bottom: 8),
                              child: notificationDesign(
                                message: currentItem.message,
                                name: currentItem.name,
                              ),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.only(
                                left: 14, right: 14, top: 5, bottom: 5),
                            child: Align(
                              alignment: (currentItem.sentByMe == socket.id
                                  ? Alignment.topRight
                                  : Alignment.topLeft),
                              child: MessageItem(
                                name: currentItem.name,
                                sentByMe: currentItem.sentByMe == socket.id,
                                message: currentItem.message,
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(20),
                              //     color: (so?Colors.grey.shade200:Colors.blue[200]),
                              //   ),
                              //   padding: EdgeInsets.all(16),
                              //   child: Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
                              // ),
                            ),
                          );
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.purple,
                  controller: msgInputController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                      ),
                      child: IconButton(
                        onPressed: () {
                          sendMessage(msgInputController.text);
                          // print(msgInputController.text);
                          msgInputController.text = "";
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(String text) {
    var messageJson = {
      "message": text,
      "sentByMe": socket.id,
      "name": "You",
      "notification": false
    };
    var messageJsonSender = {
      "name": "",
      "message": text,
      "sentByMe": socket.id,
      "notification": false
    };
    // socket.emitWithAck('message', messageJson);
    socket.emit('send', messageJsonSender);
    // print(messageJson);
    chatController.chatMessages.add(Message.fromJson(messageJson));
  }

  void sendName(String name) {
    var messageJson = {"name": name};
    // socket.emitWithAck('message', messageJson);
    socket.emit('new-user-joined', messageJson);
    // print("messageJson :- " + messageJson.toString());
    // chatController.chatMessages.add(Message.fromJson(messageJson));
  }

  void setUpSocketListener() {
    socket.on('receive', (data) {
      print(data);
      // var messageJson = {"message": data['message'], "sentByMe": socket.id};
      chatController.chatMessages.add(Message.fromJson(data));
    });

    // socket.on('sender-name', (data) {
    //   print(data);
    //   c
    // });

    socket.on('user-joined', (data) {
      print("data received :- ");
      print(data);
      print("Data");
      // var response = jsonDecode(data);
      print(data['name']);
      var messageJson = {
        "name": data['name'],
        "message": " joined the chat.",
        "sentByMe": socket.id,
        "notification": true,
      };
      chatController.chatMessages.add(Message.fromJson(messageJson));
    });

    socket.on('left', (data) {
      print(data);
      var messageJson = {
        "name": data['name'],
        "message": " left the chat",
        "sentByMe": socket.id,
        "notification": true,
      };
      chatController.chatMessages.add(Message.fromJson(messageJson));
      // chatController.connectedUser.value = data;
    });
  }
}
