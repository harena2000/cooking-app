import 'package:cooking_app/const/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SquareButton extends StatefulWidget {

  final IconData icon;
  final Color? backgroundColor;
  final Color? imageColor;
  final double? size;

  const SquareButton({Key? key, this.backgroundColor, this.size, this.imageColor, required this.icon}) : super(key: key);

  @override
  State<SquareButton> createState() => _SquareButtonState();
}

class _SquareButtonState extends State<SquareButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size ?? 50,
      height: widget.size ?? 50,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColor.grey,
        borderRadius: const BorderRadius.all(Radius.circular(15))
      ),
      child: Center(
        child: FaIcon(
          widget.icon,
          color: widget.imageColor ?? AppColor.darkBlue,
          size: widget.size! / 3 + 2,
        ),
      ),
    );
  }
}
