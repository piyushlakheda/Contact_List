// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable, unnecessary_nullable_for_final_variable_declarations, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './SignupPage.dart';
import './HomePage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(215, 53, 64, 1),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'New User?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ),
                    );
                  },
                  child: Text('SignUp'),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 400,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(90),
                  topRight: Radius.circular(90),
                ),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 100,
                    left: 50,
                    right: 50,
                    child: TextFormField(
                      controller: loginEmailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your Email',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: 50,
                    right: 50,
                    child: TextFormField(
                      controller: loginPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 250,
                    right: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        var loginEmail = loginEmailController.text.trim();
                        var loginPassword = loginPasswordController.text.trim();

                        try {
                          final User? firebaseUser = (await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                      email: loginEmail,
                                      password: loginPassword))
                              .user;
                          if (firebaseUser != null) {
                            Get.to(HomePage());
                          } else {
                            print("Check Email and password");
                          }
                        } on FirebaseAuthException catch (e) {
                          print("Error $e");
                        }
                      },
                      child: Text('Login'),
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    right: 198,
                    child: Text(
                      "OR",
                      style: TextStyle(
                          color: Colors.amber[900],
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 240,
                    child: Image.network(
                      'https://static.xx.fbcdn.net/rsrc.php/v3/yu/r/-UrAiCz94rq.png',
                    ),
                    height: 40,
                    width: 40,
                  ),
                  Positioned(
                    bottom: 30,
                    left: 120,
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6uQZJg4Xx41AINJoZhayxbfYfdZGtx_9vDIrGhb2VMw&s',
                    ),
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
