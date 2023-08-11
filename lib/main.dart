import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    try {
      final username = _usernameController.text;
      final password = _passwordController.text;

      final url = Uri.parse('http://10.0.2.2:8000/api/login');
      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode({'email': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        print('Logged');
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: _login,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
