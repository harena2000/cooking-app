import 'package:cooking_app/page/auth/login_page.dart';
import 'package:cooking_app/utils/shared_preferences_utils.dart';
import 'package:cooking_app/widget/button/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

  final _auth = FirebaseAuth.instance;

  void _setUID() async {
    SharedPreferencesUtils preferencesUtils = SharedPreferencesUtils.instance;
    await preferencesUtils.setStringValue("uID", "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CustomButton(
            text: "Log Out",
            onClick: (){
              _auth.signOut();
              _setUID();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            }
          )
        ],
      ),
    );
  }
}
