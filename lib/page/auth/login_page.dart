import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cooking_app/const/color.dart';
import 'package:cooking_app/method/auth_method.dart';
import 'package:cooking_app/page/auth/registration_page.dart';
import 'package:cooking_app/page/main_page.dart';
import 'package:cooking_app/utils/shared_preferences_utils.dart';
import 'package:cooking_app/widget/button/custom_outlined_button.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:cooking_app/widget/text_field/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../widget/dialog/message_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isFirstRun = false;
  final ScrollController _scrollController = ScrollController();
  bool isExit = false;
  bool? push = false;
  bool isLoading = false;

  SharedPreferencesUtils prefs = SharedPreferencesUtils.instance;

  String email = "", password = "";

  final _auth = FirebaseAuth.instance;

  void _redirectToMainPage(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MainPage()));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: AppColor.darkBlue),
          child: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Hero(
                    tag: "logo",
                    child: Image.asset(
                      "assets/images/chef-logo.png",
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                FlipInX(
                  child: const CustomText(
                    text: 'Login',
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        inputType: TextInputType.emailAddress,
                        textColor: Colors.white,
                        hintText: "Email Address",
                        icon: FontAwesomeIcons.envelope,
                        backgroundColor: AppColor.grey.withOpacity(0.1),
                        onChange: (value) {
                          email = value;
                        },
                        onExit: isExit,
                      ),
                      const SizedBox(height: 8.0),
                      CustomTextField(
                        duration: 400,
                        textColor: Colors.white,
                        hintText: "Password",
                        icon: FontAwesomeIcons.lock,
                        backgroundColor: AppColor.grey.withOpacity(0.1),
                        obscureText: true,
                        onChange: (value) {
                          password = value;
                        },
                        onExit: isExit,
                      ),
                      const SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 60, right: 60),
                        child: Column(
                          children: [
                            CustomOutlinedButton(
                              duration: 300,
                              onExit: isExit,
                              onClick: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                login(email, password).then((user) {

                                  if (user != null) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    _redirectToMainPage();
                                  }
                                  else {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) =>
                                        const MessageDialog(
                                            text:
                                            "Verify your email/password",
                                            color: Colors.red,
                                            changeScreen: false
                                        ));
                                  }
                                });
                              },
                              text: "Connexion",
                              borderColor: Colors.blue,
                            ),
                            const SizedBox(height: 5),
                            CustomOutlinedButton(
                              duration: 500,
                              onExit: isExit,
                              onClick: () {
                                setState(() {
                                  isExit = true;
                                });
                                Timer(const Duration(milliseconds: 300),
                                    () async {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute<bool>(
                                          builder: (context) =>
                                              const RegistrationPage()));
                                });
                              },
                              text: "Registration",
                              borderColor: AppColor.orange,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
