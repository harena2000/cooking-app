import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/page/main_page.dart';
import 'package:cooking_app/page/users_page.dart';
import 'package:cooking_app/provider/friend_notifier.dart';
import 'package:cooking_app/utils/message_stream.dart';
import 'package:cooking_app/widget/button/image_button.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:cooking_app/widget/text_field/sender_text_field.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../const/color.dart';

class ChatPage extends StatefulWidget {

  final String id;

  const ChatPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _auth = FirebaseAuth.instance;
  final database = FirebaseFirestore.instance;
  late User loggedInUser;
  final senderFormController = TextEditingController();

  String messageText = "";

  final List<types.Message> _messages = [];
  late final _user;


  @override
  void initState() {
    super.initState();
    getCurrentUser();

    _user = types.User(id: loggedInUser.uid);

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
    return ChangeNotifierProvider<DataFriendProvider>(
      create: (_) => DataFriendProvider(),
      child: Scaffold(
        appBar: AppBar(
          title:
              const CustomText(text: "Message", bold: true, color: Colors.white),
          backgroundColor: AppColor.darkBlue,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
                child: FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: 15,
            )),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MessageStream(id: widget.id, roomId: '',),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 6,
                        child: SenderTextField(
                          controller: senderFormController,
                          hintText: 'Type your message',
                          icon: FontAwesomeIcons.camera,
                          onChange: (value) {
                            messageText = value;
                          },
                        )),
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: ImageButton(
                        onClick: () {
                          senderFormController.clear();

                          var roomId = Provider.of<DataFriendProvider>(context).roomId;

                          if(roomId != null) {
                            Map<String, dynamic> data = {
                              'message' : messageText,
                              'sent_by' : _auth.currentUser!.uid,
                              'datetime': DateTime.now()
                            };
                            database.collection('rooms').doc(roomId).collection('messages').add(data);
                          } else {
                            Map<String, dynamic> data = {
                              'message' : messageText,
                              'sent_by' : _auth.currentUser!.uid,
                              'datetime': DateTime.now()
                            };
                            database.collection('rooms').add({
                              'users' : [widget.id, _auth.currentUser!.uid]
                            }).then((value) => value.collection('messages').add(data));
                          }
                        },
                        image: FontAwesomeIcons.paperPlane,
                        size: 18,
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _user.toString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

}
