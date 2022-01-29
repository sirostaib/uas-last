// \
import 'package:unipro/models/Attendance.dart';
import 'package:unipro/models/Departments.dart';
import '../../models/course.dart';
import '../../models/currentuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unipro/models/currentuser.dart';

class DepartmentController {
  Future<List<Department>> fetchAttendance(String ee) async {
    bool doublicatee = false;
    //var users = FirebaseFirestore.instance.collection('users');
    //Course mc = Course.copy(email: "Null", cName: "nullll", cCode: "nullllcc");
    print("4");
    late List<Department> myDep = <Department>[];
    await FirebaseFirestore.instance
        .collection('courses')
        //.where("email", isEqualTo: ee)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print("HElllooooo " + doc["courseCode"]);
        for (var i = 0; i < myDep.length; i++) {
          if (myDep.elementAt(i).dName.toString() ==
              doc["department"].toString()) {
            doublicatee = true;
          }
        }
        if (!doublicatee) {
          myDep.add(Department.copy(dName: doc["department"]));
        }
        doublicatee = false;
      });
    });
    //   });
    // });

    //     .then((DocumentSnapshot documentSnapshot) {
    print("6");
    print(myDep);
    return myDep;
  }
}
