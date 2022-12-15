import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class CloudStorageService {

  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void setProfile(String image) async {
    await firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .update({"image_profile": image});
  }

  Future<void> uploadFile(
      String path, String uid, String fileName
      ) async {

    File file = File(path);

    try{

      await storage.ref('$uid/$fileName').putFile(file);
      var imageUrl = await getUrlImage(_auth.currentUser!.uid, fileName);
      setProfile(imageUrl);

    } on firebase_core.FirebaseException catch(e) {
      print(e);
    }
  }

  Future<String> _copyAssetToLocal() async {
      var content = await rootBundle.load("assets/images/profile.jpg");
      final directory = await getApplicationDocumentsDirectory();
      var file = File("${directory.path}/$content");
      file.writeAsBytesSync(content.buffer.asUint8List());
      return file.path;
  }

  Future<String?> createDirectory(String currentUser) async {
    firebase_storage.ListResult getName = await storage.ref(currentUser).listAll();
    if(getName.items.isEmpty){
      var path = await _copyAssetToLocal();
      await storage.ref("$currentUser/default-profile").putFile(File(path));
      var imageUrl = await storage.ref("$currentUser/default-profile").getDownloadURL();

      return imageUrl;

    }
    return null;
  }

  Future<String> getUrlImage(String currentUser, String filename) async {
    String result = await storage.ref("$currentUser/$filename").getDownloadURL();
    return result;
  }

}