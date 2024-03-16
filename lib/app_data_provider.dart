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
  DateTime? tokenExpiryTime;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<AuthResponseModel?> login(String name, String password) async {
    final user = AppUser(userName: name, password: password, role: 'ADMIN');
    final response = await dataSource.login(user);
    if (response == null) return null;
    await setToken(response.accessToken);
    tokenExpiryTime =
        DateTime.now().add(Duration(minutes: response.expirationDuration));

    _isLoggedIn = true;
    notifyListeners();
    return response;
  }

  void logout() {
    clearToken();
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> checkLoggedIn() async {
    _isLoggedIn = !isTokenExpired();
    notifyListeners();
  }

  Future<void> addCourse({
    required String name,
    required String details,
    required double fee,
  }) async {
    final course = Course(name: name, details: details, fee: fee);
    await dataSource.addCourse(course);
    await getAllCourses();
    notifyListeners();
  }

  Future<List<Course>> getAllCourses() async {
    courseList = await dataSource.getAllCourses();
    return courseList;
  }

  bool isTokenExpired() {
    return tokenExpiryTime != null && DateTime.now().isAfter(tokenExpiryTime!);
  }
}
