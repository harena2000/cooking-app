import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/builder/contact_builder.dart';
import 'package:cooking_app/builder/users_builder.dart';
import 'package:cooking_app/widget/dialog/text_field_dialog.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../const/color.dart';
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
                      )
                  ),
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

              UsersBuilder(search: search,),

              const SizedBox(
                height: 30,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child:
                      const CustomText(text: "Contacts", bold: true, size: 15)),
              const SizedBox(
                height: 10,
              ),

              const ContactMessageBuilder()

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) =>
                  TextFieldDialog(
                    dialogIcon: FontAwesomeIcons.users,
                    text: "Create Chat Group",
                    color: Colors.blue,
                    onClick: () => Navigator.pop(context),
                  )
          );
        },
        backgroundColor: AppColor.orange,
        child: const FaIcon(
          FontAwesomeIcons.plus
        ),
      ),
    );
  }
}
