import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/page/chat_page.dart';
import 'package:cooking_app/widget/message/image_status.dart';
import 'package:cooking_app/widget/others/notification_badge.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../const/color.dart';
import '../widget/button/image_button.dart';
import '../widget/text_field/custom_text_field.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
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
    return Scaffold(
      backgroundColor: AppColor.darkBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 6,
                      child: CustomTextField(
                        hintText: "Search message...",
                        icon: FontAwesomeIcons.magnifyingGlass,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        controller: controller,
                        onChange: (value) {
                          setState(() {
                            search = value;
                          });
                        },
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const CustomText(
                      text: "Recent Users", bold: true, size: 15)),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder(
                  stream: firestore.collection("users").snapshots(),
                  builder: (context, snapshot) {
                    List data = !snapshot.hasData
                        ? []
                        : snapshot.data!.docs
                            .where((element) =>
                                element['email'].toString().contains(search) ||
                                element['name'].toString().contains(search))
                            .toList();

                    return snapshot.hasData
                        ? SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                if (data[index]['email'] != currentEmail) {

                                  listOfUser = GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ChatPage(
                                                      id: data[index].id.toString(),
                                                      chatname: data[index]['name'],
                                                    )));
                                      },
                                      child: Container(
                                        width: 50,
                                        margin: const EdgeInsets.only(right: 10),
                                        child: ImageStatus(status : data[index]["status"])
                                      ));
                                }

                                return listOfUser;
                              },
                            ),
                          )
                        : const CircularProgressIndicator();
                  }),
              const SizedBox(
                height: 30,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const CustomText(
                      text: "Contacts", bold: true, size: 15)),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder(
                  stream: firestore.collection("rooms").orderBy('last_message_time', descending: true).snapshots(),
                  builder: (context, snapshot) {
                    List dataRooms = !snapshot.hasData
                        ? []
                        : snapshot.data!.docs
                            .where((element) => element['users']
                                .toString()
                                .contains(_auth.currentUser!.uid))
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
                                      return !snap.hasData
                                          ? Container()
                                          : FadeInUp(
                                            duration: const Duration(milliseconds: 500),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChatPage(
                                                                id: user,
                                                                chatname: snap.data!['name'],
                                                              )));
                                                },
                                                child: Card(
                                                  elevation: 0,
                                                  color: Colors.white.withOpacity(0.1),
                                                  clipBehavior: Clip.antiAlias,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  child: ListTile(
                                                    leading: const CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage: AssetImage(
                                                          "assets/images/profile.jpg"),
                                                    ),
                                                    title: CustomText(
                                                      text: snap.data!['name'],
                                                      bold: true,
                                                      size: 16,
                                                    ),
                                                    subtitle: CustomText(
                                                      overflow: TextOverflow.fade,
                                                      text: dataRooms[index]
                                                          ['last_message'],
                                                      size: 13,
                                                      color: AppColor.lightGrey,
                                                    ),
                                                    trailing: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8, bottom: 8),
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
                                                          const NotificationBadge()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          );
                                    });

                                return listOfUser;
                              },
                            ),
                          )
                        : const CircularProgressIndicator();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
