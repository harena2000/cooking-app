import 'package:flutter/material.dart';
import '../widget/text/custom_text.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: const Hero(
            tag: 'logo',
            child: Image(
              image: AssetImage("assets/images/chef-logo.png"),
              width: 380,
              height: 380,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 35),
          width: MediaQuery.of(context).size.width - 100,
          child: const CustomText(
              text: "Cooking Experience Like a Chef",
              size: 45,
              color: Colors.white,
              softWrap: true,
              overflow: TextOverflow.visible,
              bold: true
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width - 100,
          child: const CustomText(
              text: "Let's make a delicious dish with the best recipe for the family",
              softWrap: false,
              overflow: TextOverflow.visible,
              height: 1.8,
              size: 14,
              color: Colors.grey,
              bold: false
          ),
        )
      ],
    );
  }
}
