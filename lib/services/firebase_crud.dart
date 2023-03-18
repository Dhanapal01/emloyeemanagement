import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';

final CollectionReference _collection =
    FirebaseFirestore.instance.collection('Employee');

class FirebaseCrud {
//creating employee
  static Future<Response> addEmployee({
    required String name,
    required String position,
    required String contactno,
  }) async {
    Response response = Response();
    DocumentReference documentReference = _collection.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name.toUpperCase(),
      "position": position,
      "contact_no": contactno
    };

    // ignore: unused_local_variable
    var result = await documentReference.set(data).whenComplete(() {
      response.code = 200;
      response.message = "successfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  //sorting
  List<String> docids = [];
  Future getdocid() async {
    await FirebaseFirestore.instance
        .collection('Employee')
        .orderBy('employee_name', descending: true)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docids.add(document.reference.id);
            }));
  }

  //read employee
  static Stream<QuerySnapshot> readEmployee() {
    CollectionReference notesItemCollecion = _collection;

    return notesItemCollecion.snapshots();
  }

  //updateemployee
  static Future<Response> updateEmployee(
      {required String name,
      required String position,
      required String contactno,
      required String docId}) async {
    Response response = Response();
    DocumentReference documentReference = _collection.doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name.toUpperCase(),
      "position": position,
      "contact_no": contactno
    };
    await documentReference.update(data).whenComplete(() {
      response.code = 200;
      response.message = "successfully updated";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  //delete employee
  static Future<Response> deleteEmployee({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReference = _collection.doc(docId);
    await documentReference.delete().whenComplete(() {
      response.code = 200;
      response.message = "successfully deleted";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }
}
