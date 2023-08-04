// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/globals.dart';
import '../models/models.dart';
import 'package:image_picker/image_picker.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({Key? key}) : super(key: key);

  @override
  State<AddContacts> createState() => _AddContacts();
}

class _AddContacts extends State<AddContacts> {
  final ImagePicker _picker = ImagePicker();

  GlobalKey<FormState> contactkey = GlobalKey<FormState>();

  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();

  String? firstname;
  String? lastname;
  String? phonenumber;
  File? image;

  TextStyle mystyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Add",
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (contactkey.currentState!.validate()) {
                  contactkey.currentState!.save();

                  Contact c1 = Contact(
                    firstname: firstname,
                    lastname: lastname,
                    phonenumber: phonenumber,
                    image: image,
                  );

                  try {
                    String userId = FirebaseAuth.instance.currentUser!.uid;
                    DocumentReference docRef = FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .collection('contacts')
                        .doc();
                    await docRef.set(c1.toMap());

                    setState(() {
                      Global.allcontacts.add(c1);
                    });

                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/HomeScreen', (route) => false);
                  } catch (e) {
                    print("Error saving contact: $e");
                  }
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundImage: (image != null) ? FileImage(image!) : null,
                    backgroundColor: Colors.grey,
                    radius: 50,
                    child: Text(
                      (image != null) ? "" : "ADD",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.amber,
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                                'What do you want to take photos from?'),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  XFile? pickedPhoto = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {
                                    image = File(pickedPhoto!.path);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text("ALBUMS"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  XFile? pickedFile = await _picker.pickImage(
                                      source: ImageSource.camera);
                                  setState(() {
                                    image = File(pickedFile!.path);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text("CAMERA"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    mini: true,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Form(
                key: contactkey,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "First Name",
                          style: mystyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: firstnamecontroller,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Your First Name...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            setState(() {
                              firstname = val;
                            });
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "First Name"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Last Name",
                          style: mystyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: lastnamecontroller,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Your Last Name...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            setState(() {
                              lastname = val;
                            });
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Last Name"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Phone Number",
                          style: mystyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: phonenumbercontroller,
                          keyboardType: TextInputType.phone,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Your Number...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            setState(() {
                              phonenumber = val;
                            });
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "+91 0000000000"),
                        ),
                      ],
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
