import 'package:course_enrollment/screens/view_all_course_screen.dart';
import 'package:flutter/material.dart';

import '../models/course.dart';

class NewEnrollmentScreen extends StatefulWidget {
  static const String routeName = "/newenrollment";
  const NewEnrollmentScreen({super.key});

  @override
  State<NewEnrollmentScreen> createState() => _NewEnrollmentScreenState();
}

class _NewEnrollmentScreenState extends State<NewEnrollmentScreen> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey for Form validation
  String _name = "";
  String _mobileNumber = "";
  String _email = "";
  String _selectedCourse = "";// To store selected course

  late Course course;

  void enroll() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Call your logic to enroll student with entered info and selected course
      // e.g., enrollStudent(_name, _mobileNumber, _email, _selectedCourse);
      print("Enrolling student: Name: $_name, Mobile: $_mobileNumber, Email: $_email, Course: $_selectedCourse");
      // Navigate back to previous screen after enrollment
      Navigator.pop(context);
    }
  }

  @override
  void didChangeDependencies() {
    course = ModalRoute.of(context)!.settings.arguments as Course;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Enrollment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Student Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
                onSaved: (value) => _mobileNumber = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              ElevatedButton(
                onPressed: enroll,
                child: const Text('Enroll'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}