import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final SupabaseClient client = Supabase.instance.client;

  Future<void> _signIn() async {
  final currentContext = context;

  try {
    final AuthResponse response = await client.auth.signInWithPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (response.user != null) {
      // Navigate to home if login is successful
      Navigator.pushReplacementNamed(currentContext, '/home');
    } else {
      throw Exception('Failed to log in.');
    }
  } on AuthException catch (e) {
    // Handle auth-related errors
    ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(
      content: Text(e.message),
    ));
  } catch (e) {
    // General error handling
    ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(
      content: Text('An unexpected error occurred.'),
    ));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
