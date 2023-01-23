import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../const/color.dart';
import '../page/message/chat_page.dart';
import '../page/message/group_chat_page.dart';
import '../widget/message/image_status.dart';
import '../widget/others/notification_badge.dart';
import '../widget/text/custom_text.dart';

class ContactMessageBuilder extends StatefulWidget {
  final String? search;

  const ContactMessageBuilder({Key? key, this.search = ""}) : super(key: key);

  @override
  State<ContactMessageBuilder> createState() => _ContactMessageBuilderState();
}

class _ContactMessageBuilderState extends State<ContactMessageBuilder> {
  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final controller = TextEditingController();
  String search = "";
  var currentEmail = "";
  bool show = false;
  late Widget listOfUser;

  @override
  void initState() {
    super.initState();

    currentEmail = _auth.currentUser!.email!;
    listOfUser = Container();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firestore
            .collection("rooms")
            .orderBy('last_message_time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          List dataRooms = !snapshot.hasData
              ? []
              : snapshot.data!.docs
                  .where((element) =>
                      element['users'].contains(_auth.currentUser!.uid))
                  .toList();

          return snapshot.hasData
              ? Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: dataRooms.length,
              itemBuilder: (context, index) {
                List users = dataRooms[index]["users"];
                var friend = users.where((element) =>
                element != _auth.currentUser!.uid);
                var user = friend.isNotEmpty
                    ? friend.first
                    : users
                    .where((element) =>
                element == _auth.currentUser!.uid)
                    .first;

                Timestamp time =
                dataRooms[index]['last_message_time'];

                return FutureBuilder(
                    future: firestore
                        .collection("users")
                        .doc(user)
                        .get(),
                    builder: (context, snap) {
                      if (!snap.hasData) {
                        return Container();
                      } else {
                        return FadeInUp(
                          duration: const Duration(
                              milliseconds: 500),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChatPage(
                                            id: user,
                                            chatname:
                                            snap.data![
                                            'name'],
                                          )));
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.white
                                  .withOpacity(0.1),
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                      20)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ImageStatus(
                                        status:
                                        snap.data!['status'],
                                        imageUrl: snap.data![
                                        'image_profile'],
                                      ),
                                    ),
                                    const SizedBox(width: 20,),
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: snap.data!['name'],
                                            bold: true,
                                            size: 16,
                                          ),

                                          CustomText(
                                            overflow:
                                            TextOverflow.fade,
                                            text: dataRooms[index]
                                            ['last_message'],
                                            size: 13,
                                            color: AppColor.lightGrey,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            top: 8,
                                            bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            CustomText(
                                              text: DateFormat(
                                                  'EEE hh:mm')
                                                  .format(time
                                                  .toDate()),
                                              size: 10,
                                              color: AppColor
                                                  .lightGrey,
                                            ),
                                            const SizedBox(height: 5,),
                                            const NotificationBadge()
                                          ],
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    });

                      return listOfUser;
                    },
                  ),
                )
              : const CircularProgressIndicator();
        });
  }
}
