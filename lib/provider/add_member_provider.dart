import 'package:cooking_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class GroupMember extends ChangeNotifier {
  Map<String,UserModel> member = {};

  void addMember(String id, UserModel user) {
    member = {
      id : user
    };
    notifyListeners();
  }

  void removeMember(String id) {
    member.remove(id);
    notifyListeners();
  }

}