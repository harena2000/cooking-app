import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../const/color.dart';
import '../text/custom_text.dart';

class NavButton extends StatefulWidget {

  final String text;
  final IconData icon;
  final bool? isSelected;
  final void Function() onClick;

  const NavButton({Key? key, this.isSelected = false, required this.onClick, required this.text, required this.icon}) : super(key: key);

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> with SingleTickerProviderStateMixin{

  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);

    animation = ColorTween(begin: AppColor.lightGrey, end: AppColor.orange)
        .animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void animateColor() {
    widget.isSelected! ? controller.forward() : controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    animateColor();

    return MaterialButton(
      minWidth: 70,
      onPressed: () {
        widget.onClick();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            widget.icon,
            color: animation.value,
            size: 18,
          ),
          const SizedBox(
            height: 4,
          ),
          CustomText(
            text: widget.text,
            size: 9,
            bold: widget.isSelected! ? true : false,
            color: animation.value,
          )
        ],
      ),
    );
  }
}
