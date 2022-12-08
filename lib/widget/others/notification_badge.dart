import 'dart:ui';

import 'package:cooking_app/const/color.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  final Color? color;
  final String? count;
  final double? size;

  const NotificationBadge({Key? key, this.color, this.count, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 20,
      height: size ?? 20,
      child: Material(
          clipBehavior: Clip.antiAlias,
          color: color ?? AppColor.orange,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: CustomText(
            text: count ?? "3",
            size: 12,
            color: Colors.white,
            bold: true,
          ))),
    );
  }
}
