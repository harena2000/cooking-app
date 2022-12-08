import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/widget/message/all_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';import '../const/color.dart';

class UsersMessages extends StatefulWidget {
  const UsersMessages({Key? key}) : super(key: key);

  @override
  State<UsersMessages> createState() => _UsersMessagesState();
}

class _UsersMessagesState extends State<UsersMessages> {

  final database = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var loggedUser = "";

  @override
  Widget build(BuildContext context) {

    loggedUser = _auth.currentUser!.email!;

    return StreamBuilder(
        stream: database.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messageList = snapshot.data!.docs.reversed;
            List<AllMessages> messageBubble = [];
            Map friendList = {};
            for (var message in messageList) {

              final text = message.data()['text'];
              final sender = message.data()['sender'];
              final destination = message.data()['destination'];

              friendList.map((key, value) => key = destination);
            }

            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 30),
                itemCount: messageBubble.length,
                itemBuilder: (context, int index) {
                  return Flexible(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 50),
                      child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: messageBubble[index]
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColor.orange,
                strokeWidth: 1,
              ));
        }
    );
  }
}
