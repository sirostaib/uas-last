import 'package:unipro/models/Attendance.dart';
import '../../models/course.dart';
import '../../models/currentuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unipro/models/currentuser.dart';

class StudentController {
  Future<List<User>> fetchStudents(String ee, String cc, String cs) async {
    //var users = FirebaseFirestore.instance.collection('users');
    //Course mc = Course.copy(email: "Null", cName: "nullll", cCode: "nullllcc");
    print("4");
    late List<User> myUsers = <User>[];
    await FirebaseFirestore.instance
        .collection('courses')
        //.where("email", isEqualTo: ee)
        .where("courseCode", isEqualTo: cc)
        .where("section", isEqualTo: cs)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print("nice bro" + doc["section"]);

        myUsers.add(User.lastNot(email: doc["email"]));
      });
    });

    late List<User> myStudents = <User>[];

    for (var i = 0; i < myUsers.length; i++) {
      await FirebaseFirestore.instance
          .collection('users')
          //.where("email", isEqualTo: ee)
          .where("email", isEqualTo: myUsers.elementAt(i).email)
          .where("type", isEqualTo: "student")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          //print("nice bro" + doc["section"]);

          myStudents.add(User(
              uid: doc.id,
              code: doc["code"],
              department: doc["department"],
              email: myUsers.elementAt(i).email,
              fName: doc["fName"],
              lName: doc["lName"],
              userType: "student",
              loggedin: false,
              phone: doc["phone"]));
        });
      });
    }

    //   });
    // });

    //     .then((DocumentSnapshot documentSnapshot) {

    print("6");
    print(myStudents);
    return myStudents;
  }

  Future<bool> addAttnd(List<User> u, String cc, List<bool> st) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('attendance');

    // Call the user's CollectionReference to add a new user
    bool done = false;
    bool temp = true;
    String tempEmail = "";
    var tempValue = "Present";
    print(st.toString());

    for (var i = 0; i < st.length; i++) {
      !st.elementAt(i) ? temp = false : null;
      tempEmail = u.elementAt(i).email;
      if (temp == false) {
        tempValue = "Absent";
      }

      await users.add({
        'courseCode': cc, // John Doe
        'date': DateTime.now().toString().substring(0, 16), // Stokes and Sons
        'email': tempEmail,
        'status': tempValue
      }).then((value) {
        print(cc + " was submitted...");
        done = true;
        temp = true;
      }).catchError((error) => print("Failed to add user: $error"));
    }
    return done;
  }
}
