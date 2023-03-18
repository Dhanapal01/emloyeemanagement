import '../pages/addpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyALjN2U1ER3CcvM4EqM5ird2_ckxbMElJc",
          authDomain: "employee-ebbdc.firebaseapp.com",
          projectId: "employee-ebbdc",
          storageBucket: "employee-ebbdc.appspot.com",
          messagingSenderId: "793767189457",
          appId: "1:793767189457:web:cfea1e71b1012403999ef0",
          measurementId: "G-799B9P3BTV"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('Employee').snapshots();
    return MaterialApp(
      title: 'Employee Details',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: AddPage(),
    );
  }
}
