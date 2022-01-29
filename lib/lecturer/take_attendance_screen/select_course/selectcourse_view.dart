// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:unipro/lecturer/take_attendance_screen/select_course/selectcourse_view_model.dart';
import 'package:unipro/lecturer/take_attendance_screen/select_section/select_section_view.dart';
import 'package:unipro/models/course.dart';
import 'package:unipro/profile/profile_view.dart';
import 'package:unipro/studens/course_attendance/course_view.dart';

import '../../../models/currentuser.dart';

// ignore: use_key_in_widget_constructors, camel_case_types
class select_course extends StatefulWidget {
  select_course(this.myUser, this.selectedDept);
  User myUser;
  String selectedDept;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<select_course> {
  get child => null;

  var myCourse = <Course>[];

  getData() async {
    CourseDepController dc = CourseDepController();
    print("2");
    myCourse =
        await dc.fetchDepCourse(widget.myUser.email, widget.selectedDept);
    print("3");
    setState(() {});
    print(myCourse.toString());
  }

  bool checkDept() {
    getData();
    setState(() {});
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffaa00ff),
        title: Text("Courses in " + widget.selectedDept),
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
      body: new Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: myCourse.length != 0
            ? ListView.builder(
                itemCount: myCourse.length,
                itemBuilder: (BuildContext context, int indexx) {
                  return ListTile(
                    title: Text(
                      myCourse.elementAt(indexx).cName,
                      style: TextStyle(color: Colors.grey[800], fontSize: 20),
                    ),
                    tileColor: Colors.grey[300],
                    trailing: Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => select_section(
                              widget.myUser,
                              myCourse.elementAt(indexx).cCode,
                            ),
                          ));
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
      ),
    );
  }
}
