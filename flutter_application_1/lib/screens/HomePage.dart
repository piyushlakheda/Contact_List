// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/LoginPage.dart';
import 'package:get/get.dart';
import '../models/globals.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Contacts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.off(() => LoginScreen());
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          setState(() {
            Navigator.of(context).pushNamed('AddContacts');
          });
        },
      ),
      body: (Global.allcontacts.isEmpty)
          ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_box,
                    size: 100,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "You have no contacts yet",
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: Global.allcontacts.length,
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('ContactDetails',
                        arguments: Global.allcontacts[i]);
                  },
                  leading: CircleAvatar(
                    backgroundImage: (Global.allcontacts[i].image != null)
                        ? FileImage(Global.allcontacts[i].image as File)
                        : null,
                  ),
                  title: Text(
                    "${Global.allcontacts[i].firstname} ${Global.allcontacts[i].lastname}",
                  ),
                  subtitle: Text(
                    "+91 ${Global.allcontacts[i].phonenumber} ",
                  ),
                );
              },
            ),
    );
  }
}
