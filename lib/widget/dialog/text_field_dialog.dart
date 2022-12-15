import 'package:animate_do/animate_do.dart';
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
      this.color, this.onClick})
      : super(key: key);

  @override
  State<TextFieldDialog> createState() => _TextFieldDialogState();
}

class _TextFieldDialogState extends State<TextFieldDialog> {

  String search = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupMember>(
      create: (_) => GroupMember(),
      builder: (context, child) {
        return BounceInDown(
          duration: const Duration(milliseconds: 800),
          child: AlertDialog(
            clipBehavior: Clip.antiAlias,
            backgroundColor: AppColor.darkBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            icon: Center(
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border:
                  Border.all(width: 2, color: widget.color ?? AppColor.orange),
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

                  const SizedBox(height: 10,),

                  CustomTextField(
                    hintText: "Search message...",
                    icon: FontAwesomeIcons.magnifyingGlass,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    onChange: (value) {
                      setState(() {
                        search = value;
                      });
                    },
                  ),

                  const SizedBox(height: 10,),
                  const Expanded(child: AddUserBuilder()),

                  Expanded(
                      child: ListView.builder(
                          itemCount: Provider.of<GroupMember>(context).member.length,
                          itemBuilder: (context, index) {
                            late UserModel user;
                            Provider.of<GroupMember>(context).member.forEach((key, value) {
                              user = value;
                            });

                            return Card(
                                elevation: 0,
                                color: Colors.white.withOpacity(0.1),
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          Provider.of<GroupMember>(context,
                                              listen: false)
                                              .removeMember(user.id!);
                                        },
                                      )
                                    ],
                                  ),
                                ));
                          }
                      )
                  )

                ],
              ),
            ),
            actions: [
              CustomOutlinedButton(
                onClick: () => widget.onClick!(),
                duration: 50,
                text: "Create Group +",
                borderColor: widget.color ?? AppColor.orange,
              ),
            ],
            elevation: 20,
            actionsPadding: const EdgeInsets.only(left: 60, right: 60, bottom: 20),
          ),
        );
      }
    );
  }
}
