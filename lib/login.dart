import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _success = 1;
  String _userEmail = "";

  void _signIn() async {
  if (mounted) {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final User? user = userCredential.user;

      if (mounted) {
        setState(() {
          _success = user != null ? 2 : 3;
          _userEmail = user?.email ?? '';
        });

        if (_success == 2) {
          Navigator.of(context).pushReplacementNamed('/homepage');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _success = 3;
        });
      }
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login Page',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 57, 9, 65),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/goathletics.png',
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'User email'),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
                child: TextField(
                  controller: _passwordController,
                  decoration:
                      const InputDecoration(labelText: 'User password:'),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/signup');
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 20),
                child: Text(
                  _success == 1
                      ? ''
                      : (_success == 2
                          ? 'Successfully signed in: $_userEmail'
                          : 'Login failed please check password or register'),
                  style: const TextStyle(color: Color.fromARGB(255, 57, 9, 65)),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 57, 9, 65),
                  elevation: 7,
                  child: GestureDetector(
                    onTap: () async {
                      _signIn();
                      
                    },
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
