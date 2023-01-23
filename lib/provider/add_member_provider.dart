import 'package:cooking_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class GroupMember extends ChangeNotifier {
  List<UserModel> member = [];
  List<String> memberId = [];

  void addMember(UserModel user) {
    member.add(user);
    memberId.add(user.id!);
    notifyListeners();
  }

  void myId(String id) {
    memberId.add(id);
    notifyListeners();
  }

  void removeMember(int index) {
    member.removeAt(index);
    memberId.removeAt(index);
    notifyListeners();
  }

  void removeAll() {
    member.clear();
    memberId.clear();
    notifyListeners();
  }

}