import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/utils/message_stream.dart';
import 'package:cooking_app/widget/button/image_button.dart';
import 'package:cooking_app/widget/message/image_status.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:cooking_app/widget/text_field/sender_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../const/color.dart';

class ChatPage extends StatefulWidget {
  final String id;
  final String chatname;

  const ChatPage({Key? key, required this.id, required this.chatname})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _auth = FirebaseAuth.instance;
  final database = FirebaseFirestore.instance;
  late User loggedInUser;
  final senderFormController = TextEditingController();

  String messageText = "";

  var roomId;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBlue,
      appBar: AppBar(
        leadingWidth: 30,
        title: Row(
          children: [
            StreamBuilder(
                stream: database.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    var friendInfo = snapshot.data!.docs
                        .where((element) => element.id == widget.id);

                    return ImageStatus(
                        statusSize: 8,
                        radius: 20,
                        status: friendInfo.first.data()['status'],
                        imageUrl: friendInfo.first.data()['image_profile']);
                  }

                  return const CircularProgressIndicator();

                }),
            const SizedBox(width: 20,),
            CustomText(text: widget.chatname, bold: true, color: Colors.white),
          ],
        ),
        backgroundColor: AppColor.darkBlue,
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.pop(context);
          },
          child: const SizedBox(
            width: 50,
            height: 50,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 15,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                stream: database.collection('rooms').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isNotEmpty) {
                      List<QueryDocumentSnapshot?> allData = snapshot.data!.docs
                          .where((element) =>
                              element['users'].contains(widget.id) &&
                              element['users'].contains(loggedInUser.uid))
                          .toList();

                      QueryDocumentSnapshot? data =
                          allData.isNotEmpty ? allData.first : null;

                      if (data != null) {
                        roomId = data.id;
                      }

                      return Expanded(
                        child: data == null
                            ? Container()
                            : MessageStream(
                                data: data,
                                lastMessage: data['last_message'],
                              ),
                      );
                    } else {
                      return const Center(
                        child: CustomText(
                          text: "No message yet",
                        ),
                      );
                    }
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                    backgroundColor: AppColor.orange,
                    strokeWidth: 1,
                  ));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: SenderTextField(
                        backgroundColor: Colors.white.withOpacity(0.1),
                        controller: senderFormController,
                        textColor: Colors.white,
                        hintText: 'Type your message',
                        icon: FontAwesomeIcons.camera,
                        onChange: (value) {
                          messageText = value;
                        },
                      )),
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(left: 5),
                    child: ImageButton(
                  onClick: () {
                    senderFormController.clear();

                    if (roomId != null) {
                      Map<String, dynamic> data = {
                        'message': messageText,
                        'sent_by': _auth.currentUser!.uid,
                        'datetime': DateTime.now(),
                        'view': false
                      };
                      database.collection('rooms').doc(roomId).update({
                        'last_message': messageText,
                        'last_message_time': DateTime.now()
                      });
                      database
                          .collection('rooms')
                          .doc(roomId)
                          .collection('messages')
                          .add(data);
                    } else {
                      Map<String, dynamic> data = {
                        'message': messageText,
                        'sent_by': _auth.currentUser!.uid,
                        'datetime': DateTime.now(),
                        'view': false
                      };
                      database.collection('rooms').add({
                        'users': [widget.id, _auth.currentUser!.uid],
                        'last_message': messageText,
                        'chat_name' : widget.chatname,
                        'last_message_time': DateTime.now()
                      }).then((value) =>
                          value.collection('messages').add(data));
                    }
                  },
                  image: FontAwesomeIcons.paperPlane,
                  color: Colors.blue,
                  size: 18,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
