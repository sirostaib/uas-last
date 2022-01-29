// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:unipro/profile/profile_view.dart';
import 'package:unipro/studens/report_issue/report_issue_view_model.dart';
import 'package:unipro/studens/student_dashbord/dashbord_view.dart';

import '../../models/currentuser.dart';

// ignore: use_key_in_widget_constructors, camel_case_types
class report_issue_view extends StatefulWidget {
  report_issue_view(this.myUser);
  User myUser;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<report_issue_view> {
  get child => null;

  String messageText = "";

  @override
  Widget build(BuildContext context) {
    var leading;
    return Scaffold(
        // ignore: duplicate_ignore
        appBar: AppBar(
          backgroundColor: Color(0xFF059943),
          title: Text("report-issue"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {
                /// Navigator.push(
                // context,
                //MaterialPageRoute(
                //builder: (_) => profile_view(User.copy())));
                // do something
              },
            )
          ],
        ),
        // ignore: avoid_unnecessary_containers
        body: new Container(
            child: Column(children: <Widget>[
          Container(
            width: double.infinity,
            height: 250,
            decoration: new BoxDecoration(color: Colors.green[100]),
            //padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                    child: Container(
                        width: 400,
                        height: 300,
                        /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                        child:
                            Image.asset('images/logo.png', fit: BoxFit.fill))),
              ),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Color(0xff00c853),
                  width: 2,
                ),
              )),
              padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
              child: Text(
                widget.myUser.fName + " " + widget.myUser.lName,
                style: TextStyle(color: Colors.grey, fontSize: 25),
              )),
          Container(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
              child: Text(
                'Write your issue here:',
                style: TextStyle(color: Colors.grey, fontSize: 25),
              )),
          Container(
            margin: EdgeInsets.all(20.0),
            // hack textfield height
            padding: EdgeInsets.only(bottom: 20.0),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  messageText = val;
                });
              },
              maxLines: 10,
              decoration: InputDecoration(
                hintText:
                    "A Detailed Description of the issue that you have...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(5)),
            child: FlatButton(
              onPressed: () async {
                ReportController rc = ReportController();
                bool check = await rc.addIssue(widget.myUser, messageText);
                if (check) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => student_dashbord(widget.myUser)));
                }
              },
              child: Text(
                'report issue',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ])));
  }
}
