library SpendCoin;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as dev;
import 'globals.dart' as globals;

spendToken(int Price) async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference coins = firestore.collection("40RupeeTokens");
  CollectionReference twentyCoins = firestore.collection("20RupeeToken");
  CollectionReference halfCoins = firestore.collection("Half20");

  QuerySnapshot querySnapshot = await coins.where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString()).get();
  QuerySnapshot twentyQuery = await twentyCoins.where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString()).get();
  QuerySnapshot halfQuery =  await coins.where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString()).get();
  if(Price >= 40){
    if(querySnapshot.docs.isNotEmpty){
      DocumentSnapshot firstDocument = querySnapshot.docs.first;
      await coins.doc(firstDocument.id).delete();
      dev.log("Deleted 40 Rupee Token");
      Price -= 40;
      if(Price != 0){
        spendToken(Price);
      }
    }
    else if(twentyQuery.size >= 2){
      for(int i=0;i<2;i++){
        await twentyCoins.doc(twentyQuery.docs[i].id).delete();
        Price -= 20;
        dev.log("Deleted 20 Rupee Token");
      }
      if(Price != 0){
        spendToken(Price);
      }
    }
    else{
      dev.log("No coin found to delete");
    }
  }
  else if(Price >= 20){
    if(twentyQuery.docs.isNotEmpty){
      DocumentSnapshot firstDocument = twentyQuery.docs.first;
      await coins.doc(firstDocument.id).delete();
      dev.log("Deleted 20 Rupee Token");
      Price -= 20;
      if(Price != 0){
        spendToken(Price);
      }
    }
    else if(querySnapshot.docs.isNotEmpty){
      DocumentSnapshot firstDocument = querySnapshot.docs.first;
      await coins.doc(firstDocument.id).delete();
      dev.log("Deleted 40 Rupee Token");
      globals.generate20RupeeToken();
      dev.log("Generated 20 Rupee Token");
      Price -= 20;
      if(Price != 0){
        spendToken(Price);
      }
    }
  }
  else if(Price >= 10){
    if(halfQuery.docs.isNotEmpty){
      DocumentSnapshot firstDocument = halfQuery.docs.first;
      await coins.doc(firstDocument.id).delete();
      dev.log("Deleted Half coin");
      Price -= 10;
      if(Price != 0){
        spendToken(Price);
      }
    }
    else if(twentyQuery.docs.isNotEmpty){
      DocumentSnapshot firstDocument = twentyQuery.docs.first;
      await coins.doc(firstDocument.id).delete();
      dev.log("Deleted 20 Rupee Token");
      globals.generateHalfCoin();
      dev.log("Generated Half of a 20 Rupee Token");
      Price -= 10;
      if(Price != 0){
        spendToken(Price);
      }
    }
    else if(querySnapshot.docs.isNotEmpty){
      DocumentSnapshot firstDocument = querySnapshot.docs.first;
      await coins.doc(firstDocument.id).delete();
      dev.log("Deleted 40 Rupee Token");
      globals.generate20RupeeToken();
      dev.log("Generated 20 Rupee Token");
      globals.generateHalfCoin();
      dev.log("Generated Half of a 20 Rupee Token");
      Price -= 10;
      if(Price != 0){
        spendToken(Price);
      }
    }
  }
}