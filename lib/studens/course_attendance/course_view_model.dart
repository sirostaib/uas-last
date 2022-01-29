// \
import 'package:unipro/models/Attendance.dart';
import '../../models/course.dart';
import '../../models/currentuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unipro/models/currentuser.dart';

class AttendanceController {
  Future<List<Attendance>> fetchAttendance(String ee, String cc) async {
    //var users = FirebaseFirestore.instance.collection('users');
    //Course mc = Course.copy(email: "Null", cName: "nullll", cCode: "nullllcc");
    print("4");
    late List<Attendance> myAttend = <Attendance>[];
    await FirebaseFirestore.instance
        .collection('attendance')
        .where("email", isEqualTo: ee)
        .where("courseCode", isEqualTo: cc)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        //print("HElllooooo " + doc["courseCode"]);
        print("workssss");
        myAttend
            .add(Attendance.copy(aDate: doc["date"], aStatus: doc["status"]));
      }
    });
    //   });
    // });

    //     .then((DocumentSnapshot documentSnapshot) {
    print("6");
    print(myAttend);
    return myAttend;
  }
}
