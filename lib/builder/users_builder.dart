import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../page/chat_page.dart';
import '../widget/message/image_status.dart';

class UsersBuilder extends StatefulWidget {

  final String? search;

  const UsersBuilder({Key? key, this.search}) : super(key: key);

  @override
  State<UsersBuilder> createState() => _UsersBuilderState();
}

class _UsersBuilderState extends State<UsersBuilder> {

  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var currentEmail = "";
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
        stream: firestore.collection("users").snapshots(),
        builder: (context, snapshot) {
          List data = !snapshot.hasData
              ? []
              : snapshot.data!.docs
              .where((element) => !(element['email'].toString().contains(currentEmail)) &&
                  (element['email'].toString().contains(widget.search!) ||
                  element['name'].toString().contains(widget.search!)))
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
                                  id: data[index]
                                      .id
                                      .toString(),
                                  chatname: data[index]
                                  ['name'],
                                )));
                      },
                      child: Container(
                          width: 50,
                          margin:
                          const EdgeInsets.only(right: 10),
                          child: ImageStatus(
                            status: data[index]["status"],
                            imageUrl: data[index]
                            ['image_profile'],
                          )));
                }

                return listOfUser;
              },
            ),
          )
              : const CircularProgressIndicator();
        });
  }
}
