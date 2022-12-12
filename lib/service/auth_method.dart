import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

Future<UserCredential?> createAccount(String name, String email, String password) async {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try{
    final user = (await _auth.createUserWithEmailAndPassword(email: email, password: password));
    if(user != null){

      await _firestore.collection("users").doc(_auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "date_time": DateTime.now(),
        "status" : true
      });

      return user;
    } else {
      return user;
    }
  } catch (e) {
    print("Something wrong!");
    return null;
  }
}

Future<User?> login(String email, String password) async {

  try {
    final getUser =
    (await _auth.signInWithEmailAndPassword(
        email: email, password: password)).user;

    if (getUser != null) {
      return getUser;
    }
  } catch (e) {
    print("Something wrong!");
  }

  return null;

}