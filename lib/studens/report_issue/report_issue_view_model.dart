import 'package:unipro/models/Attendance.dart';
import '../../models/course.dart';
import '../../models/currentuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unipro/models/currentuser.dart';

class ReportController {
  Future<bool> addIssue(User u, String messagee) async {
    CollectionReference users = FirebaseFirestore.instance.collection('issues');

    // Call the user's CollectionReference to add a new user
    bool done = false;

    await users.add({
      'StudentName': u.fName + " " + u.lName, // John Doe
      'date': DateTime.now().toString().substring(0, 16), // Stokes and Sons
      'email': u.email,
      'department': u.department,
      'phone': u.phone,
      'issueMessage': messagee
    }).then((value) {
      print(" successfully! submitted...");
      done = true;
    }).catchError((error) => print("Failed to add user: $error"));

    return done;
  }
}
