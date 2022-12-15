class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.profile,
    required this.email,
    required this.status,
  });

  late final String? id;
  late final String? name;
  late final String? profile;
  late final String? email;
  late final bool? status;

}