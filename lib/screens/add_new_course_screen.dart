import 'package:course_enrollment/app_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewCourseScreen extends StatefulWidget {
  static const String routeName = '/newcourse';
  const AddNewCourseScreen({super.key});

  @override
  State<AddNewCourseScreen> createState() => _AddNewCourseScreenState();
}

class _AddNewCourseScreenState extends State<AddNewCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  String courseName = "";
  String courseDetails = "";
  double coursePrice = 0.0;

  void _saveCourse() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<AppDataProvider>(context, listen: false)
      .addCourse(name: courseName, details: courseDetails, fee: coursePrice)
      .then((value) => Navigator.pop(context))
      .catchError((error) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Course Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a course name';
                  }
                  return null;
                },
                onSaved: (value) => courseName = value!,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Course Details',
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some course details';
                  }
                  return null;
                },
                onSaved: (value) => courseDetails = value!,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Course Price',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the course price';
                  }
                  return null;
                },
                onSaved: (value) => coursePrice = double.parse(value!),
                textInputAction: TextInputAction.done,
              ),
              ElevatedButton(
                onPressed: _saveCourse,
                child: const Text('Save Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}