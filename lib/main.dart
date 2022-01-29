// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:unipro/screens/login/loginview.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:provider/provider.dart';
import 'package:unipro/models/currentuser.dart';
//import 'package:unipro/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDFVBYJXmx_moNAyDJsoBhpZo-1dZpDhZo", // Your apiKey
      appId: "1:347631911187:web:07236528fd9a77fa08dae6", // Your appId
      messagingSenderId: "347631911187", // Your messagingSenderId
      projectId: "uasmapfinal", // Your projectId
    ),
  );
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}
