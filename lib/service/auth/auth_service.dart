import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier{

  // INSTANCE OF AUTH
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   // GET CURRENT USER
  User? getCurrentUser (){
    return _auth.currentUser;
  }
 
  // SIGN IN
  Future<UserCredential> signInWithEmailPassword(String email, String pw) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: pw);

       //save user info in a separate doc if it doesn't exist
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        }
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }

  }

  // SIGN UP
  Future<UserCredential> signUpWithEmailPassword (String email, String pw) async {
    try {
      //create user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: pw);

      //save user info in a separate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        }
      );

      return userCredential;


    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
    }

   // SIGN OUT
  Future<void> signOut () async {
    await _auth.signOut();
  }

  // ERRORS
  
  }

 
