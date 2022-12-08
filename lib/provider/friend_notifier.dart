import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class DataFriendProvider extends ChangeNotifier {
  late String roomId;

  void changeFriend(String value) {
    roomId = value;
    notifyListeners();
  }

}