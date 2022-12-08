import 'package:cooking_app/const/color.dart';
import 'package:cooking_app/on_bording/first_page.dart';
import 'package:cooking_app/on_bording/second_page.dart';
import 'package:cooking_app/on_bording/third_page.dart';
import 'package:cooking_app/page/auth/login_page.dart';
import 'package:cooking_app/utils/custom_page_route.dart';
import 'package:cooking_app/widget/button/custom_button.dart';
import 'package:cooking_app/widget/others/dots.dart';
import 'package:flutter/material.dart';

import '../utils/shared_preferences_utils.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  List<Widget> pages = const [
    FirstPage(),
    SecondPage(),
    ThirdPage(),
  ];

  bool isScroll = true;

  late PageController _pageController;

  _inFirstRun() async {
    SharedPreferencesUtils prefs = SharedPreferencesUtils.instance;
    await prefs.setBooleanValue("isFirstRun", true);
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();

    _inFirstRun();

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColor.darkBlue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pages.length,
              controller: _pageController,
              itemBuilder: (_, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pages[index],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(pages.length, (indexDots) {
                            return index == indexDots
                                ? const Dots(isScroll: true)
                                : const Dots(isScroll: false);
                          }),
                        ),
                        CustomButton(
                            onClick: () {
                              if (pages.length != index + 1) {
                                _pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate
                                );
                              } else {
                                  Navigator.push(context, CustomPageRoute(
                                      child: const LoginPage(),
                                  )
                                );
                              }
                            },
                            text: (pages.length == index + 1)
                                ? "Get Started"
                                : "Next"
                        )
                      ],
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
