library SpendCoin;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as dev;

spendToken(int Price) async{
  if(Price >= 40){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference coins = firestore.collection("40RupeeTokens");
    QuerySnapshot querySnapshot = await coins.where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString()).get();
    if(querySnapshot.docs.isNotEmpty){
      DocumentSnapshot firstDocument = querySnapshot.docs.first;
      await coins.doc(firstDocument.id).delete();
      dev.log("Deleted 40 Rupee Token");
    }
    else{
      dev.log("No coin found to delete");
    }
  }
}