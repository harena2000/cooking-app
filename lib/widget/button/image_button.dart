import 'package:cooking_app/const/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageButton extends StatefulWidget {
  final void Function() onClick;
  final IconData image;
  final double? size;
  final Color? color;
  final Color? backgroundColor;

  const ImageButton(
      {Key? key,
        required this.onClick,
        required this.image,
        this.size,
        this.color,
        this.backgroundColor})
      : super(key: key);

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: widget.backgroundColor ?? AppColor.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () => widget.onClick(),
        elevation: 0,
        child: SizedBox(
          height: 50,
          child: Center(
            child: FaIcon(
              widget.image,
              color: widget.color ?? AppColor.orange,
              size: widget.size ?? 15,
            ),
          ),
        ));
  }
}
