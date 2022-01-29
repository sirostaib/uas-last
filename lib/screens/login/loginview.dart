// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unipro/lecturer/lecturer_dashbord/lecturer_view.dart';
import 'package:unipro/studens/student_dashbord/dashbord_view.dart';
import 'package:unipro/screens/login/loginview_model.dart';
import 'package:unipro/models/currentuser.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';

// ignore: use_key_in_widget_constructors
class LoginDemo extends StatefulWidget {
  LoginDemo() {
    _deleteCacheDir();
  }
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

Future<void> _deleteCacheDir() async {
  Directory tempDir = await getTemporaryDirectory();

  if (tempDir.existsSync()) {
    tempDir.deleteSync(recursive: true);
  }
}

class _LoginDemoState extends State<LoginDemo> {
  //final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  bool loginValidate = true;
  User currentUser = User.copy();

  @override
  Widget build(BuildContext context) {
    loginValidate;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffaa00ff),
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                  child: Container(
                      width: 400,
                      height: 300,
                      /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                      child: Image.asset('images/logo.png', fit: BoxFit.fill))),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid Email'),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password'),
                onChanged: (val) {
                  setState(() {
                    password = val;
                    //print("password is: " + password);
                  });
                },

                /// obscureText: true,
              ),
            ),
            !loginValidate
                ? Text(
                    'Email or Password was Wrong!',
                    style: TextStyle(
                        color: Color.fromARGB(255, 247, 0, 0), fontSize: 14),
                  )
                : Text(""),
            FlatButton(
              onPressed: () {
                // FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.grey[800], fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.purpleAccent[700],
                  borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  //print("asdfasdfadsfasdfadf");

                  LoginController lc = LoginController();
                  currentUser = await lc.loginCheck(email, password);
                  setState(() {
                    loginValidate = !currentUser.loggedin;
                    print("Email is final: " + currentUser.email);
                    print("error is: " + currentUser.loggedin.toString());
                  });

                  // await _auth.signInWithEmailAndPassword(email, password);
                  if (currentUser.userType == "none") {
                    // error could not sign in!
                    print("it is falsseeeee!");
                    loginValidate = !currentUser.loggedin;
                    setState(() {
                      if (currentUser.userType == "none") loginValidate = false;
                    });

                    loginValidate = currentUser.loggedin;
                  } else if (currentUser.userType == "lecturer") {
                    loginValidate = true;
                    setState(() {});
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => lecturer_dashboard(currentUser)));
                  } else if (currentUser.userType == "student") {
                    loginValidate = true;
                    setState(() {});
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => student_dashbord(currentUser)));
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
