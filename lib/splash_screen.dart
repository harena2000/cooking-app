import 'dart:async';

import 'package:cooking_app/const/color.dart';
import 'package:cooking_app/on_bording/get_started.dart';
import 'package:cooking_app/page/auth/login_page.dart';
import 'package:cooking_app/page/main_page.dart';
import 'package:cooking_app/utils/shared_preferences_utils.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirstRun = false;
  bool isConnected = false;
  var prefs = SharedPreferencesUtils.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    startTimer();
    prefs.getBooleanValue("isFirstRun").then((value) => isFirstRun = value);

    if(_auth.currentUser != null) {
      isConnected = true;
    }

  }

  startTimer() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
              isFirstRun
                  ? (!isConnected ? const LoginPage() : const MainPage())
                  : const GetStarted()

        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(color: AppColor.darkBlue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "logo",
              child: Image.asset("assets/images/chef-logo.png",
                width: 250,
                height: 250,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            const CustomText(
              text: 'Cooking Chef',
              size: 30,
              color: Colors.white,
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            const SizedBox(
              height: 20,
            ),
            SleekCircularSlider(
              min: 0,
              max: 100,
              initialValue: 100,
              appearance: CircularSliderAppearance(
                infoProperties: InfoProperties(
                    mainLabelStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                )),
                customWidths: CustomSliderWidths(
                    handlerSize: 5, trackWidth: 2, progressBarWidth: 4),
                customColors: CustomSliderColors(
                    dotColor: AppColor.orange,
                    progressBarColor: AppColor.orange,
                    trackColor: Colors.white),
                spinnerDuration: 3,
                animDurationMultiplier: 3,
                animationEnabled: true,
                startAngle: 0.0,
                angleRange: 360,
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
