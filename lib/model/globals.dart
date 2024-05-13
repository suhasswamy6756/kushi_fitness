//Made this file so it is easy to share certain variable values between pages
library globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';

dynamic userName = "Name";
dynamic uid;
var stepsToday = 0;
bool dailyToken = false;
String date = "";
var lastSteps = 0;
var countedSteps = 0;

generate40RupeeToken(){
  developer.log("Generating 40 Rupee Token");
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference coins = firestore.collection("40RupeeTokens");
 // Specify your desired document name here
  Random random = Random();
  int randNum = random.nextInt(999999);
  List<int> bytes = utf8.encode(randNum.toString());
  var hash = sha256.convert(bytes);

  // Add data to the specified document
  coins.add({
    'Hash': hash.toString(),
    'UID': FirebaseAuth.instance.currentUser!.uid.toString(),
    'multiplier': 1.0,
    'source': 'Generated at $date',
  });
}

generate20RupeeToken(){
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference coins = firestore.collection("20RupeeToken");
  // Specify your desired document name here
  Random random = Random();
  int randNum = random.nextInt(999999);
  List<int> bytes = utf8.encode(randNum.toString());
  var hash = sha256.convert(bytes);
  // Add data to the specified document
  coins.add({
    'Hash': hash.toString(),
    'UID': FirebaseAuth.instance.currentUser!.uid.toString(),
    'multiplier': 1.0,
    'source': 'Generated at $date',
  });
}

Future<int> get20CoinNumber() async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference coins = firestore.collection("20RupeeToken");
  QuerySnapshot querySnapshot = await coins.where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString()).get();
  return querySnapshot.size;
}

Future<int> get40CoinNumber() async{
  developer.log("Getting 40 tokens");
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference coins = firestore.collection("40RupeeTokens");
  QuerySnapshot querySnapshot = await coins.where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString()).get();
  developer.log("Getting 40 tokens");
  return querySnapshot.size;
}