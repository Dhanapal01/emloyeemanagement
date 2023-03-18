import 'dart:html';
import 'dart:math';

import 'package:crudoperation1/pages/listpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudoperation1/services/firebase_crud.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crudoperation1/models/employee.dart';
import '../pages/editpage.dart';
import '../pages/addpage.dart';
import '../pages/listpage.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  List name = [];

  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('Employee')
        .where('position', isEqualTo: query)
        .get();
    setState(() {
      name = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("search the employee details"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => AddPage(),
                ),
                (route) =>
                    false, //if you want to disable back feature set to false
              );
            },
          ),
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search here",
                icon: Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                )),
            onChanged: (query) {
              searchFromFirebase(query);
            },
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: name.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(name[index]['employee_name'],
                        style: const TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                        )),
                    subtitle: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Contact Number:" + name[index]['contact_no'],
                              style: const TextStyle(fontSize: 14)),
                          Text("Position:" + name[index]['position'],
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  );
                })),
      ]),
    );
  }
}
