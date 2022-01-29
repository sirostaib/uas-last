import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unipro/models/currentuser.dart';

class LoginController {
  Future<User> loginCheck(String ee, String p) async {
    //var users = FirebaseFirestore.instance.collection('users');
    String check = "none";
    User myUser = User(
        email: "none",
        department: "none",
        fName: "none",
        lName: "none",
        uid: "null",
        code: "the code",
        userType: "none",
        loggedin: false,
        phone: "none");

    await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: ee)
        .where("password", isEqualTo: p)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print("HElllooooo " + doc["courseCode"]);
        if (doc["email"] == ee && doc["password"] == p) {
          if (doc["type"] == "lecturer") {
            print('Correct Login');
            check = "lecturer";

            myUser = User(
                department: doc["department"],
                phone: doc["phone"],
                email: doc["email"],
                fName: doc["fName"],
                lName: doc["lName"],
                code: doc["code"],
                uid: doc.id,
                userType: "lecturer",
                loggedin: true);
          } else if (doc["type"] == "student") {
            print('Correct Login');
            check = "student";
            myUser = User(
                code: doc["code"],
                department: doc["department"],
                email: doc["email"],
                phone: doc["phone"],
                fName: doc["fName"],
                lName: doc["lName"],
                uid: doc.id,
                userType: "student",
                loggedin: true);
          }
        }
      });
    });
    //   });
    // });

    //     .then((DocumentSnapshot documentSnapshot) {

    // });
    if (check == "none") {
      print("Incorrect Email or Password");
    }

    print("the user is: " + myUser.email);

    return myUser;
  }
}
