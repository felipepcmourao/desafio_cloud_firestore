import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_cloud_firestore/components/chat_bubble.dart';
import 'package:desafio_cloud_firestore/components/my_textfield.dart';
import 'package:desafio_cloud_firestore/service/auth/auth_service.dart';
import 'package:desafio_cloud_firestore/service/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // send message
  void sendMessage () async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverEmail),),
      body: Column(children: [
        // display all messages
        Expanded(child: _buildMessageList()),

        // user input
        _buildUserInput()
      ],),
    );
  }

  // build message list

  Widget _buildMessageList () {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(senderID, receiverID), 
      builder: (context, snapshot) {
        // errors
        if(snapshot.hasError) {
          return const Text("Error");
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading ...");
        }

        // return list view 
        return ListView(
          children: snapshot.data!.docs.map((doc)=> _buidMessageItem(doc)).toList(),
          );
      });
  }

  // build message item
  Widget _buidMessageItem (DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    return Column(
      crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
      ]);
  }

  // build message input
  Widget _buildUserInput () {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(children: [
        // textfield
        Expanded(
          child: MyTextfield(
            controller: _messageController,
            hintText: "Type a message",
            obscureText: false
          )),
      
        // send button
        Container(
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle          
          ),
          margin: EdgeInsets.only(right: 25),
          child: IconButton(
            onPressed: sendMessage, 
            icon: Icon(Icons.send, color: Colors.white,)),
        ),
      ],),
    );
  }
}

//