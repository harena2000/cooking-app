import 'package:cooking_app/const/color.dart';
import 'package:flutter/material.dart';

class ImageStatus extends StatelessWidget {

  final bool status;
  final String imageUrl;
  final double? statusSize;
  final double? radius;

  const ImageStatus({Key? key, required this.status, required this.imageUrl, this.statusSize, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: radius ?? 25,
          backgroundImage: NetworkImage(imageUrl),
        ),
        status ? Container(
          width: statusSize ?? 10,
          height: statusSize ?? 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColor.orange,
            border: Border.all(color: AppColor.darkBlue, strokeAlign: StrokeAlign.outside, width: 4)
          ),
        ) : Container()
      ],
    );
  }
}
