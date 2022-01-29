import '../../models/course.dart';
import '../../models/currentuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unipro/models/currentuser.dart';

class CController {
  Future<List<Course>> fetchCourses(String ee) async {
    //var users = FirebaseFirestore.instance.collection('users');
    //Course mc = Course.copy(email: "Null", cName: "nullll", cCode: "nullllcc");
    print("4");
    late List<Course> myCourses = <Course>[];
    await FirebaseFirestore.instance
        .collection('courses')
        .where("email", isEqualTo: ee)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("HElllooooo " + doc["courseCode"]);
        myCourses.add(Course.copy(
            email: doc["email"],
            cName: doc["courseName"],
            cCode: doc["courseCode"]));
      });
    });
    //   });
    // });

    //     .then((DocumentSnapshot documentSnapshot) {
    print("6");
    print(myCourses);
    return myCourses;
  }
}

class CourseController {
  void fetchCoursess(String u) async {
    print("4");
    late List<Course> myCourses = <Course>[];

    await FirebaseFirestore.instance
        .collection('courses')
        .where("email", isEqualTo: u)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print("helllooo");
        myCourses.add(Course.copy(
            email: doc["email"],
            cName: doc["courseName"],
            cCode: doc["courseCode"]));
      }
      print("5");
    });
    print("6");
    print(myCourses);
    //return myCourses;
  }

  // void fetchCourses(String e) async {
  //   //final courses = List<Course>.empty();
  //   //courses.add(Course.copy(cCode: "", cName: "", email: ""));
  //   // final doc = await FirebaseFirestore.instance
  //   //     .collection('courses')
  //   //     .where('email', isEqualTo: u.email)
  //   //     .get()
  //   //     .then((QuerySnapshot querySnapshot) {
  //   //   querySnapshot.docs.forEach((docss) {
  //   //     // courses.add(Course.copy(
  //   //     //     email: u.email,
  //   //     //     cName: docs["courseName"],
  //   //     //     cCode: docs["courseCode"]));
  //   //     print(docss.toString());
  //   //   });
  //   // });
  //   print("email isssss " + e);
  //   await FirebaseFirestore.instance
  //       .collection('courses')
  //       .where("email", isEqualTo: e)
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       print(e);
  //       print(doc["courseName"]);
  //     });
  //   });
  //   //return Course.copy(email: "email", cName: "", cCode: "");
  // }
  // // ignore: unused_local_variable
  // //var courses;

}
