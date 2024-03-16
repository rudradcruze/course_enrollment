import 'dart:convert';
import 'dart:io';

import 'package:course_enrollment/data/preference.dart';
import 'package:course_enrollment/models/auth_response_model.dart';
import 'package:course_enrollment/models/course.dart';
import 'package:http/http.dart' as http;
import '../models/app_user.dart';

class DataSource {
  final String baseUrl = 'http://10.0.2.2:8092/api/v1/';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  Future<Map<String, String>> get authHeaders async {
    final String token = await getToken();
    headers['Authorization'] = 'Bearer $token';
    return headers;
  }

  Future<AuthResponseModel?> login(AppUser user) async {
    final url = '$baseUrl${'auth/login'}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(user.toJson()),
      );
      final map = json.decode(response.body);
      final authResponseModel = AuthResponseModel.fromJson(map);
      return authResponseModel;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<void> addCourse(Course course) async {
    final url = Uri.parse('$baseUrl${'courses'}'); // Use Uri.parse
    try {
      final response = await http.post(url, headers: await authHeaders, body: jsonEncode(course.toJson()));
      if (response.statusCode >= 200 && response.statusCode < 300) { // Check for success status code range
        print(response.statusCode);
      } else {
        throw Exception('Failed to create course: ${response.statusCode}');
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<List<Course>> getAllCourses() async {
    final url = Uri.parse('$baseUrl${'courses'}'); // Use Uri.parse
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final map = jsonDecode(response.body) as List;
        return List.generate(map.length, (index) => Course.fromJson(map[index]));
      } else {
        return [];
      }
    } catch (error) {
      print(error.toString());
      return [];
    }
  }
}
