import 'package:market_peace/model/role.dart';

class User {
  int? id;
  String? username;
  String? password;
  String? name;
  String? surname;
  String? mailAddress;
  List<Role>? roles;

  User(
      {this.id,
        this.username,
        this.password,
        this.name,
        this.surname,
        this.mailAddress,
        this.roles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    name = json['name'];
    surname = json['surname'];
    mailAddress = json['mailAddress'];

    if (json['roles'] != null) {
      roles = <Role>[];
      json['roles'].forEach((v) {
        roles!.add(Role.fromJson(v));
      });
    }
  }
}
