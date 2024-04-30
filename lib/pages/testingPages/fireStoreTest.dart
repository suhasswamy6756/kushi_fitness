import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class FirestoreTestApp extends StatelessWidget {
  const FirestoreTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Example',
      home: FirestoreTest(),
    );
  }
}

class FirestoreTest extends StatefulWidget {
  const FirestoreTest({super.key});

  @override
  State<FirestoreTest> createState() => _FirestoreTestState();
}

class _FirestoreTestState extends State<FirestoreTest> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore Test"),
      ),
      body: StreamBuilder(
        stream: _firestore.collection("users").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          dev.log(streamSnapshot.data!.docs.toString());
          return Text("Firestore data be here.");
        },
      )
      // Add additional UI components here
    );
  }
}
