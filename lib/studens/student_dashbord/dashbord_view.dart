// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:unipro/models/course.dart';
import 'package:unipro/profile/profile_view.dart';
import 'package:unipro/studens/course_attendance/course_view.dart';
import 'package:unipro/models/course.dart';
import 'package:unipro/studens/student_dashbord/dashbord_viiew_model.dart';
import '../../models/currentuser.dart';

// ignore: use_key_in_widget_constructors, camel_case_types
class student_dashbord extends StatefulWidget {
  student_dashbord(this.myUser);
  User myUser;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<student_dashbord> {
  //get child => null;
  var myCourses = <Course>[];
  _HomePageState();

  getData() async {
    CController cc = CController();
    print("2");
    myCourses = await cc.fetchCourses(widget.myUser.email);
    print("3");
    setState(() {});
    print(myCourses.toString());
  }

  bool checkCourses() {
    getData();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: duplicate_ignore
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff00c853),
        title: Text("Student Dashboard - " + widget.myUser.fName),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => profile_view(widget.myUser)));

              // do something
            },
          ),
          // await getData() ? Text("") : Text(""),
        ],
      ),

      body: Container(
        //Text("These are your Courses: "),

        child: myCourses.length != 0
            ? ListView.builder(
                itemCount: myCourses.length == 0 ? 0 : myCourses.length,
                itemBuilder: (BuildContext context, int indexx) {
                  return ListTile(
                    title: Text(
                      myCourses.elementAt(indexx).cName,
                      style: TextStyle(color: Colors.grey[800], fontSize: 20),
                    ),
                    tileColor: Colors.grey[300],
                    trailing: Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => course_attendance(
                              widget.myUser,
                              myCourses.elementAt(indexx).cCode,
                              myCourses.elementAt(indexx).cName),
                        ),
                      );
                    },
                  );
                })
            : Row(
                children: [
                  Center(
                    child: Text(
                      "There Are no Courses!",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  checkCourses() ? Text("") : Text(""),
                ],
              ),
      ),
    );
  }
}
