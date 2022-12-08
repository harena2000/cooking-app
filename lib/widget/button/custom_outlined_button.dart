import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../const/color.dart';
import '../text/custom_text.dart';

class CustomOutlinedButton extends StatefulWidget {
  final String text;
  final double? size;
  final Color? color;
  final Color? borderColor;
  final bool? onExit;
  final int? duration;
  final bool? isDisable;
  final void Function()? onClick;

  const CustomOutlinedButton(
      {Key? key,
      this.onClick,
      required this.text,
      this.size,
      this.color,
      this.borderColor,
      this.onExit = false,
      this.duration, this.isDisable = false
      })
      : super(key: key);

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  late Color backgroundColor;
  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    widget.borderColor ?? AppColor.orange;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: !widget.onExit!
          ? FadeInRight(
              duration: Duration(milliseconds: widget.duration ?? 300),
              child: OutlinedButton(
                  onPressed: () => { !widget.isDisable! ? widget.onClick!() : null },
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: !widget.isDisable! ? (widget.borderColor ?? AppColor.orange) : AppColor.lightGrey,
                          width: 1),
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                  child: Center(
                    child: CustomText(
                      bold: true,
                      text: widget.text,
                      size: widget.size ?? 15,
                      color: !widget.isDisable! ? (widget.color ?? Colors.white) : AppColor.lightGrey,
                    ),
                  )),
            )
          : FadeOutLeft(
          duration: Duration(milliseconds: widget.duration ?? 300),
          child: OutlinedButton(
                  onPressed: () => {widget.onClick!()},
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: widget.borderColor ?? AppColor.orange,
                          width: 2),
                      disabledForegroundColor:
                          widget.borderColor ?? AppColor.orange,
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                  child: Center(
                    child: CustomText(
                      bold: true,
                      text: widget.text,
                      size: widget.size ?? 15,
                      color: widget.color ?? Colors.white,
                    ),
                  ))),
    );
  }
}
