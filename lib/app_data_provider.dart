import 'dart:convert';

import 'package:course_enrollment/data/data_source.dart';
import 'package:course_enrollment/data/preference.dart';
import 'package:course_enrollment/models/app_user.dart';
import 'package:flutter/foundation.dart';

import 'models/auth_response_model.dart';
import 'models/course.dart';

class AppDataProvider extends ChangeNotifier {
  final dataSource = DataSource();
  List<Course> courseList = [];

  Future<AuthResponseModel?> login(String name, String password) async {
    final user = AppUser(userName: name, password: password, role: 'ADMIN');
    final response = await dataSource.login(user);
    if(response == null) return null;
    await setToken(response.accessToken);
    return response;
  }

  Future<void> addCourse({required String name, required String details, required double fee}) async {
    final course = Course(name: name, details: details, fee: fee);
    await dataSource.addCourse(course);
  }

  Future<void> getAllCourse() async {
    courseList = await dataSource.getAllCourses();
    notifyListeners();
  }
}