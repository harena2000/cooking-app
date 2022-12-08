import 'package:cooking_app/const/color.dart';
import 'package:flutter/material.dart';

import '../text/custom_text.dart';

class CustomButton extends StatefulWidget {

  final String text;
  final double? size;
  final Color? color;
  final Color? backgroundColor;
  final void Function()? onClick;

  const CustomButton({Key? key, required this.text, this.size, this.color, this.onClick, this.backgroundColor}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget.onClick,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: widget.backgroundColor ?? AppColor.orange
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(7),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: CustomText(
                bold: true,
                text: widget.text,
                size: widget.size ?? 15,
                color: widget.color ?? Colors.white,
              )
            ),
          ),
        )
    );
  }
}
