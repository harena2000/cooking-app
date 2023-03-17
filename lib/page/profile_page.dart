import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/page/main_page.dart';
import 'package:cooking_app/service/cloud_storage_service.dart';
import 'package:cooking_app/widget/button/custom_outlined_button.dart';
import 'package:cooking_app/widget/button/image_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../const/color.dart';
import '../widget/text/custom_text.dart';

class ProfilePage extends StatefulWidget {
  final String? uid;

  const ProfilePage({Key? key, this.uid}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var imageFromFile;
  late final _permissionStatus;
  late CloudStorageService storage = CloudStorageService();
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // () async {
    //   _permissionStatus = await Permission.storage.status;
    //
    //   if (_permissionStatus != PermissionStatus.granted) {
    //     PermissionStatus permissionStatus = await Permission.storage.request();
    //     setState(() {
    //       _permissionStatus = permissionStatus;
    //     });
    //   }
    // }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
            text: "User Profile", bold: true, color: Colors.white),
        backgroundColor: AppColor.darkBlue,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MainPage()));
          },
          child: const SizedBox(
            width: 50,
            height: 50,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 15,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppColor.darkBlue,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                FutureBuilder(
                    future: firestore
                        .collection("users")
                        .doc(_auth.currentUser!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return Column(
                          children: [
                            Center(
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width / 2,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Card(
                                      elevation: 0,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          side: const BorderSide(width: 0)),
                                      child: imageFromFile != null
                                          ? Image.file(
                                              File(imageFromFile.path),
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              snapshot.data!['image_profile'],
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 20, bottom: 10),
                                    width: 50,
                                    height: 50,
                                    child: ImageButton(
                                      onClick: () async {
                                        final picker = ImagePicker();
                                        final XFile? image = await picker
                                            .pickImage(
                                                source: ImageSource.camera)
                                            .whenComplete(
                                                () => setState(() {}));

                                        if (image == null) {
                                          const ScaffoldMessenger(
                                            child: CustomText(
                                              text: "No image selected",
                                            ),
                                          );
                                        }

                                        imageFromFile = image;
                                      },
                                      image: FontAwesomeIcons.penToSquare,
                                      size: 20,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.1),
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText(
                                text: snapshot.data!['name'],
                                bold: true,
                                size: 25),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      } else if (snapshot.connectionState ==
                              ConnectionState.waiting ||
                          !snapshot.hasData) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.width / 2,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Card(
                            elevation: 0,
                            color: Colors.white,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: const BorderSide(width: 0)),
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      }

                      return Container();
                    }),
                imageFromFile != null
                    ? CustomOutlinedButton(
                        text: "Modifier",
                        onClick: () {
                          setState(() {
                            isLoading = true;
                            imageFromFile == null;
                          });
                          storage
                              .uploadFile(imageFromFile.path,
                                  _auth.currentUser!.uid, imageFromFile.name)
                              .then((value) => setState(() {
                                    isLoading = false;
                                  }));
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
