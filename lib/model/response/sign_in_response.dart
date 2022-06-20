class SignInResponse {
  String? token;
  String? type;
  int? id;
  String? username;
  String? email;
  List<String>? roles;

  SignInResponse({
    this.token,
    this.type,
    this.id,
    this.username,
    this.email,
    this.roles,
  });

  SignInResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
    id = json['id'];
    username = json['username'];
    email = json['email'];
    roles = json['roles'].cast<String>();
  }
}
