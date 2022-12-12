import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../const/color.dart';
import '../provider/friend_notifier.dart';
import '../widget/message/sender_message_bubble.dart';

class MessageStream extends StatefulWidget {
  final QueryDocumentSnapshot data;
  final String? lastMessage;

  const MessageStream({Key? key, required this.data, this.lastMessage})
      : super(key: key);

  @override
  State<MessageStream> createState() => _MessageStreamState();
}

class _MessageStreamState extends State<MessageStream> {
  final database = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.data.reference
            .collection('messages')
            .orderBy('datetime', descending: true)
            .snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            List<Widget> messageBubble = [];
            for (var message in snap.data!.docs) {
              final text = message.data()['message'];
              final sender = message.data()['sent_by'];
              final datetime = message.data()['datetime'];

              final messageField = widget.lastMessage == text
                  ? SenderMessageBubble(
                    text: text,
                    isLastMessage: true,
                    messageType:
                        sender == _auth.currentUser!.uid ? true : false,
                  )
                  : SenderMessageBubble(
                      text: text,
                      messageType:
                          sender == _auth.currentUser!.uid ? true : false);

              messageBubble.add(messageField);
            }

            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 30),
              itemCount: snap.data!.docs.length,
              reverse: true,
              itemBuilder: (context, int index) {
                return Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 100),
                    child: Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: BounceInDown(child: messageBubble[index])),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CustomText(text: "No Data set"),
            );
          }
        });
  }
}
