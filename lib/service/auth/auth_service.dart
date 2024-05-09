import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kushi_3/pages/mainactivity.dart';
import 'package:kushi_3/pages/selectGender.dart';

class AuthService extends ChangeNotifier{
  CollectionReference profileRef =
  FirebaseFirestore.instance.collection("ReferEarn");
  // instance for auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance for firebase_firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Future<UserCredential> signInWithEmailandPassword(
  //     String email, String password) async {
  //   try {
  //     UserCredential userCredential = await _firebaseAuth
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     // Check if the user document already exists in Firestore
  //
  //     return userCredential;
  //   } on FirebaseAuthException catch (e) {
  //     throw Exception(e.code);
  //   }
  // }

  // signInWithGoogle(BuildContext context) async{
  //     final FirebaseAuth _auth = FirebaseAuth.instance;
  //     try{
  //       final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  //       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //       final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication?.idToken,accessToken: googleSignInAuthentication?.accessToken);
  //       UserCredential result = await _auth.signInWithCredential(credential);
  //       User? userDetails = result.user;
  //       if(result!=null){
  //         Map<String,dynamic> userInfo ={
  //           "Email" :userDetails!.email,
  //           "Name": userDetails!.displayName,
  //           "imgUrl":userDetails.photoURL,
  //           "uid":userDetails.uid,
  //         };
  //         _firestore.collection("users").doc(userDetails.uid).set(userInfo,SetOptions(merge: true)).then((value) => {
  //           Navigator.push(context, MaterialPageRoute(builder: (context)=> const SelectGender()))
  //         });
  //     }
  //
  //     }on Exception catch(e){
  //       print(e.toString());
  //     }
  // }


  // create user
  // Future<UserCredential> signUpWithEmailandPassword(String email,String password,String name,String phoneNumber) async{
  //   try{
  //     UserCredential userCredential =
  //     await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  //     _firestore.collection('users').doc(userCredential.user!.uid).set({
  //       "uid":userCredential.user!.uid,
  //       "Email":email,
  //       "Name":name,
  //       "PhoneNumber":phoneNumber,
  //     },);
  //
  //     return userCredential;
  //   }on FirebaseAuthException catch(e){
  //     throw Exception(e.code);
  //   }
  // }



  void signOut() async {
    // await GoogleSignIn().signOut(); // Sign out from Google
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase Authentication
  }



}