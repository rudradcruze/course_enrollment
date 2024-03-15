
import 'package:course_enrollment/models/student.dart';

class Course {
  int? id;
  String name;
  String details;
  double fee;
  List<Student> students;

  Course({
    this.id,
    required this.name,
    required this.details,
    required this.fee,
    this.students = const [],
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json['id'] as int,
    name: json['name'] as String,
    details: json['details'] as String,
    fee: json['fee'] as double,
    students: (json['students'] as List<dynamic>?)?.map((studentJson) => Student.fromJson(studentJson)).toList() ?? const [],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'name': name,
      'details': details,
      'fee': fee,
      'students': students.map((student) => student.toJson()).toList(),
    };
    if (id != null) {
      json['id'] = id;
    }
    return json;
  }
}