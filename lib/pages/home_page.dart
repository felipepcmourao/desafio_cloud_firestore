import 'package:desafio_cloud_firestore/components/user_tile.dart';
import 'package:desafio_cloud_firestore/pages/chat_page.dart';
import 'package:desafio_cloud_firestore/service/auth/auth_service.dart';
import 'package:desafio_cloud_firestore/components/my_drawer.dart';
import 'package:desafio_cloud_firestore/service/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  // CHAT & AUTH SERVICE
  final ChatService _chatService = ChatService();
  final AuthService _auth = AuthService(); 
  

  // LOG OUT FUNCTION
  void logout (){
    // auth services
    final auth = AuthService();

    // sign out
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
        )],
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }


  // build a list of user except for the one logged in
Widget _buildUserList () {
  return StreamBuilder(
    stream: _chatService.getUserStream(),
    builder: (context, snapshot){
      // errors
      if (snapshot.hasError) {
        return const Text("Error");
      }

      // loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }

      // return list view
      return ListView(
        children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
      );
    });

}

// build each individual list tile for users

Widget _buildUserListItem (Map<String, dynamic> userData, BuildContext context){
  // display all users except current user
  if (userData["email"] != _auth.getCurrentUser()!.email) {
    return UserTile(
    text: userData["email"],  
    onTap: () {
      // tapped on a user -> go to chat page
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => ChatPage(
            receiverEmail: userData["email"],
            receiverID: userData["uid"],
          )
          ),
          );
      }, 
  );
  } else {
    return SizedBox.shrink();
  }
}

}

