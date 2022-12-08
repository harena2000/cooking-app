import 'package:cooking_app/page/nav_page/home_page.dart';
import 'package:cooking_app/page/nav_page/menu_page.dart';
import 'package:cooking_app/page/nav_page/more_page.dart';
import 'package:cooking_app/page/nav_page/others_page.dart';
import 'package:cooking_app/utils/shared_preferences_utils.dart';
import 'package:cooking_app/widget/button/nav_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'users_page.dart';
import '../const/color.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int currentTab = 0;

  List<Widget> screens = const [
    HomePage(),
    MenuPage(),
    OthersPage(),
    UsersPage(),
    MorePage()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  late Animation<Color?> animation;
  late AnimationController controller;

  var prefs = SharedPreferencesUtils.instance;
  final _auth = FirebaseAuth.instance;

  bool homeToggle = true;

  late bool menuToggle,otherToggle,profileToggle,moreToggle = false;

  _uID() async{
    var uID = "";
    await prefs.setStringValue("uID", uID);
  }

  @override
  void initState() {
    super.initState();
    animationAndController();

    _uID();

  }

  void animationAndController() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    animation = ColorTween(begin: AppColor.orange, end: AppColor.dark)
        .animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void animateColor() {
    !homeToggle ? controller.forward() : controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          onPressed: () {
            setState(() {
              currentScreen = const HomePage();
              currentTab = 0;

              homeToggle = true;
            });
            animateColor();
          },
          clipBehavior: Clip.antiAlias,
          backgroundColor: animation.value,
          child: const Padding(
            padding: EdgeInsets.all(15),
            child: FaIcon(FontAwesomeIcons.house),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          height: 75,
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 15,
            elevation: 30,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NavButton(
                        text: 'Menu',
                        icon: FontAwesomeIcons.gripLines,
                        onClick: () {
                          setState(() {
                            currentScreen = const MenuPage();
                            currentTab = 1;

                            homeToggle = false;
                          });
                          animateColor();
                        },
                        isSelected: currentTab == 1 ? true : false,
                      ),
                      NavButton(
                        text: 'Other',
                        icon: FontAwesomeIcons.briefcase,
                        onClick: () {
                          setState(() {
                            currentScreen = const OthersPage();
                            currentTab = 2;

                            homeToggle = false;
                          });
                          animateColor();
                        },
                        isSelected: currentTab == 2 ? true : false,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NavButton(
                        text: 'Message',
                        icon: FontAwesomeIcons.facebookMessenger,
                        onClick: () {
                          setState(() {
                            currentScreen = const UsersPage();
                            currentTab = 3;

                            homeToggle = false;
                          });
                          animateColor();
                        },
                        isSelected: currentTab == 3 ? true : false,
                      ),
                      NavButton(
                        text: 'More',
                        icon: FontAwesomeIcons.gripVertical,
                        onClick: () {
                          setState(() {
                            currentScreen = const MorePage();
                            currentTab = 4;

                            homeToggle = false;
                          });
                          animateColor();
                        },
                        isSelected: currentTab == 4 ? true : false,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
