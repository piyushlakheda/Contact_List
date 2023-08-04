import 'dart:io';
import '../models/globals.dart';

class Contact {
  final String? firstname;
  final String? lastname;
  final String? phonenumber;

  final File? image;

  Contact({
    required this.firstname,
    required this.lastname,
    required this.phonenumber,
    required this.image,
  });
}
