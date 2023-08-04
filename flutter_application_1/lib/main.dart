// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/LandingScreen.dart';
import './screens/AddContacts.dart';
import './screens/ContactDetails.dart';
import './screens/EditContact.dart';
import './screens/HomePage.dart';
import './screens/LoginPage.dart';
import './screens/SignupPage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != null ? const HomePage() : const LoginScreen(),
      initialRoute: '/landingScreen',
      getPages: [
        GetPage(name: '/landingScreen', page: () => LandingScreen()),
        GetPage(name: '/LoginPage', page: () => LoginScreen()),
        GetPage(name: '/SignupPage', page: () => SignupScreen()),
        GetPage(name: '/HomeScreen', page: () => HomePage()),
        GetPage(name: '/AddContacts', page: () => AddContacts()),
        GetPage(name: '/ContactDetails', page: () => ContactDetails()),
        GetPage(name: '/EditContacts', page: () => EditContacts()),
      ],
    );
  }
}
