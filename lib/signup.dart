import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
// ignore: unused_field
late bool _success;


// ignore: unused_field
late String _userEmail;

void _register() async{

  final User? user = (
    await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
  ).user;

  if(user != null){
    setState(() {
      _success = true;
      _userEmail = user.email!;
    });
  }else{
    setState(() {
      _success = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Signup Page',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 57, 9, 65),
        ),
        body: Column(
          children: [
            Image.asset(
              'assets/goathletics.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 0,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 10, 10),
              child: TextField(
                decoration: InputDecoration(labelText: 'User full name'),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Register Email'),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
           Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Register Password'),
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              height: 50,
                width: 300,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 57, 9, 65),
                  elevation: 8,
                  child: GestureDetector(
                    onTap: () async {
                      _register();
                      Navigator.of(context).pushNamed('/');
                    },
                    child: const Center(
                      child: Text(
                        'Register',
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
    );
  }
}
