// \
import 'package:unipro/models/Attendance.dart';
import 'package:unipro/models/Departments.dart';
import 'package:unipro/models/course.dart';
import '../../models/course.dart';
import '../../models/currentuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unipro/models/currentuser.dart';

class CourseDepController {
  Future<List<Course>> fetchDepCourse(String ee, String dd) async {
    bool doublicatee = false;
    //var users = FirebaseFirestore.instance.collection('users');
    //Course mc = Course.copy(email: "Null", cName: "nullll", cCode: "nullllcc");
    print("4");
    late List<Course> myCourse = <Course>[];
    await FirebaseFirestore.instance
        .collection('courses')
        //.where("email", isEqualTo: ee)
        .where("department", isEqualTo: dd)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print("HElllooooo " + doc["courseCode"]);
        for (var i = 0; i < myCourse.length; i++) {
          if (myCourse.elementAt(i).cCode.toString() ==
              doc["courseCode"].toString()) {
            doublicatee = true;
          }
        }
        if (!doublicatee) {
          myCourse.add(Course.copy(
              email: ee, cName: doc["courseName"], cCode: doc["courseCode"]));
        }
        doublicatee = false;
      });
    });
    //   });
    // });

    //     .then((DocumentSnapshot documentSnapshot) {
    print("6");
    print(myCourse);
    return myCourse;
  }
}
