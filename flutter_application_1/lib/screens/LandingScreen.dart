// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './LoginPage.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 625,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100),
          ),
          color: Colors.amber,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 200,
              left: 20,
              child: Text(
                "${String.fromCharCode(34)}Save\n Your\n Contacts\n  ...",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 80,
              left: 280,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
