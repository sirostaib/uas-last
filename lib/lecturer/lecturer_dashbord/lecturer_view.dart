// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:unipro/lecturer/lecturer_dashbord/lecturer_view_model.dart';
import 'package:unipro/lecturer/take_attendance_screen/select_course/selectcourse_view.dart';
import 'package:unipro/models/Departments.dart';
import 'package:unipro/profile/profile_view.dart';
import 'package:unipro/studens/course_attendance/course_view.dart';

import '../../models/currentuser.dart';

// ignore: use_key_in_widget_constructors, camel_case_types
class lecturer_dashboard extends StatefulWidget {
  lecturer_dashboard(this.myUser);
  late User myUser;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<lecturer_dashboard> {
  get child => null;
  var myDept = <Department>[];

  getData() async {
    DepartmentController dc = DepartmentController();
    print("2");
    myDept = await dc.fetchAttendance(widget.myUser.email);
    print("3");
    setState(() {});
    print(myDept.toString());
  }

  bool checkDept() {
    getData();
    setState(() {});
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: duplicate_ignore
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffaa00ff),
          title: Text("Lecturer Dashboard - " + widget.myUser.fName),
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
            )
          ],
        ),
        // ignore: unnecessary_new, avoid_unnecessary_containers
        body: Container(
          //Text("These are your Courses: "),

          child: myDept.length != 0
              ? ListView.builder(
                  itemCount: myDept.length,
                  itemBuilder: (BuildContext context, int indexx) {
                    return ListTile(
                      title: Text(
                        myDept.elementAt(indexx).dName,
                        style: TextStyle(color: Colors.grey[800], fontSize: 20),
                      ),
                      tileColor: Colors.grey[300],
                      trailing: Icon(Icons.keyboard_arrow_right_sharp),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => select_course(
                                widget.myUser, myDept.elementAt(indexx).dName),
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
                    checkDept() ? Text("") : Text(""),
                  ],
                ),
        ));
  }
}
