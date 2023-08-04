// ignore_for_file: file_names, avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/LoginPage.dart';
import 'package:get/get.dart';

signUpUser(
  String userEmail,
  String userPassword,
) async {
  User? userid = FirebaseAuth.instance.currentUser;

  try {
    FirebaseFirestore.instance.collection("users").doc(userid!.uid).set(
      {
        'userEmail': userEmail,
        'createdAt': DateTime.now(),
        'userId': userid.uid,
      },
    ).then(
      (value) => {
        FirebaseAuth.instance.signOut(),
        Get.offAll(() => LoginScreen()),
      },
    );
  } on FirebaseAuthException catch (e) {
    print("Error $e");
  }
}
