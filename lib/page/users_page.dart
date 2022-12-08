import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/page/chat_page.dart';
import 'package:cooking_app/widget/others/notification_badge.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
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
  final controller = TextEditingController();
  String search = "";
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyDeepWhite,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 6,
                    child: CustomTextField(
                      hintText: "Search message...",
                      icon: FontAwesomeIcons.magnifyingGlass,
                      backgroundColor: Colors.white,
                      controller: controller,
                      onChange: (value) {
                        setState(() {
                          search = value;
                        });
                      },
                    )),
              ],
            ),
            Expanded(
                flex: 3,
                child: StreamBuilder(
                    stream: firestore.collection("users").snapshots(),
                    builder: (context, snapshot) {
                      List data = !snapshot.hasData ? [] : snapshot.data!.docs.where((element) =>
                      element['email'].toString().contains(search) ||
                          element['name'].toString().contains(search)).toList();

                      return snapshot.hasData
                          ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          Timestamp time = data[index]['date_time'];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (
                                          context) => ChatPage(id: data[index].id.toString(),)));
                            },
                            child: Card(
                              elevation: 0,
                              child: ListTile(
                                leading: const CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage(
                                      "assets/images/profile.jpg"),
                                ),
                                title: CustomText(
                                  text: "${data[index]['name']}",
                                  bold: true,
                                  size: 16,
                                ),
                                subtitle: const CustomText(
                                  text: "User name",
                                  size: 13,
                                  color: AppColor.lightGrey,
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 8),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: DateFormat('EEE hh:mm')
                                            .format(time.toDate()),
                                        size: 10,
                                        color: AppColor.lightGrey,
                                      ),
                                      const NotificationBadge()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                          : const CircularProgressIndicator();
                    })),
          ],
        ),
      ),
    );
  }
}
