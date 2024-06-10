import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kushi_3/components/message.dart';
import 'package:kushi_3/components/mybutton.dart';
import 'package:kushi_3/model/user_data.dart';
import 'package:kushi_3/pages/signin.dart';
import 'package:kushi_3/service/firestore_service.dart';
import 'package:pinput/pinput.dart';

import '../model/globals.dart';

class OTPVerificationPage extends StatefulWidget {


  const OTPVerificationPage({
    super.key,

  });

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  late List<TextEditingController> _controllers;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (index) => TextEditingController());
  }

  @override
  // void dispose() {
  //   for (var controller in _controllers) {
  //     controller.dispose();
  //   }
  //   // userDataMap.clear();
  //   super.dispose();
  // }
  Future<bool> _checkUserExists(String uid) async {
    try {
      final DocumentSnapshot snapshot = await firebaseFirestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return true;
        // Navigate to main activity
        // Navigator.pushNamed(context, '/test_page');
      } else {
        print('User does not exist in Firestore');

        return false;
        // Navigator.pushNamed(context, '/referalpage');
        //
      }
    } catch (e) {
      print('Error checking user existence: $e');
    }
    return false;

  }

  Future<bool> _checkRefernEarn(String uid)async{
    try{
      final DocumentSnapshot snapshot = await firebaseFirestore.collection("RefernEarn").doc(uid).get();
      if(snapshot.exists){
        print('refer collection already present');
        return true;
      }else{
        return false;
      }
    }catch (e){
      print('Error : $e');
    }
    return false;
  }
  void createReferCollection() async {
    CollectionReference profileRef =
    FirebaseFirestore.instance.collection("ReferEarn");
    final body = {
      "refCode": auth.currentUser!.uid,
      "email": auth.currentUser!.phoneNumber,
      "date_created": DateTime.now(),
      "referals": <String>[],
      "refEarnings": 0
    };

    await Future.delayed(const Duration(seconds: 2));

    profileRef.add(body);
  }




  @override
  Widget build(BuildContext context) {
    var code ="";
    final String data = ModalRoute.of(context)!.settings.arguments as String;
    // final String data = "suhas";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                child: Column(
                  children: [
                    Text(
                      "Phone Verification",
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 24.7,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      "We sent a code to your number ",
                      style: GoogleFonts.openSans(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 100),
                      child: Row(
                        children: [
                          Text(
                            data,
                            style: GoogleFonts.openSans(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/phoneVerification');

                              },
                              child: Text(
                                "Change",
                                style: GoogleFonts.poppins(
                                  color : Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 1.0,

                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            Pinput(
              length:6,
              showCursor:true,
              onChanged: (value){
                  code = value;

              },

            ),
            const SizedBox(height: 20.0),
            MyButton(text: "Verify OTP", onTap: ()async{
                 userDataMap['phoneNumber']=data;






              try{
                PhoneAuthCredential credential =  PhoneAuthProvider.credential(verificationId: SignIn.verify, smsCode: code);
               await auth.signInWithCredential(credential);
               // _firestoreService.updateUserField(_firestoreService.getCurrentUserId()!,'phoneNumber' ,data, context);
               if(await _checkRefernEarn(_firestoreService.getCurrentUserId()!)==false){
                 final body = {
                   "refCode": _firestoreService.getCurrentUserId()!,
                   "email": _firestoreService.phoneNumberReturn(),
                   "date_created": DateTime.now(),
                   "referrals": <String>[],
                   "refEarnings": 0,
                 };

                 _firestoreService.updateReferDocument(_firestoreService.getCurrentUserId()!,body,context);
               }

               if(await _checkUserExists(_firestoreService.getCurrentUserId()!) == false){
                 Navigator.pushNamedAndRemoveUntil(context, '/referalpage',(route) => false,arguments: userDataMap);
               }else{
                 Navigator.pushNamedAndRemoveUntil(context, "/test_page", (route) => false);
               }


                //    _firestoreService.setUserDocument(_firestoreService.getCurrentUserId()!, userData, context)


              }catch(e){
                  showMessage(context, e.toString());
              }


            })
          ],
        ),
      ),
    );
  }

}