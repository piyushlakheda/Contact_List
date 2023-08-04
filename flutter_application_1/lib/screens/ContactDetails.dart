// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../models/globals.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetails();
}

class _ContactDetails extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Contacts",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Spacer(
                flex: 8,
              ),
              CircleAvatar(
                backgroundImage:
                    (res.image != null) ? FileImage(res.image!) : null,
                backgroundColor: Colors.grey,
                radius: 55,
                child: Text(
                  (res.image != null) ? "" : "ADD",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              IconButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: const Text('Are You Sure...'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('yes'),
                              onPressed: () {
                                Global.allcontacts.remove(res);

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'HomeScreen', (route) => false);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    Global.allcontacts.remove(res);

                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.red),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('editpage', arguments: res);
                  },
                  icon: const Icon(Icons.edit),
                  color: Colors.blueGrey),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "${res.firstname} ${res.lastname}",
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "+91 ${res.phonenumber} ",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
