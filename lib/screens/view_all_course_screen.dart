import 'package:course_enrollment/app_data_provider.dart';
import 'package:course_enrollment/models/course.dart';
import 'package:course_enrollment/screens/add_new_course_screen.dart';
import 'package:course_enrollment/screens/admin_login_screen.dart';
import 'package:course_enrollment/screens/new_enrollment_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllCourseScreen extends StatefulWidget {
  static const String routeName = '/viewcourse';
  const ViewAllCourseScreen({super.key});

  @override
  State<ViewAllCourseScreen> createState() => _ViewAllCourseScreenState();
}

class DummyCourse {
  final String name;
  final String details;
  final double price;

  const DummyCourse({required this.name, required this.details, required this.price});
}

class _ViewAllCourseScreenState extends State<ViewAllCourseScreen> {
  // Replace this with a list of your actual courses
  final List<Course> _courses = [
    Course(name: 'Course 1', details: 'Course 1 Details', fee: 99.99),
    Course(name: 'Course 2', details: 'Course 2 Details', fee: 89.99),
    Course(name: 'Course 3', details: 'Course 3 Details', fee: 79.99),
  ];

  void enrollInCourse(Course course) {
    Navigator.pushNamed(context, NewEnrollmentScreen.routeName, arguments: course);
  }

  @override
  void didChangeDependencies() {
    Provider.of<AppDataProvider>(context, listen: false).getAllCourse();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Courses'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AdminLoginScreen.routeName),
            icon: const Icon(Icons.login),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AddNewCourseScreen.routeName).then((value) {
          setState(() {

          });
        }),
        child: const Icon(Icons.add),
      ),
      body: Consumer<AppDataProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.courseList.length,
          itemBuilder: (context, index) {
            print(provider.courseList);
            final course = provider.courseList[index];
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
        ),
      ),
    );
  }
}