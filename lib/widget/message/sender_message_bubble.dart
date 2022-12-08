import 'package:cooking_app/const/color.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:flutter/material.dart';

class SenderMessageBubble extends StatelessWidget {
  final String text;
  final bool messageType;

  const SenderMessageBubble(
      {Key? key, required this.text, required this.messageType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: messageType ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Material(
          borderRadius: messageType ? const BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ) : const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          elevation: 5,
          color: messageType ? Colors.lightBlueAccent : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: CustomText(
              softWrap: true,
              maxLines: 5,
              overflow: TextOverflow.visible,
              text: text,
              color: messageType ? Colors.white : AppColor.darkBlue,
            ),
          ),
        ),
      ],
    );
  }
}
