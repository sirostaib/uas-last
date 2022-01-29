import 'package:unipro/models/Attendance.dart';
import '../../models/course.dart';
import '../../models/currentuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unipro/models/currentuser.dart';

class SectionController {
  Future<List<String>> fetchSections(String ee, String cc) async {
    //var users = FirebaseFirestore.instance.collection('users');
    //Course mc = Course.copy(email: "Null", cName: "nullll", cCode: "nullllcc");
    print("4");
    late List<String> mySections = <String>[];
    await FirebaseFirestore.instance
        .collection('courses')
        //.where("email", isEqualTo: ee)  To show only the classes that the lecturer is registered in
        .where("courseCode", isEqualTo: cc)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print("nice bro" + doc["section"]);
        bool doublicatee = false;
        //print("HElllooooo " + doc["courseCode"]);
        for (var i = 0; i < mySections.length; i++) {
          if (mySections.elementAt(i).toString() == doc["section"].toString()) {
            doublicatee = true;
          }
        }
        if (!doublicatee) {
          mySections.add(doc["section"]);
        }
        doublicatee = false;
      });
    });
    //   });
    // });

    //     .then((DocumentSnapshot documentSnapshot) {
    print("6");
    print(mySections);
    return mySections;
  }
}
