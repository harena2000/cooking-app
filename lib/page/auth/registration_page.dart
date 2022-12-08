import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cooking_app/const/color.dart';
import 'package:cooking_app/method/auth_method.dart';
import 'package:cooking_app/page/auth/login_page.dart';
import 'package:cooking_app/page/main_page.dart';
import 'package:cooking_app/widget/button/custom_outlined_button.dart';
import 'package:cooking_app/widget/dialog/message_dialog.dart';
import 'package:cooking_app/widget/text/custom_text.dart';
import 'package:cooking_app/widget/text_field/custom_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../utils/shared_preferences_utils.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isExit = false;

  SharedPreferencesUtils prefs = SharedPreferencesUtils.instance;
  final _auth = FirebaseAuth.instance;

  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";

  bool errorConfirmation = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                FlipInX(
                  child: const CustomText(
                    text: 'Registration',
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Form(
                          key: _formKey,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              CustomTextField(
                                duration: 250,
                                textColor: Colors.white,
                                inputType: TextInputType.text,
                                hintText: "Full name",
                                icon: FontAwesomeIcons.user,
                                backgroundColor:
                                AppColor.grey.withOpacity(0.1),
                                onExit: isExit,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This case can't be empty (required*)";
                                  } else if (value.length < 3) {
                                    return 'Name too short not validate';
                                  }
                                  return null;
                                },
                                onChange: (value) {
                                  name = value;
                                },
                              ),
                              const SizedBox(height: 8.0),
                              CustomTextField(
                                duration: 300,
                                textColor: Colors.white,
                                inputType: TextInputType.emailAddress,
                                hintText: "Email Address",
                                icon: FontAwesomeIcons.envelope,
                                backgroundColor:
                                    AppColor.grey.withOpacity(0.1),
                                onExit: isExit,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This case can't be empty (required*)";
                                  } else if (!EmailValidator.validate(
                                      value)) {
                                    return 'Your email is not validate';
                                  }
                                  return null;
                                },
                                onChange: (value) {
                                  email = value;
                                },
                              ),
                              const SizedBox(height: 8.0),
                              CustomTextField(
                                duration: 350,
                                textColor: Colors.white,
                                hintText: "New password",
                                icon: FontAwesomeIcons.unlockKeyhole,
                                obscureText: true,
                                onExit: isExit,
                                backgroundColor:
                                    AppColor.grey.withOpacity(0.1),
                                validator: (value) {
                                  if (value != null && value.length < 7) {
                                    return 'Enter min. 7 characters';
                                  }
                                  return null;
                                },
                                onChange: (value) {
                                  password = value;
                                },
                              ),
                              const SizedBox(height: 8.0),
                              CustomTextField(
                                duration: 400,
                                textColor: Colors.white,
                                hintText: "Password confirmation",
                                icon: FontAwesomeIcons.lock,
                                backgroundColor:
                                    AppColor.grey.withOpacity(0.1),
                                obscureText: true,
                                onExit: isExit,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password need confirmation';
                                  } else if (value != password) {
                                    return 'Confirmation not match';
                                  }
                                  return null;
                                },
                                onChange: (value) {
                                  confirmPassword = value;
                                },
                              ),
                            ],
                          )),
                      const SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 60, right: 60),
                        child: Column(
                          children: [
                            CustomOutlinedButton(
                              onClick: () async {
                                final isValidForm =
                                    _formKey.currentState!.validate();
                                if (isValidForm) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  createAccount(name, email, password).then((user) {
                                    if (user != null) {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) =>
                                          const MessageDialog(
                                            text:
                                            "User has been register !",
                                            color: Colors.green,
                                            changeScreen: true,
                                            redirectTo: MainPage(),
                                          ));
                                    }
                                    else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) =>
                                          const MessageDialog(
                                            text:
                                            "Error to register !",
                                            color: Colors.red,
                                            changeScreen: false
                                          ));
                                    }
                                  });
                                }
                              },
                              text: "Save",
                              borderColor: Colors.blue,
                              duration: 300,
                              onExit: isExit,
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute<bool>(
                                          builder: (context) =>
                                              const LoginPage()));
                                });
                              },
                              text: "Cancel",
                              borderColor: Colors.red,
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
