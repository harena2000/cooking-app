import 'package:flutter/material.dart';
import '../widget/text/custom_text.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 110),
          child: const Center(
            child: CircleAvatar(
              radius: 150,
              backgroundImage: AssetImage("assets/images/serving.jpg"),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 35),
          width: MediaQuery.of(context).size.width - 100,
          child: const CustomText(
              softWrap: false,
              overflow: TextOverflow.visible,
              text: "Cooking Experience Like a Chef",
              size: 45,
              color: Colors.white,
              bold: true),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width - 100,
          child: const CustomText(
              softWrap: false,
              overflow: TextOverflow.visible,
              text:
                  "Let's make a delicious dish with the best recipe for the family",
              height: 1.8,
              size: 14,
              color: Colors.grey,
              bold: false),
        )
      ],
    );
  }
}
