import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/service/cloud_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileBuilder extends StatefulWidget {
  const UserProfileBuilder({Key? key}) : super(key: key);

  @override
  State<UserProfileBuilder> createState() => _UserProfileBuilderState();
}

class _UserProfileBuilderState extends State<UserProfileBuilder> {
  late final CloudStorageService storage = CloudStorageService();
  late final _auth = FirebaseAuth.instance;
  late final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firestore.collection("users").doc(_auth.currentUser!.uid).get(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){

              return Image.network(
                snapshot.data!['image_profile'],
                fit: BoxFit.cover,
              );
          }
          else if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          return Container();

        }
    );
  }
}
