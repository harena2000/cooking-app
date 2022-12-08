import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../const/color.dart';
import '../others/notification_badge.dart';
import '../text/custom_text.dart';

class AllMessages extends StatefulWidget {
  final String title;
  final String subtitle;
  final int? duration;
  const AllMessages({Key? key, required this.title, required this.subtitle, this.duration}) : super(key: key);

  @override
  State<AllMessages> createState() => _AllMessagesState();
}

class _AllMessagesState extends State<AllMessages> {
  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: Duration(milliseconds: widget.duration ?? 100),
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/images/profile.jpg"),
          ),
          title: CustomText(text: widget.title, bold: true, size: 16,),
          subtitle: CustomText(text: widget.subtitle, size: 13, color: AppColor.lightGrey,),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CustomText(text: "02:29 PM", size: 10, color: AppColor.lightGrey,),
                NotificationBadge()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
