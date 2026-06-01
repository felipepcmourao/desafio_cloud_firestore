import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_cloud_firestore/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier{

  // FIRESTORE INTANCE
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // GET USER STREAM
  Stream<List<Map<String, dynamic>>> getUserStream () {
    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        // go through each individual user
        final user = doc.data();

        // return user
        return user;
      }).toList();
    });
  }

  // SEND MESSAGE
  Future<void> sendMessage (String receiverID, message) async {
    // get current user info
    final currentUserID = _auth.currentUser!.uid;
    final currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message

  MessageModel newMessage = MessageModel(
    senderID: currentUserID, 
    senderEmail: currentUserEmail, 
    receiverID: receiverID, 
    message: message, 
    timestamp: timestamp);

    // construct chat room ID
  List<String> ids = [currentUserID, receiverID];
  ids.sort();
  String chatRoomID = ids.join("_");
  

    // add new message to database
    await _firestore
    .collection("chat_rooms")
    .doc(chatRoomID)
    .collection("messages")
    .add(newMessage.toMap());
  }

  // GET MESSAGE
    Stream<QuerySnapshot> getMessage (String userID, otherUserID) {
      // construct chat room ID
      List<String> ids = [userID, otherUserID];
      ids.sort();
      String chatRoomID = ids.join("_");

      return _firestore
      .collection("chat_rooms")
      .doc(chatRoomID)
      .collection("messages")
      .orderBy("timestamp", descending: false)
      .snapshots();
    }
}