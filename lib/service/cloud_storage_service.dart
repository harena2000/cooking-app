import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class CloudStorageService {

  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
      String path, String uid, String fileName
      ) async {

    File file = File(path);

    try{

      await storage.ref('$uid/$fileName').putFile(file);

    } on firebase_core.FirebaseException catch(e) {
      print(e);
    }
  }

  Future<String?> profileImage(String currentUser) async {
      String result = await storage.ref("$currentUser/").getDownloadURL();
      return result;
  }

}