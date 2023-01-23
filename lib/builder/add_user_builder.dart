import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/model/user_model.dart';
import 'package:cooking_app/provider/add_member_provider.dart';
import 'package:cooking_app/widget/button/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../const/color.dart';
import '../page/message/chat_page.dart';
import '../widget/button/image_button.dart';
import '../widget/message/image_status.dart';
import '../widget/others/notification_badge.dart';
import '../widget/text/custom_text.dart';

class AddUserBuilder extends StatefulWidget {
  final String? search;

  const AddUserBuilder({Key? key, this.search = ""}) : super(key: key);

  @override
  State<AddUserBuilder> createState() => _AddUserBuilderState();
}

class _AddUserBuilderState extends State<AddUserBuilder> {
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
                  .where((element) =>
                      (element['email'].toLowerCase() != currentEmail) &&
                      (element['email'].toLowerCase().contains(widget.search!) ||
                          element['name'].toLowerCase().contains(widget.search!)))
                  .toList();

          return snapshot.hasData
              ? (Provider.of<GroupMember>(context).member.length != data.length
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var user = UserModel(
                            id: snapshot.data!.docs[index].id,
                            name: data[index]['name'],
                            profile: data[index]['image_profile'],
                            email: data[index]['email'],
                            status: data[index]['status']);

                        if (!(Provider.of<GroupMember>(context).memberId.contains(user.id))) {
                          return Card(
                              elevation: 0,
                              color: Colors.white.withOpacity(0.1),
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ImageStatus(
                                      status: user.status!,
                                      imageUrl: user.profile!,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: CustomText(
                                        overflow: TextOverflow.fade,
                                        text: user.name!,
                                        bold: true,
                                        size: 14,
                                      ),
                                    ),
                                    CustomButton(
                                      text: 'Add +',
                                      size: 10,
                                      onClick: () {
                                        Provider.of<GroupMember>(context,
                                                listen: false)
                                            .addMember(user);
                                      },
                                    )
                                  ],
                                ),
                              ));
                        }
                        return listOfUser;
                      },
                    )
                  : const Center(
                      child: CustomText(
                        text: 'All user is already a Member',
                      ),
                    ))
              : const CircularProgressIndicator();
        });
  }
}
