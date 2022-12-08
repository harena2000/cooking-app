import 'package:cooking_app/const/color.dart';
import 'package:cooking_app/widget/button/custom_button.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:cooking_app/widget/button/square_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeaturedPage extends StatefulWidget {
  const FeaturedPage({Key? key}) : super(key: key);

  @override
  State<FeaturedPage> createState() => _FeaturedPageState();
}

class _FeaturedPageState extends State<FeaturedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
          margin: const EdgeInsets.only(top: 25),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SquareButton(
                      size: 45,
                      icon: FontAwesomeIcons.chevronLeft,
                    ),
                    Row(
                      children: const [
                        SquareButton(
                          size: 45,
                          icon: FontAwesomeIcons.magnifyingGlass,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SquareButton(
                          size: 45,
                          backgroundColor: AppColor.orange,
                          imageColor: Colors.white,
                          icon: FontAwesomeIcons.gripVertical,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 35,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Featured",
                      size: 30,
                      color: AppColor.dark,
                      bold: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: const CustomText(
                              text: "Lorem Ipsum is simply dummy text of the",
                              size: 15,
                              height: 1.5,
                              color: AppColor.dark),
                        ),
                        const CustomButton(
                          backgroundColor: AppColor.dark,
                          text: "View All",
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
