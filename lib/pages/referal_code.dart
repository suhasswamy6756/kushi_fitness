import 'package:flutter/material.dart';
import 'package:kushi_3/components/mybutton.dart';
import 'package:kushi_3/pages/selectGender.dart';
import 'package:kushi_3/service/firestore_service.dart';

class ReferralScreen extends StatefulWidget {
  @override
  _ReferralScreenState createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  TextEditingController _referralController = TextEditingController();
  FirestoreService _firestoreService = FirestoreService();
  @override
  void dispose() {
    _referralController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Referral Code'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _referralController,
              decoration: InputDecoration(
                labelText: 'Enter Referral Code',
              ),
            ),
            SizedBox(height: 20),
            MyButton(text: 'Continue', onTap: (){

            }),
            SizedBox(height: 50,),
            TextButton(
              onPressed: () {
                final body = {
                  "refCode": _firestoreService.getCurrentUserId()!,
                  "email": _firestoreService.phoneNumberReturn(),
                  "date_created": DateTime.now(),
                  "referrals": <String>[],
                  "refEarnings": 0,
                };
                _firestoreService.updateReferDocument(_firestoreService.getCurrentUserId()!,body,context);


                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectGender(),
                  ),
                );
              },
              child: Text('No referral? Continue instead'),
            ),
          ],
        ),
      ),
    );
  }
}
