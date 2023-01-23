import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/const/color.dart';
import 'package:cooking_app/page/message/chat_page.dart';
import 'package:cooking_app/page/profile_page.dart';
import 'package:cooking_app/utils/shared_preferences_utils.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:cooking_app/widget/text_field/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../builder/best_food_provider.dart';
import '../../builder/recent_items_provider.dart';
import '../../widget/button/image_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  String uID = "";
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    var preferencesUtils = SharedPreferencesUtils.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBlue,
      body: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        physics: const PageScrollPhysics(),
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: CustomTextField(
                            backgroundColor: Colors.white.withOpacity(0.1),
                            hintText: "Search food",
                            icon: FontAwesomeIcons.magnifyingGlass)),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ImageButton(
                        onClick: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        },
                        image: FontAwesomeIcons.circleUser,
                        color: AppColor.lightGrey,
                        size: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Expanded(flex: 3, child: BestFoodProvider()),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CustomText(
                        text: "Recent Items",
                        size: 18,
                        bold: true,
                      ),
                      CustomText(
                        text: "View all",
                        color: AppColor.orange,
                        bold: true,
                      )
                    ],
                  ),
                ),
                const Expanded(
                  flex: 5,
                  child: RecentItemsProvider(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
