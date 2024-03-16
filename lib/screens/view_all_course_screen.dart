import 'package:course_enrollment/models/course.dart';
import 'package:course_enrollment/screens/admin_login_screen.dart';
import 'package:course_enrollment/screens/new_enrollment_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_enrollment/app_data_provider.dart';

import 'add_new_course_screen.dart';

class ViewAllCourseScreen extends StatefulWidget {
  static const String routeName = '/viewcourse';

  const ViewAllCourseScreen({super.key});

  @override
  State<ViewAllCourseScreen> createState() => _ViewAllCourseScreenState();
}

class _ViewAllCourseScreenState extends State<ViewAllCourseScreen> {
  void enrollInCourse(Course course) {
    Navigator.pushNamed(context, NewEnrollmentScreen.routeName,
        arguments: course);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppDataProvider>(context, listen: false).checkLoggedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appDataProvider = Provider.of<AppDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Courses'),
        actions: [
          IconButton(
            onPressed: () {
              if (appDataProvider.isLoggedIn) {
                appDataProvider.logout();
              } else {
                Navigator.pushNamed(context, AdminLoginScreen.routeName);
              }
            },
            icon: Icon(appDataProvider.isLoggedIn ? Icons.logout : Icons.login),
          ),
        ],
      ),
      floatingActionButton: appDataProvider.isLoggedIn
          ? FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AddNewCourseScreen.routeName),
              child: const Icon(Icons.add),
            )
          : null, // Hide FAB when logged out
      body: FutureBuilder<List<Course>>(
        future: Provider.of<AppDataProvider>(context).getAllCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            final courseList = snapshot.data!;
            return ListView.builder(
              itemCount: courseList.length,
              itemBuilder: (context, index) {
                final course = courseList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(course.name),
                      subtitle: Text(course.details),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("\$${course.fee.toStringAsFixed(2)}"),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () => enrollInCourse(course),
                            child: const Text('Enroll'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
