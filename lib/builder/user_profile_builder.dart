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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: storage.profileImage(_auth.currentUser!.uid),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){

            print(snapshot.data);

            if(snapshot.data!.isEmpty) {
              return const Image(
                  image: AssetImage("assets/images/profile.jpg"),
                  fit: BoxFit.cover);
            } else {
              return Image.network(
                snapshot.data!,
                fit: BoxFit.cover,
              );
            }
          }
          if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
            print(snapshot.data);
            return const CircularProgressIndicator();
          }

          return Container();

        }
    );
  }
}
