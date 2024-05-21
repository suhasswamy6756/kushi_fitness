//Made this file so it is easy to share certain variable values between pages
library globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:kushi_3/service/firestore_service.dart';
FirestoreService _firestoreService = FirestoreService();

dynamic userName = _firestoreService.getUserField(_firestoreService.getCurrentUserId()!, "full_name");
dynamic uid;
var stepsToday = 0;
bool dailyToken = false;
String date = "";
var countedSteps = 0;


generate40RupeeToken(){
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
    'UID': uid.toString(),
    'multiplier': 1.0,
    'source': 'Generated at $date',
  });
}

generate20RupeeToken(){
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference coins = firestore.collection("20RupeeTokens");
  // Specify your desired document name here
  Random random = Random();
  int randNum = random.nextInt(999999);
  List<int> bytes = utf8.encode(randNum.toString());
  var hash = sha256.convert(bytes);
  // Add data to the specified document
  coins.add({
    'Hash': hash.toString(),
    'UID': uid.toString(),
    'multiplier': 1.0,
    'source': 'Generated at $date',
  });
}

Future<int> get20CoinNumber(dynamic uid1) async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference coins = firestore.collection("20RupeeTokens");
  QuerySnapshot querySnapshot = await coins.where('UID', isEqualTo: uid1).get();
  return querySnapshot.size;
}

Future<int> get40CoinNumber(dynamic uid1) async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference coins = firestore.collection("40RupeeTokens");
  QuerySnapshot querySnapshot = await coins.where('UID', isEqualTo: uid1).get();
  return querySnapshot.size;
}
