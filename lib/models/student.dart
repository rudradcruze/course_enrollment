import 'course.dart';

class Student {
  final int? id;
  final String userName;
  final String password;
  final String role;
  final Course course;

  Student({
    required this.userName,
    required this.password,
    required this.role,
    required this.course,
    this.id,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json['id'] as int?,
    userName: json['userName'] as String,
    password: json['password'] as String,
    role: json['role'] as String,
    course: Course.fromJson(json['course']),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'userName': userName,
      'password': password,
      'role': role,
      'course': course.toJson(),
    };
    if (id != null) {
      json['id'] = id;
    }
    return json;
  }
}