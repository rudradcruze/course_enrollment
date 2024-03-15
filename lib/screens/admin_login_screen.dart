
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_data_provider.dart';
import '../utils/widget_functions.dart';

class AdminLoginScreen extends StatefulWidget {
  static const String routeName = "/login"; // Static constant for named route

  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey for Form
  bool _obscureText = true; // Flag for password visibility

  String _username = "";
  String _password = "";

  void login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final response = await Provider.of<AppDataProvider>(context, listen: false).login(_username, _password);
      if(response != null) {
        showMsg(context, response.message);
        Navigator.pop(context);
      } else {
        showMsg(context, 'Login failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onSaved: (value) => _username = value!,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscureText = !_obscureText);
                    },
                  ),
                ),
                obscureText: _obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
                textInputAction: TextInputAction.done,
              ),
              ElevatedButton(
                onPressed: login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}