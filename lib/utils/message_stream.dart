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

  final String id;
  final String roomId;

  const MessageStream({Key? key, required this.id, required this.roomId}) : super(key: key);

  @override
  State<MessageStream> createState() => _MessageStreamState();
}

class _MessageStreamState extends State<MessageStream> {
  final database = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;
  var loggedUser = "";

  @override
  Widget build(BuildContext context) {
    loggedUser = _auth.currentUser!.uid;
    return StreamBuilder(
      stream: database.collection('rooms').doc(widget.roomId).collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data!.docs.isNotEmpty) {

            List<QueryDocumentSnapshot?> allData = snapshot.data!.docs.where((element) =>
            element['users'].contains(widget.id) &&
                element['users'].contains(loggedUser)
            ).toList();

            QueryDocumentSnapshot? data = allData.isNotEmpty ? allData.first : null;

            /*if(data != null ) {
              Provider.of<DataFriendProvider>(context).changeFriend(data.id);
            }*/
            return Expanded(
              child: data == null ? Container() : StreamBuilder(
                stream: data.reference.collection('messages').orderBy('datetime', descending: true).snapshots(),
                builder: (context, snap) {

                  List<SenderMessageBubble> messageBubble = [];
                  for (var message in snap.data!.docs) {
                    final text = message.data()['message'];
                    final sender = message.data()['sent_by'];
                    final destination = message.data()['datetime'];

                    final widget = SenderMessageBubble(
                      text: '$text',
                      messageType: sender == loggedUser ? true : false,
                    );

                    messageBubble.add(widget);
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 30),
                    itemCount: snap.data!.docs.length,
                    reverse: true,
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
                  );
                }
              ),
            );

          }
          else {
            return const Center(child: CustomText(text: "No message yet",),);
          }
        }
        return const Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColor.orange,
              strokeWidth: 1,
            )
        );
      },
    );
  }
}
