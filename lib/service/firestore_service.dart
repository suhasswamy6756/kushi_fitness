import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kushi_3/chat_application/helper/show_alert_dialog.dart';
import 'package:kushi_3/model/user_data.dart';
import 'package:kushi_3/model/user_model.dart';

// import '../chat_application/repository/firabase_storage_repository.dart';

final

class FirestoreService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  Map usernumber = {'phoneNumber': ''};

  Future<void> updateUserDocument(String uid,
      Map<String, dynamic> userData,BuildContext context) async {
    try {
      // Retrieve the document reference for the user
      DocumentReference userRef = FirebaseFirestore.instance.collection('users')
          .doc(uid);

      // Update or create the user document in Firestore
      await userRef.update(userData);
    } catch (e, stackTrace) {
      print('Error updating user document: $e');
      print(stackTrace); // Print stack trace for better error debugging
      // showAlertDialog(context: context, message: e.toString() );// Re-throw the error for handling at the calling site

      throw e;
    }
  }
  Future<void> updateReferDocument(String uid,
      Map<String, dynamic> userData,BuildContext context) async {
    try {
      // Retrieve the document reference for the user
      DocumentReference userRef = FirebaseFirestore.instance.collection('RefernEarn')
          .doc(uid);

      // Update or create the user document in Firestore
      await userRef.set(userData);
    } catch (e, stackTrace) {
      print('Error updating user document: $e');
      print(stackTrace); // Print stack trace for better error debugging
      // showAlertDialog(context: context, message: e.toString() );// Re-throw the error for handling at the calling site

      throw e;
    }
  }


  Future<String?> fetchFieldValue(String uid, String field) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users') // Assuming 'users' is your collection name
          .doc(uid) // Document ID is the user's UID
          .get();

      // Check if the document exists and contains the field
      if (documentSnapshot.exists) {
        Map<String, dynamic>? data = documentSnapshot.data() as Map<
            String,
            dynamic>?;

        if (data != null && data.containsKey(field)) {
          return data[field];
        }
      }

      // Document does not exist, field not found, or field value is null
      return null;
    } catch (e) {
      // Error occurred while fetching data
      print('Error fetching data: $e');
      return null;
    }
  }


  Future<void> updateUserField(String uid, String fieldName, dynamic fieldValue, BuildContext context) async {
    try {
      // Retrieve the document reference for the user
      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(uid);

      // Update the specific field of the user document in Firestore
      await userRef.set({fieldName: fieldValue});
    } catch (e, stackTrace) {
      print('Error updating user field: $e');
      print(stackTrace); // Print stack trace for better error debugging
      // showAlertDialog(context: context, message: e.toString() );// Re-throw the error for handling at the calling site

      throw e;
    }
  }


  Future<String?> fetchPhoneNumber(String userId) async {
    try {
      DocumentSnapshot docSnapshot =
      await _db.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> userData =
        docSnapshot.data() as Map<String, dynamic>;

        return userData['phoneNumber'] as String?;
      } else {
        return null; // User document with the given userId does not exist
      }
    } catch (e) {
      print('Error fetching phone number: $e');
      return null; // Error occurred while fetching phone number
    }
  }




  Future<void> addContactNumberToUserDocument(String phoneNumber,String emialId) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      DocumentReference userDocument =
      _db.collection('contact').doc(user.uid);

      try {
        // Update the user's document with the contact number
        await userDocument.set(
            {'phoneNumber': phoneNumber,'emailId':emialId}, SetOptions(merge: true));
      } catch (e) {
        print('Error adding contact number to user document: $e');
        // Handle error as needed
      }
    }
  }

  Future<List<String>> fetchDatabaseContacts() async {
    List<String> databaseContacts = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
          'contacts').get();
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        // Assume each document in the 'users' collection has a field named 'phoneNumber'
        String phoneNumber = docSnapshot.get('phoneNumber');
        databaseContacts.add(phoneNumber);
      }
    } catch (e) {
      print('Error fetching database contacts: $e');
    }
    return databaseContacts;
  }


  String? phoneNumberReturn(){
    return _auth.currentUser?.phoneNumber!;
  }

  // import 'package:firebase_auth/firebase_auth.dart';
  // import 'package:cloud_firestore/cloud_firestore.dart';



  Future<String?> getCurrentUserEmail() async {
    String? email;

    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the Firestore document for the current user
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        // Extract the email address from the document data
        email = userDoc.data()?['Email'];
      }
    } catch (e) {
      print('Error fetching current user email: $e');
    }

    return email;
  }

  uploadImagetoStorage(String childName,var file) async{
    UploadTask? uploadTask;
    if(file is File){
      uploadTask = _storage.ref().child(childName).putFile(file);
    }
    if(file is Uint8List){
      uploadTask = _storage.ref().child(childName).putData(file);
    }
    TaskSnapshot snapshot = await uploadTask!;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;

  }

  String? getCurrentUserId(){
    return _auth.currentUser!.uid;
  }



}

