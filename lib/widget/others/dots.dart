import 'package:flutter/cupertino.dart';
import '../../const/color.dart';

class Dots extends StatefulWidget {

  final bool? isScroll;

  const Dots({Key? key, this.isScroll = true}) : super(key: key);

  @override
  State<Dots> createState() => _DotsState();
}

class _DotsState extends State<Dots> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3, right: 3),
      width: widget.isScroll! ? 28 : 15,
      height: 15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.isScroll! ? AppColor.orange : AppColor.orangeWithOpacity
      ),
    );
  }
}
