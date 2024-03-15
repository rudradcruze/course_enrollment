import 'dart:convert';
import 'dart:io';

import 'package:course_enrollment/data/preference.dart';
import 'package:course_enrollment/models/auth_response_model.dart';
import 'package:course_enrollment/models/course.dart';
import 'package:http/http.dart' as http;
import '../models/app_user.dart';

class DataSource {
  final String baseUrl = 'http://10.0.2.2:8080/api/v1/';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  }; // Initialize headers for consistency

  Future<Map<String, String>> get authHeaders async {
    final String token = await getToken();
    headers['Authorization'] = 'Bearer $token'; // Add authorization header with token
    return headers; // Return the modified headers
  }

  Future<AuthResponseModel?> login(AppUser user) async {
    final url = Uri.parse('$baseUrl${'auth/login'}'); // Use Uri.parse for clarity
    try {
      final response = await http.post(url, headers: headers, body: jsonEncode(user.toJson()));
      if (response.statusCode == 200) { // Check for success status
        final map = jsonDecode(response.body);
        return AuthResponseModel.fromJson(map);
      } else {
        // Handle login failure with appropriate error handling
        return null;
      }
    } catch (error) {
      // Handle network errors or other exceptions
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
        // Handle course creation failure with appropriate error handling
        throw Exception('Failed to create course: ${response.statusCode}');
      }
    } catch (error) {
      print(error.toString());
      // Consider re-throwing the exception or logging for better error handling
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
        // Handle non-200 status codes with appropriate error handling
        return [];
      }
    } catch (error) {
      print(error.toString());
      return [];
    }
  }
}
