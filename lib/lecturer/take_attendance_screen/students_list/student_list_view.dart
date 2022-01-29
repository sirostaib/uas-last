// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:unipro/lecturer/lecturer_dashbord/lecturer_view.dart';
import 'package:unipro/lecturer/take_attendance_screen/students_list/student_list_view_model.dart';
import 'package:unipro/profile/profile_view.dart';
import 'package:unipro/studens/report_issue/report_issue_view.dart';

import '../../../models/currentuser.dart';

// ignore: use_key_in_widget_constructors, camel_case_types
class student_list extends StatefulWidget {
  student_list(this.myUser, this.cCode, this.section);
  User myUser;
  String section;
  String cCode;
  @override
  _StudentList createState() => _StudentList();
}

class _StudentList extends State<student_list> {
  get child => null;
  List<bool> lst = <bool>[];

  var myStudents = <User>[];

  bool finalCheck = false;

  var check1 = false;
  getData() async {
    StudentController sc = StudentController();
    print("2");
    myStudents = await sc.fetchStudents(
        widget.myUser.email, widget.cCode, widget.section);
    print("3");
    setState(() {
      lst = [];
      for (var i = 0; i < myStudents.length; i++) {
        lst.add(true);
      }
    });
    print(myStudents.toString());
  }

  bool checkStu() {
    getData();
    setState(() {});
    check1 = true;
    return true;
  }

  updateCheck(bool? temp1, int indx) {
    bool temp = lst.elementAt(indx);
    lst.removeAt(indx);
    lst.insert(indx, !temp);
    print(lst.elementAt(indx));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: duplicate_ignore
      appBar: AppBar(
        backgroundColor: Color(0xffaa00ff),
        title: Text("Students List"),
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
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.redAccent,
            ),
            onPressed: () {
              checkStu();
            },
          ),
          AspectRatio(
            aspectRatio: 1.5,
            child: RaisedButton(
                onPressed: () async {
                  StudentController sc = StudentController();
                  finalCheck = await sc.addAttnd(myStudents, widget.cCode, lst);
                  //setState(() {});
                  if (finalCheck) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => lecturer_dashboard(widget.myUser)));
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
          )
        ],
      ),

      // ignore: avoid_unnecessary_containers, unnecessary_new
      body: myStudents.length != 0
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: myStudents.length,
              itemBuilder: (BuildContext context, int indexx) {
                return Column(children: <Widget>[
                  CheckboxListTile(
                    value: lst.elementAt(indexx),
                    onChanged: (j) {
                      setState(() {
                        updateCheck(j, indexx);
                      });
                    },
                    title: Text(
                      myStudents.elementAt(indexx).fName +
                          " " +
                          myStudents.elementAt(indexx).lName,
                      style: TextStyle(color: Colors.grey[800], fontSize: 20),
                    ),
                    secondary: Icon(Icons.person),
                    selected: lst.elementAt(indexx),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ]);
              })
          : Container(
              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
              child: Text(
                "it's either; \n     There are No Students! \n       Or \n     You need to Refresh The Page.",
                style: TextStyle(color: Colors.black, fontSize: 25),
              )),
    );

    // bottom container
  }
}
