// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:unipro/screens/login/loginview.dart';
import 'package:unipro/studens/report_issue/report_issue_view.dart';
import '../models/currentuser.dart';

// ignore: use_key_in_widget_constructors, camel_case_types
class profile_view extends StatefulWidget {
  profile_view(this.myUser);
  User myUser;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<profile_view> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    var leading;
    return Scaffold(
        // ignore: duplicate_ignore
        appBar: AppBar(
          backgroundColor: Color(0xFF059943),
          title: Text(widget.myUser.fName + " Profile"),
        ),
        body: new Container(

            // ignore: duplicate_ignore
            child: Column(children: <Widget>[
          Container(
            width: double.infinity,
            height: 250,
            decoration: new BoxDecoration(color: Colors.green[100]),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Center(
                child: Container(
                    width: 250,
                    height: 250,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child:
                        Image.asset('images/userlogo.png', fit: BoxFit.fill))),
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
            padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.email, size: 40, color: Colors.green),
                  title: Text(
                    widget.myUser.email,
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 30),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.phone, size: 40, color: Colors.green),
                  title: Text(
                    widget.myUser.phone,
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          widget.myUser.userType == "student"
              ? Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  report_issue_view(widget.myUser)));
                    },
                    child: Text(
                      'report issue',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              : Text(""),
          Container(
            margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
            height: 50,
            width: 110,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(5)),
            child: FlatButton(
              onPressed: () {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => LoginDemo()));
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(
                'logout',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            // ignore: deprecated_member_use
          ),
        ])));
  }
}
