import 'package:course_enrollment/app_data_provider.dart';
import 'package:course_enrollment/screens/add_new_course_screen.dart';
import 'package:course_enrollment/screens/admin_login_screen.dart';
import 'package:course_enrollment/screens/new_enrollment_page.dart';
import 'package:course_enrollment/screens/view_all_course_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppDataProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: ViewAllCourseScreen.routeName,
      routes: {
        AddNewCourseScreen.routeName : (context) => const AddNewCourseScreen(),
        AdminLoginScreen.routeName : (context) => const AdminLoginScreen(),
        NewEnrollmentScreen.routeName : (context) => const NewEnrollmentScreen(),
        ViewAllCourseScreen.routeName : (context) => const ViewAllCourseScreen(),
      },
    );
  }
}


