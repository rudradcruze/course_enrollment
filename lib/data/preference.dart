import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setToken(String token) async {
  final pref = await SharedPreferences.getInstance();
  return pref.setString('token', token);
}

Future<String> getToken() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

Future<void> clearToken() async {
  final pref = await SharedPreferences.getInstance();
  await pref.remove('token');
}