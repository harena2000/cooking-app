import 'package:cooking_app/const/color.dart';
import 'package:flutter/material.dart';

class ImageStatus extends StatelessWidget {

  final bool status;

  const ImageStatus({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(
              "assets/images/profile.jpg"),
        ),
        status ? Container(
          width: 10,
          height: 10,
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
