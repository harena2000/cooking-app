import 'package:animate_do/animate_do.dart';
import 'package:cooking_app/const/color.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:flutter/material.dart';

class SenderMessageBubble extends StatelessWidget {
  final String text;
  final bool messageType;
  final bool? isLastMessage;

  const SenderMessageBubble(
      {Key? key,
      required this.text,
      required this.messageType,
      this.isLastMessage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          messageType ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        isLastMessage!
            ? messageType
                ? FadeInRight(
                    duration: const Duration(milliseconds: 100),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2 + 50),
                      child: Material(
                        borderRadius: messageType
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              )
                            : const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              ),
                        color: messageType
                            ? AppColor.deepBlue
                            : Colors.white.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: CustomText(
                            softWrap: true,
                            maxLines: 5,
                            overflow: TextOverflow.visible,
                            text: text,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                : FadeInLeft(
                    duration: const Duration(milliseconds: 100),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2 + 50),
                      child: Material(
                        borderRadius: messageType
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              )
                            : const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              ),
                        color: messageType
                            ? AppColor.deepBlue
                            : Colors.white.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: CustomText(
                            softWrap: true,
                            maxLines: 5,
                            overflow: TextOverflow.visible,
                            text: text,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
            : ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 2 + 50),
                child: Material(
                  borderRadius: BorderRadius.circular(30),
                  color: messageType
                      ? AppColor.deepBlue
                      : Colors.white.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: CustomText(
                      softWrap: true,
                      maxLines: 5,
                      overflow: TextOverflow.visible,
                      text: text,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
