import 'package:cooking_app/const/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageButton extends StatefulWidget {
  final void Function() onClick;
  final IconData image;
  final double? size;
  final Color? color;
  final double? buttonSize;
  final Color? backgroundColor;

  const ImageButton(
      {Key? key,
        required this.onClick,
        required this.image,
        this.size,
        this.color,
        this.backgroundColor, this.buttonSize})
      : super(key: key);

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.buttonSize ?? 50,
      height: widget.buttonSize ?? 50,
      child: ElevatedButton(
        clipBehavior: Clip.antiAlias,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.backgroundColor ?? Colors.white.withOpacity(0.1)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),),
          elevation: MaterialStateProperty.all(0)
        ),
          onPressed: () => widget.onClick(),
          child: Center(
            child: FaIcon(
              widget.image,
              color: widget.color ?? AppColor.orange,
              size: widget.size ?? 15,
            ),
          )),
    );
  }
}
