
class AppUser {
  int? id;
  String userName;
  String password;
  String role;

  AppUser({
    this.id,
    required this.userName,
    required this.password,
    required this.role,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    id: json['id'] as int,
    userName: json['userName'] as String,
    password: json['password'] as String,
    role: json['role'] as String,
  );

  Map<String, dynamic> toJson() {
    final json = <String, dynamic> {
      'userName': userName,
      'password': password,
      'role': role,
    };
    if(id != null) {
      json['id'] = id;
    }

    return json;
  }
}