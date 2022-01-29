// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:unipro/lecturer/take_attendance_screen/select_section/select_section_view_model.dart';
import 'package:unipro/lecturer/take_attendance_screen/students_list/student_list_view.dart';
import 'package:unipro/models/course.dart';
import 'package:unipro/profile/profile_view.dart';
import 'package:unipro/studens/course_attendance/course_view.dart';

import '../../../models/currentuser.dart';

// ignore: use_key_in_widget_constructors, camel_case_types
class select_section extends StatefulWidget {
  select_section(this.myUser, this.myCourseCode);
  User myUser;
  String myCourseCode;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<select_section> {
  get child => null;

  var mySections = <String>[];

  getData() async {
    SectionController sc = SectionController();
    print("2");
    mySections =
        await sc.fetchSections(widget.myUser.email, widget.myCourseCode);
    print("3");
    setState(() {});
    print(mySections.toString());
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
          backgroundColor: Color(0xffaa00ff),
          title: Text("These are your Sections"),
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

          child: mySections.length != 0
              ? ListView.builder(
                  itemCount: mySections.length,
                  itemBuilder: (BuildContext context, int indexx) {
                    return ListTile(
                      title: Text(
                        "Section " + mySections.elementAt(indexx),
                        style: TextStyle(color: Colors.grey[800], fontSize: 20),
                      ),
                      tileColor: Colors.grey[300],
                      trailing: Icon(Icons.keyboard_arrow_right_sharp),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => student_list(
                                widget.myUser,
                                widget.myCourseCode,
                                mySections.elementAt(indexx)),
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
