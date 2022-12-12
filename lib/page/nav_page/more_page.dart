import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/page/auth/login_page.dart';
import 'package:cooking_app/widget/button/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  void _changeStatus() async {
    await firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .update({"status": false});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CustomButton(
            text: "Log Out",
            onClick: (){
              _changeStatus();
              _auth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            }
          )
        ],
      ),
    );
  }
}
