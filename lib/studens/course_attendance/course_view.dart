// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:unipro/lecturer/take_attendance_screen/select_course/selectcourse_view.dart';
import 'package:unipro/models/Attendance.dart';
import 'package:unipro/models/course.dart';
import 'package:unipro/profile/profile_view.dart';
import 'package:unipro/studens/course_attendance/course_view_model.dart';

import '../../models/currentuser.dart';

// ignore: use_key_in_widget_constructors, camel_case_types
class course_attendance extends StatefulWidget {
  course_attendance(this.myUser, this.selectedCourse, this.cName);
  User myUser;
  String selectedCourse;
  String cName;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<course_attendance> {
  get child => null;

  var myAttend = <Attendance>[];

  Widget createTable() {
    checkAttend();
    List<TableRow> rows = [];

    rows.add(TableRow(children: [
      Text(
        "Date",
        style: TextStyle(fontSize: 20.0),
        textAlign: TextAlign.center,
      ),
      Text(
        "Status",
        style: TextStyle(fontSize: 20.0),
        textAlign: TextAlign.center,
      ),
    ]));
    rows.add(TableRow(children: [
      Text(
        "-",
        style: TextStyle(fontSize: 20.0),
        textAlign: TextAlign.center,
      ),
      Text(
        "-",
        style: TextStyle(fontSize: 20.0),
        textAlign: TextAlign.center,
      ),
    ]));
    for (int i = 0; i < myAttend.length; ++i) {
      //TableCellVerticalAlignment vs;
      rows.add(TableRow(children: [
        Text(myAttend.elementAt(i).aDate,
            style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
        Text(
          myAttend.elementAt(i).aStatus,
          style: TextStyle(fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ]));
    }
    setState(() {
      print("updating table");
    });
    return Table(children: rows);
  }

  getData() async {
    AttendanceController cc = AttendanceController();
    print("2");
    myAttend =
        await cc.fetchAttendance(widget.myUser.email, widget.selectedCourse);
    print("3");
    setState(() {});
    print(myAttend.toString());
  }

  bool checkAttend() {
    getData();
    //setState(() {});
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: duplicate_ignore
        appBar: AppBar(
          backgroundColor: Color(0xff00c853),
          title: Text(widget.selectedCourse + " Absentees"),
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

        // ignore: avoid_unnecessary_containers
        body: new Container(
          // ignore: duplicate_ignore
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(40, 20, 20, 10),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Text(
                    widget.myUser.fName + " " + widget.myUser.lName,
                    style: TextStyle(color: Colors.grey, fontSize: 25),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Text(
                    widget.myUser.department,
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Text(
                    widget.myUser.code,
                    style: TextStyle(color: Colors.orange[300], fontSize: 20),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(40, 30, 40, 80),
                  child: Text(
                    'Course: ' + widget.selectedCourse + "-" + widget.cName,
                    style: TextStyle(color: Colors.orange[300], fontSize: 20),
                  )),
              Container(
                decoration: new BoxDecoration(color: Colors.grey[100]),
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: createTable(),
              ),

              myAttend.length == 0
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                      child: Text("You Have no Absentees! Keep it up.",
                          style: TextStyle(fontSize: 25)))
                  : Text("")
//child: Row()

// (
              //   Row( children: [ Container( ListView.builder(itemCount: myAttend.length, itemBuilder: (BuildContext context, int indexx)){
              //     TableRow(children: [
              //     Text(
              //       'Cell 4',
              //       style: TextStyle(fontSize: 20.0),
              //       textAlign: TextAlign.center,
              //     ),
              //     Text(
              //       'Cell 5',
              //       style: TextStyle(fontSize: 20.0),
              //       textAlign: TextAlign.center,
              //     ),
              //   ]),};)
              // ],
            ],
          ),
        ));
  }
}
