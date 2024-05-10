import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class RefProvider extends ChangeNotifier {


  String message = "";

  CollectionReference profileRef =
  FirebaseFirestore.instance.collection("ReferEarn");

  FirebaseAuth auth = FirebaseAuth.instance;

  setReferral(String refCode) async {

    notifyListeners();

    try {
      final value = await profileRef.where("refCode", isEqualTo: refCode).get();

      if (value.docs.isEmpty) {
        ///ref code is not available
        message = 'Refcode is not available';

        notifyListeners();
      } else {
        /// It exists
        final data = value.docs[0];

        ///Get referrals
        List referrals = data.get("referals");

        referrals.add(auth.currentUser!.email);

        ///Update the ref earning
        final body = {
          "referals": referrals,
          "refEarnings": data.get("refEarnings") + 500
        };

        await profileRef.doc(data.id).update(body);

        message = "Ref success";

        notifyListeners();
      }
    } on FirebaseException catch (e) {
      message = e.message.toString();
      
      notifyListeners();
    }
  }
}