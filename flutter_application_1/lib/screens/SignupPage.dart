// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/signUpService.dart';
import './LoginPage.dart';
import './HomePage.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Login'),
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
                      controller: userEmailController,
                      decoration: InputDecoration(
                        hintText: 'Enter you Email',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: 50,
                    right: 50,
                    child: TextFormField(
                      controller: userPasswordController,
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
                        var userEmail = userEmailController.text.trim();
                        var userPassword = userPasswordController.text.trim();

                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: userEmail, password: userPassword)
                            .then((value) => {
                                  print("User Created"),
                                  signUpUser(userEmail, userPassword),
                                });
                      },
                      child: Text('SignUp'),
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
