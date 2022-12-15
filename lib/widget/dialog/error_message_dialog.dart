import 'package:animate_do/animate_do.dart';
import 'package:cooking_app/page/main_page.dart';
import 'package:cooking_app/widget/button/custom_button.dart';
import 'package:cooking_app/widget/button/custom_outlined_button.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../const/color.dart';

class ErrorMessageDialog extends StatefulWidget {
  final IconData? dialogIcon;
  final String text;
  final String? textButton;
  final Color? color;
  final Function()? onClick;

  const ErrorMessageDialog(
      {Key? key,
      this.dialogIcon,
      required this.text,
      this.textButton,
      this.color, this.onClick})
      : super(key: key);

  @override
  State<ErrorMessageDialog> createState() => _ErrorMessageDialogState();
}

class _ErrorMessageDialogState extends State<ErrorMessageDialog> {
  @override
  Widget build(BuildContext context) {
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
                FontAwesomeIcons.check,
                color: widget.color ?? AppColor.orange,
                size: 30,
              ),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.all(20.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: widget.text,
              size: 15,
              color: Colors.white,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              maxLines: 3,
              softWrap: true,
            )
          ],
        ),
        actions: [
          CustomOutlinedButton(
            onClick: () => widget.onClick!(),
            duration: 50,
            text: "Ok",
            borderColor: widget.color ?? AppColor.orange,
          ),
        ],
        elevation: 20,
        actionsPadding: const EdgeInsets.only(left: 60, right: 60, bottom: 20),
      ),
    );
  }
}
