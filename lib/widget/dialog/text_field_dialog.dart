import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/builder/add_user_builder.dart';
import 'package:cooking_app/model/user_model.dart';
import 'package:cooking_app/page/main_page.dart';
import 'package:cooking_app/provider/add_member_provider.dart';
import 'package:cooking_app/widget/button/custom_button.dart';
import 'package:cooking_app/widget/button/custom_outlined_button.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../builder/contact_builder.dart';
import '../../builder/users_builder.dart';
import '../../const/color.dart';
import '../message/image_status.dart';
import '../text_field/custom_text_field.dart';

class TextFieldDialog extends StatefulWidget {
  final IconData? dialogIcon;
  final String text;
  final String? textButton;
  final Color? color;
  final Function()? onClick;

  const TextFieldDialog(
      {Key? key,
      this.dialogIcon,
      required this.text,
      this.textButton,
      this.color,
      this.onClick})
      : super(key: key);

  @override
  State<TextFieldDialog> createState() => _TextFieldDialogState();
}

class _TextFieldDialogState extends State<TextFieldDialog> {
  String search = "";
  String groupName = "";
  final database = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupMember>(
        create: (_) => GroupMember(),
        builder: (context, child) {
          return BounceInDown(
            duration: const Duration(milliseconds: 800),
            child: AlertDialog(
              scrollable: true,
              clipBehavior: Clip.antiAlias,
              backgroundColor: AppColor.darkBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              icon: Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        width: 2, color: widget.color ?? AppColor.orange),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: FaIcon(
                      widget.dialogIcon ?? FontAwesomeIcons.check,
                      color: widget.color ?? AppColor.orange,
                      size: 30,
                    ),
                  ),
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              content: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomText(
                      text: widget.text,
                      size: 15,
                      color: Colors.white,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      softWrap: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: "Search message...",
                      icon: FontAwesomeIcons.magnifyingGlass,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      textColor: Colors.white,
                      onChange: (value) {
                        setState(() {
                          search = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                      text: "User List",
                      size: 15,
                      color: Colors.white,
                      bold: true,
                      overflow: TextOverflow.visible,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 250,
                        child: AddUserBuilder(
                          search: search.toLowerCase(),
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Member List",
                            size: 15,
                            color: Colors.white,
                            bold: true,
                            overflow: TextOverflow.visible,
                          ),
                          CustomText(
                            text:
                                "${Provider.of<GroupMember>(context).member.length} members",
                            size: 12,
                            color: Provider.of<GroupMember>(context).member.length < 2
                                ? Colors.redAccent
                                : Colors.white,
                            overflow: TextOverflow.visible,
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: CustomTextField(
                        hintText: "Group name",
                        icon: FontAwesomeIcons.userGroup,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        textColor: Colors.white,
                        onChange: (value) {
                          setState(() {
                            groupName = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "The group name is required*";
                          } else if (value.length < 3) {
                            return 'Name too short not validate';
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                        child: Provider.of<GroupMember>(context).member.isEmpty
                            ? const Center(
                                child: CustomText(
                                text: "No member added",
                              ))
                            : ListView.builder(
                                itemCount: Provider.of<GroupMember>(context)
                                    .member
                                    .length,
                                itemBuilder: (context, int index) {
                                  UserModel user =
                                      Provider.of<GroupMember>(context)
                                          .member[index];

                                  return Card(
                                      elevation: 0,
                                      color: Colors.white.withOpacity(0.1),

                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                              text: 'Cancel',
                                              backgroundColor: Colors.redAccent,
                                              size: 10,
                                              onClick: () {
                                                Provider.of<GroupMember>(
                                                        context,
                                                        listen: false)
                                                    .removeMember(index);
                                              },
                                            )
                                          ],
                                        ),
                                      ));
                                }))
                  ],
                ),
              ),
              actions: [
                Provider.of<GroupMember>(context).member.length < 2
                    ? Container()
                    : CustomOutlinedButton(
                        onClick: () {

                          Provider.of<GroupMember>(context).myId(_auth.currentUser!.uid);

                          final isValidForm = _formKey.currentState!.validate();
                          if (isValidForm) {
                            database.collection('users-group').add({
                              'users': Provider.of<GroupMember>(context).memberId,
                              'last_message': groupName,
                              'last_message_time': DateTime.now()
                            });

                            Provider.of<GroupMember>(context).removeAll();

                          }
                        },
                        duration: 50,
                        text: "Create Group +",
                        borderColor: widget.color ?? AppColor.orange,
                      ),
                CustomOutlinedButton(
                  onClick: () => Navigator.pop(context),
                  duration: 50,
                  text: "Cancel",
                  borderColor: Colors.redAccent,
                ),
              ],
              elevation: 20,
              actionsPadding: const EdgeInsets.only(
                  left: 60, right: 60, bottom: 20, top: 20),
            ),
          );
        });
  }
}
